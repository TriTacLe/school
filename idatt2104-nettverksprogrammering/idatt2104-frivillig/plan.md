# Implementation Plan - crdt-collab

Three-person P2P collaborative text editor. RGA CRDT, gossip network, ratatui TUI.
Estimated effort: ~35 hours per person.

**Owners:** Tri (networking), Yazan (RGA), Shakti (TUI).

---

## Architecture

```
+---------------------+       channels       +---------------------+
|    demo (binary)    |  <-Op-  net::Peer  ->|    net (lib)        |
|  app.rs  (Shakti)   |  ->Op->              |  peer.rs   (Tri)    |
|  editor.rs (Shakti) |                      |  gossip.rs (Tri)    |
|  bridge.rs (Shakti) |                      |  anti_entropy (Tri) |
|  main.rs   (Tri)    |                      |  journal.rs (Tri)   |
+---------------------+                      +---------------------+
         |                                            |
         v                                            v
+---------------------+                      +--------+------------+
|    rga (lib)        |<---------------------| wire.rs: Msg<Op>    |
|  rga.rs   (Yazan)   |  Rga::apply(op)      | bincode frames      |
|  traits.rs  (Tri)   |                      +---------------------+
|  clock.rs   (Tri)   |
|  replica.rs (Tri)   |
+---------------------+
```

Data flow for a local keypress:

```
keypress -> bridge.rs -> Rga::local_insert -> Op
         -> app.rs sends Op on op_tx channel
         -> net/peer.rs receives Op
         -> gossip.rs broadcasts OpBroadcast to all TCP peers
         -> remote peer receives -> Rga::apply -> TUI redraw
```

---

## Frozen contracts (do not change after merge)

### CmRdt trait (done)

```rust
pub trait CmRdt {
    type Op;
    fn apply(&mut self, op: Self::Op);
}
```

### Rga public API (Yazan must stabilise before Shakti starts bridge.rs)

```rust
impl Rga {
    pub fn new(replica: ReplicaId) -> Self;
    pub fn local_insert(&mut self, pos: usize, value: char) -> Op;
    pub fn local_delete(&mut self, pos: usize) -> Result<Op, RgaError>;
    pub fn text(&self) -> String;
    // CmRdt impl:
    pub fn apply(&mut self, op: Op);
}
```

### Channel interface between net and demo (agree before implementing either side)

```rust
// In main.rs (Tri wires up):
let (to_net_tx, to_net_rx) = mpsc::channel::<rga::Op>(256);   // app -> net
let (from_net_tx, from_net_rx) = mpsc::channel::<rga::Op>(256); // net -> app

// Tri's peer::start() receives to_net_rx and from_net_tx.
// Shakti's app::run() receives to_net_tx and from_net_rx.
```

### Msg<O> wire enum (frozen - adding variants breaks existing peers)

```rust
pub enum Msg<O> {
    Hello { replica_id: String },
    Bye,
    OpBroadcast(O),
    VectorSync { vector: HashMap<String, u64> },  // anti-entropy step 1
    StateSync { payload: Vec<u8> },               // anti-entropy step 2
    Ack { replica_id: String, lamport: u64 },
}
```

---

## Yazan - RGA data structure

**Files owned:** `crates/rga/src/rga.rs`, `crates/rga/tests/rga_props.rs`, `crates/rga/benches/rga_bench.rs`

**What is already done:** `rga.rs` has `NodeId`, `Node`, `Op`, `Rga`, `local_insert`, `local_delete`, `text`, and `CmRdt::apply`. Verify before moving on.

### Task 1 - Verify correctness of apply

Read `docs/algorithms.md` §3 and `docs/correctness.md` before touching anything.

The tiebreak loop in `apply` must satisfy: for an Insert at position `after`, scan right and skip all nodes with `id > new_id` (higher priority). Lower `NodeId` means inserted further right. The current implementation does this:

```rust
while insert_pos < self.nodes.len() && self.nodes[insert_pos].id > id {
    insert_pos += 1;
}
```

Confirm this matches `docs/algorithms.md` lines 261-265 exactly.

### Task 2 - Add serde support check for StateSync payload

`Rga` derives `Serialize, Deserialize`. The net crate encodes state for `StateSync` like this:

```rust
// In anti_entropy.rs (Tri writes this):
let payload = bincode::serde::encode_to_vec(&rga, bincode::config::standard())?;
let msg = Msg::StateSync { payload };

// On receive:
let (rga_state, _): (Rga, _) =
    bincode::serde::decode_from_slice(&payload, bincode::config::standard())?;
```

You do not need to add `#[derive(Encode, Decode)]`. `Serialize + Deserialize` is enough because the workspace uses `bincode = { version = "2", features = ["serde"] }`.

Confirm `cargo check -p rga` passes with the current derives.

### Task 3 - Property tests

File: `crates/rga/tests/rga_props.rs`

```rust
use proptest::prelude::*;
use rga::{replica::ReplicaId, rga::Rga};

fn arb_ascii() -> impl Strategy<Value = char> {
    prop::char::range('a', 'z')
}

proptest! {
    #![proptest_config(ProptestConfig::with_cases(256))]

    /// Any permutation of op delivery must converge to the same text.
    #[test]
    #[ignore]
    fn convergence_under_shuffle(
        chars in prop::collection::vec(arb_ascii(), 1..20usize),
        seed in 0u64..u64::MAX,
    ) {
        let mut rga_a = Rga::new(ReplicaId::new());
        let mut rga_b = Rga::new(ReplicaId::new());

        let mut ops = vec![];
        for (i, c) in chars.iter().enumerate() {
            ops.push(rga_a.local_insert(i, *c));
        }

        // Shuffle ops before applying to rga_b.
        use std::collections::hash_map::DefaultHasher;
        use std::hash::{Hash, Hasher};
        let mut order: Vec<usize> = (0..ops.len()).collect();
        // Simple deterministic shuffle from seed.
        for i in (1..order.len()).rev() {
            let mut h = DefaultHasher::new();
            (seed + i as u64).hash(&mut h);
            let j = h.finish() as usize % (i + 1);
            order.swap(i, j);
        }
        for idx in order {
            rga_b.apply(ops[idx].clone());
        }

        prop_assert_eq!(rga_a.text(), rga_b.text());
    }

    /// Applying the same op twice must be a no-op (idempotent delete).
    #[test]
    #[ignore]
    fn idempotent_delete(chars in prop::collection::vec(arb_ascii(), 1..10usize)) {
        let mut rga = Rga::new(ReplicaId::new());
        for (i, c) in chars.iter().enumerate() {
            rga.local_insert(i, *c);
        }
        let del = rga.local_delete(0).unwrap();
        let before = rga.text();
        rga.apply(del); // second apply - tombstone already set
        prop_assert_eq!(rga.text(), before);
    }

    /// Two replicas with concurrent inserts converge.
    #[test]
    #[ignore]
    fn concurrent_inserts_converge(
        a_char in arb_ascii(),
        b_char in arb_ascii(),
    ) {
        let mut a = Rga::new(ReplicaId::new());
        let mut b = Rga::new(ReplicaId::new());

        let op_a = a.local_insert(0, a_char);
        let op_b = b.local_insert(0, b_char);

        a.apply(op_b.clone());
        b.apply(op_a.clone());

        prop_assert_eq!(a.text(), b.text());
    }
}
```

Run locally: `cargo test -p rga --test rga_props -- --ignored`

### Task 4 - Bench body

File: `crates/rga/benches/rga_bench.rs`

Fill in the bench body (the harness scaffold is already there):

```rust
use criterion::{black_box, criterion_group, criterion_main, Criterion};
use rga::{replica::ReplicaId, rga::Rga};

fn bench_apply(c: &mut Criterion) {
    let mut rga = Rga::new(ReplicaId::new());
    // Pre-insert 100 chars so the doc is non-trivial.
    for i in 0..100 {
        rga.local_insert(i, 'x');
    }
    // Prepare an op to apply repeatedly.
    let op = rga.local_insert(50, 'z');

    c.bench_function("rga::apply insert mid-doc", |b| {
        b.iter(|| {
            let mut r = rga.clone();
            r.apply(black_box(op.clone()));
        })
    });
}

criterion_group!(benches, bench_apply);
criterion_main!(benches);
```

### Before you open a PR

- [ ] `cargo test -p rga` passes (fast tests)
- [ ] `cargo test -p rga --test rga_props -- --ignored` passes (property tests)
- [ ] `cargo clippy -p rga -- -D warnings` clean
- [ ] `cargo fmt --check` clean

---

## Tri - Networking

**Files owned:** `crates/net/src/peer.rs`, `crates/net/src/gossip.rs`, `crates/net/src/anti_entropy.rs`, `crates/net/src/journal.rs`, `crates/net/tests/three_peer.rs`, `crates/demo/src/main.rs`

**What is already done:** `traits.rs`, `clock.rs`, `replica.rs`, `wire.rs` (with `VectorSync` added), `config.rs`.

### Task 1 - peer.rs

Manages TCP connections. One accept loop for inbound. One connect task per configured peer address. Each connected peer gets a read task that pushes `Msg<Op>` into a shared `mpsc`, and a write half stored in a shared map.

Add `futures = "0.3"` to `crates/net/Cargo.toml` before implementing this file - `SinkExt` and `StreamExt` are not in tokio itself.

```toml
# crates/net/Cargo.toml - add:
futures = "0.3"
```

```rust
use std::collections::HashMap;
use std::sync::Arc;

use futures::{SinkExt, StreamExt};
use tokio::net::{TcpListener, TcpStream};
use tokio::sync::{mpsc, Mutex};
use tokio_util::codec::{FramedRead, FramedWrite, LengthDelimitedCodec};

use crate::config::PeerConfig;
use crate::wire::Msg;
use rga::rga::Op;

type WriteTx = mpsc::Sender<Msg<Op>>;

/// Shared write channels, keyed by replica_id string.
pub type PeerMap = Arc<Mutex<HashMap<String, WriteTx>>>;

pub async fn start(
    config: PeerConfig,
    inbound_tx: mpsc::Sender<Op>,    // ops from network -> app
    outbound_rx: Arc<Mutex<mpsc::Receiver<Op>>>, // ops from app -> network
) -> anyhow::Result<()> {
    let peers: PeerMap = Arc::new(Mutex::new(HashMap::new()));

    // Accept loop.
    let listener = TcpListener::bind(config.listen).await?;
    let peers_accept = peers.clone();
    let inbound_accept = inbound_tx.clone();
    tokio::spawn(async move {
        loop {
            if let Ok((stream, _addr)) = listener.accept().await {
                let peers = peers_accept.clone();
                let tx = inbound_accept.clone();
                tokio::spawn(handle_connection(stream, peers, tx));
            }
        }
    });

    // Outbound connect tasks.
    for peer_addr in config.peers {
        let peers = peers.clone();
        let tx = inbound_tx.clone();
        tokio::spawn(async move {
            // Retry with backoff until connected.
            let mut delay = tokio::time::Duration::from_millis(500);
            loop {
                match TcpStream::connect(peer_addr).await {
                    Ok(stream) => {
                        handle_connection(stream, peers.clone(), tx.clone()).await;
                        break;
                    }
                    Err(_) => {
                        tokio::time::sleep(delay).await;
                        delay = (delay * 2).min(tokio::time::Duration::from_secs(10));
                    }
                }
            }
        });
    }

    // Broadcast loop: read from outbound_rx, send to all connected peers.
    loop {
        let op = {
            let mut rx = outbound_rx.lock().await;
            rx.recv().await
        };
        if let Some(op) = op {
            let msg = Msg::OpBroadcast(op);
            let mut map = peers.lock().await;
            map.retain(|_, tx| tx.try_send(msg.clone()).is_ok());
        }
    }
}

async fn handle_connection(
    stream: TcpStream,
    peers: PeerMap,
    inbound_tx: mpsc::Sender<Op>,
) {
    let (read_half, write_half) = stream.into_split();
    let mut framed_read = FramedRead::new(read_half, LengthDelimitedCodec::new());
    let mut framed_write = FramedWrite::new(write_half, LengthDelimitedCodec::new());

    // Write channel for this peer.
    let (write_tx, mut write_rx) = mpsc::channel::<Msg<Op>>(64);

    // Spawn writer task.
    tokio::spawn(async move {
        while let Some(msg) = write_rx.recv().await {
            let bytes = bincode::serde::encode_to_vec(&msg, bincode::config::standard())
                .expect("encode failed");
            if framed_write.send(bytes.into()).await.is_err() {
                break;
            }
        }
    });

    // Read loop.
    let mut replica_id: Option<String> = None;
    while let Some(Ok(frame)) = framed_read.next().await {
        let msg: Msg<Op> = match bincode::serde::decode_from_slice(&frame, bincode::config::standard()) {
            Ok((m, _)) => m,
            Err(_) => continue,
        };
        match msg {
            Msg::Hello { replica_id: rid } => {
                replica_id = Some(rid.clone());
                peers.lock().await.insert(rid, write_tx.clone());
            }
            Msg::OpBroadcast(op) => {
                let _ = inbound_tx.send(op).await;
            }
            Msg::Bye => break,
            _ => {} // VectorSync / StateSync handled by anti_entropy
        }
    }

    // Clean up.
    if let Some(rid) = replica_id {
        peers.lock().await.remove(&rid);
    }
}
```

### Task 2 - gossip.rs

Causal buffer: buffer ops that arrive before their causal predecessor, release in lamport order once the gap is filled.

```rust
use std::collections::{BTreeMap, HashSet};
use rga::rga::{NodeId, Op};

/// Tracks per-replica sequence progress and buffers out-of-order ops.
pub struct CausalBuffer {
    /// Highest lamport clock seen per replica (replica_id string -> lamport value).
    seen: BTreeMap<String, u64>,
    /// Ops waiting for their predecessor: keyed by the lamport they need first.
    pending: BTreeMap<u64, Vec<Op>>,
    /// Dedup: NodeIds already applied.
    applied: HashSet<NodeId>,
}

impl CausalBuffer {
    pub fn new() -> Self {
        Self {
            seen: BTreeMap::new(),
            pending: BTreeMap::new(),
            applied: HashSet::new(),
        }
    }

    /// Push a received op. Returns the ordered list of ops ready to apply.
    pub fn push(&mut self, op: Op) -> Vec<Op> {
        let id = match &op {
            Op::Insert { id, .. } => *id,
            Op::Delete { id } => *id,
        };

        // Deduplicate.
        if self.applied.contains(&id) {
            return vec![];
        }

        let lamport = id.lamport.value();
        let replica_key = id.replica.to_string();

        // Simple causal check: we accept an op if we have already seen lamport-1
        // from this replica, OR if lamport == 1 (first op from this replica).
        let last_seen = self.seen.get(&replica_key).copied().unwrap_or(0);
        if lamport == last_seen + 1 || lamport <= last_seen {
            self.apply_op(op)
        } else {
            self.pending.entry(lamport).or_default().push(op);
            vec![]
        }
    }

    fn apply_op(&mut self, op: Op) -> Vec<Op> {
        let id = match &op {
            Op::Insert { id, .. } => *id,
            Op::Delete { id } => *id,
        };
        let lamport = id.lamport.value();
        let replica_key = id.replica.to_string();

        self.applied.insert(id);
        self.seen
            .entry(replica_key)
            .and_modify(|v| *v = (*v).max(lamport))
            .or_insert(lamport);

        let mut ready = vec![op];

        // Release any pending ops whose turn has come.
        let next = lamport + 1;
        if let Some(ops) = self.pending.remove(&next) {
            for queued in ops {
                ready.extend(self.apply_op(queued));
            }
        }

        ready
    }
}
```

### Task 3 - anti_entropy.rs

Two-step: send version vector every 2s, receive vector from peer, reply with full state if peer is behind.

```rust
use std::collections::HashMap;
use std::sync::Arc;
use std::time::Duration;

use tokio::sync::Mutex;
use rga::rga::Rga;
use crate::peer::PeerMap;
use crate::wire::Msg;
use rga::rga::Op;

// NOTE: Yazan must add this method to Rga in rga.rs before anti_entropy compiles.
// `nodes` is pub(crate) so net cannot access it directly.
// Add to rga.rs:
//
//   pub fn version_vector(&self) -> std::collections::HashMap<String, u64> {
//       self.nodes.iter().fold(HashMap::new(), |mut acc, n| {
//           let key = n.id.replica.to_string();
//           let lam = n.id.lamport.value();
//           acc.entry(key).and_modify(|v| *v = (*v).max(lam)).or_insert(lam);
//           acc
//       })
//   }
//   pub fn all_nodes(&self) -> &[crate::rga::Node] { &self.nodes }

/// Version vector: replica_id -> highest lamport seen.
pub fn build_vector(rga: &Rga) -> HashMap<String, u64> {
    rga.version_vector()
}

pub async fn run_anti_entropy(
    rga: Arc<Mutex<Rga>>,
    peers: PeerMap,
    interval_ms: u64,
) {
    let mut tick = tokio::time::interval(Duration::from_millis(interval_ms));
    loop {
        tick.tick().await;

        let vector = {
            let r = rga.lock().await;
            build_vector(&r)
        };

        let msg = Msg::<Op>::VectorSync { vector };
        let mut map = peers.lock().await;
        // Send to one random peer (or all - simpler for v1).
        for tx in map.values() {
            let bytes = bincode::serde::encode_to_vec(&msg, bincode::config::standard())
                .expect("encode");
            // tx is a channel to the write task; send raw Msg.
            let _ = tx.try_send(msg.clone());
            break; // one peer per tick is enough
        }
    }
}

/// Handle an incoming VectorSync from a peer.
/// Returns Some(StateSync) if the peer is missing ops, else None.
pub fn handle_vector_sync(
    local_rga: &Rga,
    remote_vector: &HashMap<String, u64>,
) -> Option<Msg<Op>> {
    let local_vector = build_vector(local_rga);
    let peer_is_behind = local_vector.iter().any(|(rid, &local_lam)| {
        remote_vector.get(rid).copied().unwrap_or(0) < local_lam
    });

    if peer_is_behind {
        let payload = bincode::serde::encode_to_vec(local_rga, bincode::config::standard())
            .expect("encode rga state");
        Some(Msg::StateSync { payload })
    } else {
        None
    }
}

/// Handle an incoming StateSync. Merges remote state into local by applying
/// all remote nodes not already present.
pub fn merge_state(local: &mut Rga, payload: &[u8]) {
    let (remote, _): (Rga, _) =
        bincode::serde::decode_from_slice(payload, bincode::config::standard())
            .expect("decode rga state");

    // Requires Yazan's `all_nodes()` accessor on Rga.
    let local_ids: std::collections::HashSet<_> =
        local.all_nodes().iter().map(|n| n.id).collect();

    for node in remote.all_nodes() {
        let node = node.clone();
        if !local_ids.contains(&node.id) {
            let op = if node.deleted {
                rga::rga::Op::Delete { id: node.id }
            } else {
                // We need to reconstruct `after` for Insert.
                // Simplest safe approach for v1: re-apply Insert with after=None
                // and let the tiebreak sort it. For correctness, store after in Node.
                rga::rga::Op::Insert {
                    id: node.id,
                    after: None, // TODO: store after in Node for exact replay
                    value: node.value,
                }
            };
            local.apply(op);
        }
    }
}
```

> **Note on merge_state**: The `after` field is not stored in `Node`, only in `Op::Insert`. For full anti-entropy correctness, either store `after: Option<NodeId>` in `Node`, or change `StateSync` to send a `Vec<Op>` instead of the full `Rga` struct. Decide with Yazan before implementing. The simplest fix is: `Node` stores `after: Option<NodeId>`.

### Task 4 - journal.rs

Atomic write-then-rename so a crash during flush never corrupts the state file.

```rust
use std::path::Path;
use anyhow::Result;
use rga::rga::Rga;
use rga::replica::ReplicaId;

#[derive(serde::Serialize, serde::Deserialize)]
struct JournalState {
    replica_id: String,
    rga: Rga,
}

/// Persist RGA + replica identity atomically.
pub fn save(rga: &Rga, replica_id: &ReplicaId, path: &Path) -> Result<()> {
    let state = JournalState {
        replica_id: replica_id.to_string(),
        rga: rga.clone(),
    };
    let json = serde_json::to_string_pretty(&state)?;
    let tmp = path.with_extension("tmp");
    std::fs::write(&tmp, &json)?;
    std::fs::rename(&tmp, path)?; // atomic on POSIX
    Ok(())
}

/// Load state from disk. Returns None if no file exists yet.
pub fn load(path: &Path) -> Result<Option<(Rga, ReplicaId)>> {
    if !path.exists() {
        return Ok(None);
    }
    let json = std::fs::read_to_string(path)?;
    let state: JournalState = serde_json::from_str(&json)?;
    let replica_id: ReplicaId = state.replica_id.parse()?;
    Ok(Some((state.rga, replica_id)))
}
```

### Task 5 - main.rs wiring (do this after Shakti has app::run signature stable)

```rust
#[tokio::main]
async fn main() -> Result<()> {
    tracing_subscriber::fmt::init();
    let args = Args::parse();

    let journal_path = std::path::PathBuf::from(&args.journal);

    // Load or create identity + RGA state.
    let (rga, replica_id) = net::journal::load(&journal_path)?
        .unwrap_or_else(|| {
            let rid = rga::replica::ReplicaId::new();
            (rga::rga::Rga::new(rid), rid)
        });

    tracing::info!(replica_id = %replica_id, "starting");

    // Channels between TUI and net.
    let (to_net_tx, to_net_rx) = tokio::sync::mpsc::channel::<rga::rga::Op>(256);
    let (from_net_tx, from_net_rx) = tokio::sync::mpsc::channel::<rga::rga::Op>(256);

    let peers: Vec<std::net::SocketAddr> = args
        .peer
        .iter()
        .filter_map(|s| s.parse().ok())
        .collect();

    let config = net::config::PeerConfig::new(
        args.listen.parse()?,
        peers,
        journal_path,
    );

    // Start networking.
    let rga_net = std::sync::Arc::new(tokio::sync::Mutex::new(rga.clone()));
    tokio::spawn(net::peer::start(
        config,
        from_net_tx,
        std::sync::Arc::new(tokio::sync::Mutex::new(to_net_rx)),
    ));

    // Run TUI.
    demo::app::run(rga, to_net_tx, from_net_rx, replica_id.to_string()).await?;

    Ok(())
}
```

### Task 6 - three_peer.rs integration test

```rust
// crates/net/tests/three_peer.rs
// Spins up 3 in-process peers with loopback TCP, types on peer A,
// asserts peers B and C converge to the same text.

#[tokio::test]
#[ignore]
async fn three_peers_converge() {
    // bind 3 listeners on 127.0.0.1:0 (OS picks port)
    // start 3 peer tasks with each other as peers
    // send 5 random ops through peer A's outbound channel
    // wait 200ms for gossip to propagate
    // assert all three RGA.text() are equal
}
```

### Before you open a PR (net)

- [ ] `cargo check -p net` clean
- [ ] `cargo clippy -p net -- -D warnings` clean
- [ ] `cargo test -p net` passes (any fast unit tests)
- [ ] `cargo test -p net --test three_peer -- --ignored` passes (after Yazan's RGA is merged)

---

## Shakti - TUI

**Files owned:** `crates/demo/src/app.rs`, `crates/demo/src/editor.rs`, `crates/demo/src/bridge.rs`

**Do not start bridge.rs until Yazan's `Rga` public API is stable (merged or confirmed via review).**

### What to build

Word-like feel: centered editing area, title bar, bottom status bar, visible cursor, optional line numbers.

```
+------------------------------------------+
| crdt-collab                   peers: 2   |  <- title bar (Block)
+------------------------------------------+
|                                          |
|  Hello, world!                           |  <- editor area (Paragraph)
|  |cursor here                            |     word wrap on
|                                          |
|                                          |
+------------------------------------------+
| replica: 0193fa..  ln:1 col:12  [synced] |  <- status line
+------------------------------------------+
```

### Task 1 - app.rs (event loop)

```rust
use crossterm::event::{self, Event, KeyCode, KeyModifiers};
use ratatui::{backend::CrosstermBackend, Terminal};
use rga::{replica::ReplicaId, rga::{Op, Rga}};
use tokio::sync::mpsc;

pub struct App {
    pub rga: Rga,
    pub cursor: usize,      // offset into visible text
    pub peer_count: usize,
    pub replica_id: String,
    pub dirty: bool,
    pub show_help: bool,
}

impl App {
    pub fn new(rga: Rga, replica_id: String) -> Self {
        Self {
            rga,
            cursor: 0,
            peer_count: 0,
            replica_id,
            dirty: false,
            show_help: false,
        }
    }
}

/// Main TUI loop. Call from main.rs after spawning net::peer::start.
pub async fn run(
    rga: Rga,
    op_tx: mpsc::Sender<Op>,
    mut op_rx: mpsc::Receiver<Op>,
    replica_id: String,
) -> anyhow::Result<()> {
    crossterm::terminal::enable_raw_mode()?;
    let stdout = std::io::stdout();
    let backend = CrosstermBackend::new(stdout);
    let mut terminal = Terminal::new(backend)?;
    terminal.clear()?;

    let mut app = App::new(rga, replica_id);

    loop {
        terminal.draw(|f| crate::editor::render(f, &app))?;

        // Non-blocking check for remote ops.
        while let Ok(op) = op_rx.try_recv() {
            app.rga.apply(op);
        }

        // Keyboard input with 16ms timeout (60fps).
        if event::poll(std::time::Duration::from_millis(16))? {
            if let Event::Key(key) = event::read()? {
                match (key.modifiers, key.code) {
                    (KeyModifiers::CONTROL, KeyCode::Char('q')) => break,
                    (KeyModifiers::NONE, KeyCode::Char('?')) => {
                        app.show_help = !app.show_help;
                    }
                    _ => {
                        if let Some(op) = crate::bridge::handle_key(&mut app, key) {
                            app.dirty = true;
                            let _ = op_tx.try_send(op);
                        }
                    }
                }
            }
        }
    }

    crossterm::terminal::disable_raw_mode()?;
    terminal.show_cursor()?;
    Ok(())
}
```

### Task 2 - editor.rs (rendering)

```rust
use ratatui::{
    layout::{Constraint, Direction, Layout, Rect},
    style::{Color, Modifier, Style},
    text::{Line, Span, Text},
    widgets::{Block, Borders, Paragraph, Wrap},
    Frame,
};

use crate::app::App;

pub fn render(f: &mut Frame, app: &App) {
    let area = f.area();

    // Three rows: title, editor, status.
    let chunks = Layout::default()
        .direction(Direction::Vertical)
        .constraints([
            Constraint::Length(1),  // title bar
            Constraint::Min(1),     // editor
            Constraint::Length(1),  // status bar
        ])
        .split(area);

    render_title(f, app, chunks[0]);
    render_editor(f, app, chunks[1]);
    render_status(f, app, chunks[2]);

    if app.show_help {
        render_help(f, area);
    }
}

fn render_title(f: &mut Frame, app: &App, area: Rect) {
    let peers = format!("peers: {}", app.peer_count);
    let title = Paragraph::new(Line::from(vec![
        Span::styled(
            " crdt-collab ",
            Style::default().fg(Color::White).add_modifier(Modifier::BOLD),
        ),
        Span::raw(" ".repeat(area.width.saturating_sub(14 + peers.len() as u16) as usize)),
        Span::styled(peers, Style::default().fg(Color::Gray)),
    ]))
    .style(Style::default().bg(Color::DarkGray));
    f.render_widget(title, area);
}

fn render_editor(f: &mut Frame, app: &App, area: Rect) {
    let text = app.rga.text();
    let block = Block::default().borders(Borders::ALL).title("Editor");
    let inner = block.inner(area);
    f.render_widget(block, area);

    // Build text with cursor marker.
    let visible: Vec<char> = text.chars().collect();
    let before: String = visible[..app.cursor.min(visible.len())].iter().collect();
    let after: String = visible[app.cursor.min(visible.len())..].iter().collect();

    let cursor_char = if app.cursor < visible.len() {
        visible[app.cursor].to_string()
    } else {
        " ".to_string()
    };

    let paragraph = Paragraph::new(Text::from(vec![Line::from(vec![
        Span::raw(before),
        Span::styled(cursor_char, Style::default().bg(Color::White).fg(Color::Black)),
        Span::raw(after),
    ])]))
    .wrap(Wrap { trim: false });

    f.render_widget(paragraph, inner);
}

fn render_status(f: &mut Frame, app: &App, area: Rect) {
    let short_id = &app.replica_id[..8.min(app.replica_id.len())];
    let sync_flag = if app.dirty { "modified" } else { "synced" };
    let status = format!(" replica: {}..  col:{}  [{}] ", short_id, app.cursor, sync_flag);
    let status_widget = Paragraph::new(status)
        .style(Style::default().fg(Color::White).bg(Color::DarkGray));
    f.render_widget(status_widget, area);
}

fn render_help(f: &mut Frame, area: Rect) {
    use ratatui::widgets::Clear;
    let help_area = Rect {
        x: area.width / 4,
        y: area.height / 4,
        width: area.width / 2,
        height: area.height / 2,
    };
    f.render_widget(Clear, help_area);
    let help = Paragraph::new(vec![
        Line::from("  Ctrl+Q   quit"),
        Line::from("  ?        toggle help"),
        Line::from("  arrows   move cursor"),
        Line::from("  Home/End start/end of line"),
        Line::from("  typing   insert character"),
        Line::from("  Backspace delete left"),
        Line::from("  Delete   delete right"),
    ])
    .block(Block::default().borders(Borders::ALL).title("Keys"));
    f.render_widget(help, help_area);
}
```

### Task 3 - bridge.rs (keyboard -> RGA op)

```rust
use crossterm::event::{KeyCode, KeyEvent, KeyModifiers};
use rga::rga::Op;

use crate::app::App;

/// Translate a key event into an RGA op and update cursor.
/// Returns Some(op) if an op was generated (to broadcast to network).
pub fn handle_key(app: &mut App, key: KeyEvent) -> Option<Op> {
    let text_len = app.rga.text().chars().count();

    match (key.modifiers, key.code) {
        // Insert character.
        (KeyModifiers::NONE | KeyModifiers::SHIFT, KeyCode::Char(c)) => {
            let op = app.rga.local_insert(app.cursor, c);
            app.cursor += 1;
            Some(op)
        }

        // Backspace: delete the character to the left.
        (KeyModifiers::NONE, KeyCode::Backspace) => {
            if app.cursor > 0 {
                app.cursor -= 1;
                app.rga.local_delete(app.cursor).ok().map(|op| op)
            } else {
                None
            }
        }

        // Delete: delete the character under the cursor.
        (KeyModifiers::NONE, KeyCode::Delete) => {
            if app.cursor < text_len {
                app.rga.local_delete(app.cursor).ok().map(|op| op)
            } else {
                None
            }
        }

        // Cursor movement.
        (KeyModifiers::NONE, KeyCode::Left) => {
            if app.cursor > 0 { app.cursor -= 1; }
            None
        }
        (KeyModifiers::NONE, KeyCode::Right) => {
            if app.cursor < text_len { app.cursor += 1; }
            None
        }
        (KeyModifiers::NONE, KeyCode::Home) => {
            app.cursor = 0;
            None
        }
        (KeyModifiers::NONE, KeyCode::End) => {
            app.cursor = text_len;
            None
        }

        _ => None,
    }
}
```

### Before you open a PR (TUI)

- [ ] `cargo check -p demo` clean
- [ ] `cargo clippy -p demo -- -D warnings` clean
- [ ] `cargo run -p demo -- --listen 127.0.0.1:4001` starts without panic, renders a window
- [ ] Cursor visible, backspace works, Ctrl+Q exits cleanly
- [ ] Wait for Tri's `net::peer::start` signature to be merged before finalising `main.rs` wiring

---

## PR order and merge conflict avoidance

The only file touched by multiple people is `crates/demo/src/main.rs` (Tri wires Shakti's `app::run`). Everything else is file-isolated.

| Order | Who | PR contains | Blocks |
|-------|-----|-------------|--------|
| 1 | Yazan | `rga.rs` (verify), `rga_props.rs`, `rga_bench.rs` | Unblocks Shakti's bridge.rs |
| 2 | Tri | `peer.rs`, `gossip.rs` | Unblocks integration test |
| 3 | Tri | `anti_entropy.rs`, `journal.rs` | Unblocks main.rs wiring |
| 4 | Shakti | `app.rs`, `editor.rs`, `bridge.rs` | Unblocks main.rs wiring |
| 5 | Tri | `main.rs` (final wiring) | Requires both #3 and #4 merged |
| 6 | Tri | `three_peer.rs` integration test | Requires all above merged |

**Rule**: open PRs in this order. Do not merge #5 until #3 and #4 are both merged.

### One decision needed before Tri implements anti_entropy.rs

The `merge_state` function needs `after: Option<NodeId>` stored in `Node` to replay inserts exactly. Ask Yazan to add `after: Option<NodeId>` to the `Node` struct in `rga.rs` before `StateSync` is used. This is a one-line change that affects only Yazan's file.

---

## Running the full demo

```bash
# Terminal 1
cargo run -p demo -- --listen 127.0.0.1:4001

# Terminal 2
cargo run -p demo -- --listen 127.0.0.1:4002 --peer 127.0.0.1:4001

# Terminal 3
cargo run -p demo -- --listen 127.0.0.1:4003 --peer 127.0.0.1:4001 --peer 127.0.0.1:4002
```

Or use `bash scripts/demo.sh` once it is written.

## Running tests

```bash
# Fast unit tests
cargo test --workspace

# Property-based convergence tests (slow, 256 cases)
cargo test --workspace -- --ignored

# Benchmarks
cargo bench
```
