---
type: reference
project: idatt2104
created: 2026-05-15
modified: 2026-05-15
tags: [architecture, diagrams, crdt, rust]
---

# Architecture - crate and data flow diagrams

## System overview - all crates

Three crates. Dependency direction: `crdt-client` -> `crdt-transport` -> `crdt-lib`. `crdt-lib` has no I/O, no tokio. Pure logic.

```mermaid
graph TD
    subgraph client["crdt-client (binary)"]
        MAIN[main.rs]
        APP[app.rs]
        BRIDGE[bridge.rs]
        VIEW[view.rs]
        EDITOR[views/editor.rs]
        PICKER[views/doc_picker.rs]
    end

    subgraph transport["crdt-transport"]
        TCP[tcp_peer.rs]
        ROUTER[msg_router.rs]
        SYNC[sync_tick.rs]
        SNAP[snapshot.rs]
        CODEC[msg_codec.rs]
        RID[replica_id.rs]
        MDNS[mdns.rs]
    end

    subgraph lib["crdt-lib (no I/O)"]
        REG[registry.rs]
        DOC[document.rs]
        RGA[rga.rs]
        VV[version_vector.rs]
        OPLOG[oplog.rs]
        OP[op.rs]
        CLOCK[clock.rs]
        ID[id.rs]
    end

    REMOTE1([peer A])
    REMOTE2([peer B])
    USER([keyboard])
    SCREEN([terminal])

    USER --> BRIDGE --> APP --> EDITOR --> SCREEN
    MAIN --> ROUTER
    APP -->|local_op_sender| ROUTER
    ROUTER -->|remote_op_sender| APP
    MAIN --> TCP
    TCP <-->|TCP frames| REMOTE1
    TCP <-->|TCP frames| REMOTE2
    TCP -->|inbound_sender| ROUTER
    ROUTER -->|per-peer mpsc| TCP
    SYNC -->|Hello via peer sender| TCP
    SNAP -.->|load/save| DOC
    RID -.->|load/create| CLOCK

    DOC --> RGA
    DOC --> VV
    DOC --> OPLOG
    DOC --> CLOCK
    OPLOG --> OP
    RGA --> ID
    RGA --> OP
    CLOCK --> ID
```

---

## crdt-lib - internal structure

Pure CRDT logic. `Document` is the only public facade the other crates use.

```mermaid
graph TD
    subgraph lib["crdt-lib"]
        DOC["document.rs\nDocument { replica_id, clock, oplog, rga, vv }"]
        RGA["rga.rs\nRga { nodes: HashMap<Id,RgaNode>, children: HashMap<Id,BTreeSet<Id>> }"]
        OPLOG["oplog.rs\nOpLog { ops: HashSet<Operation> }"]
        VV["version_vector.rs\nVersionVector { inner: HashMap<ReplicaId, u64> }"]
        CLOCK["clock.rs\nLamportClock { actor: ReplicaId, counter: u64 }"]
        OP["op.rs\nOperation::Insert { id, parent, ch }\nOperation::Delete { id, target }"]
        ID["id.rs\nId::Head | Id::Op(LamportClock)"]
    end

    DOC --> RGA
    DOC --> OPLOG
    DOC --> VV
    DOC --> CLOCK
    RGA --> ID
    RGA --> OP
    OPLOG --> OP
    CLOCK --> ID
```

### Local insert flow (insert_after)

```mermaid
flowchart LR
    A[insert_after parent ch] --> B[clock.tick\nreturns LamportClock id]
    B --> C[build Operation::Insert\nid parent ch]
    C --> D[oplog.insert op\nstores in HashSet]
    D --> E[rga.apply op\ninsert into tree]
    E --> F[vv.observe\nactor counter]
    F --> G[return Operation\ncaller broadcasts it]
```

### Remote apply flow (apply)

```mermaid
flowchart LR
    A[apply op] --> B[clock.witness op.id\nadvances clock if op is newer]
    B --> C{oplog.insert op\nalready seen?}
    C -->|duplicate| D[return false\nskip apply]
    C -->|new| E[rga.apply op]
    E --> F[vv.observe actor counter]
    F --> G[return true]
```

### ops_since - delta sync

```mermaid
flowchart LR
    A[ops_since remote_vv] --> B[oplog.ops iterator]
    B --> C{for each op\nremote_vv.has seen it?}
    C -->|yes| D[skip]
    C -->|no| E[include in result]
    E --> F[Vec of missing ops\nsent as StateSync]
```

---

## crdt-transport - internal structure

```mermaid
graph LR
    subgraph transport["crdt-transport"]
        CODEC["msg_codec.rs\nMsg enum + encode/decode\nPROTOCOL_VERSION\nlength-delimited framing"]
        RID["replica_id.rs\nload or create ReplicaId\nwrite to state.bin"]
        TCP["tcp_peer.rs\ndial - outbound + backoff\nlisten - accept inbound\nrun_conn - read/write loop"]
        ROUTER["msg_router.rs\nrun() event loop\non_inbound() dispatch\ndrain() causal buffer"]
        SYNC["sync_tick.rs\nperiodic Hello sender\nround-robin peer selection"]
        SNAP["snapshot.rs\nautosave every 30s\natomic write tmp+rename\nload on startup"]
    end

    CODEC --> TCP
    CODEC --> ROUTER
    RID -.->|used by| TCP
    TCP -->|PeerHandle| ROUTER
    TCP -->|inbound msg| ROUTER
    ROUTER -->|Msg per peer| TCP
    ROUTER -->|peers Arc| SYNC
    SYNC -->|Hello via peer sender| TCP
    SNAP -.->|Arc Mutex Document| ROUTER
```

### tcp_peer - connection lifecycle

```mermaid
flowchart TD
    subgraph dial["dial (outbound)"]
        D1[create outbound_sender / receiver]
        D2[register PeerHandle with router\nbefore spawning task]
        D3[tokio::spawn loop]
        D4{TcpStream::connect}
        D5[set_nodelay true]
        D6[get fresh VV from doc]
        D7[run_conn]
        D8[sleep backoff\nbackoff x2 up to 30s]

        D1 --> D2 --> D3 --> D4
        D4 -->|ok| D5 --> D6 --> D7 --> D8 --> D4
        D4 -->|err| D8
    end

    subgraph listen["listen (inbound)"]
        L1[TcpListener::accept loop]
        L2[set_nodelay true]
        L3[create outbound_sender / receiver]
        L4[send PeerHandle to router]
        L5[tokio::spawn run_conn]

        L1 --> L2 --> L3 --> L4 --> L5 --> L1
    end

    subgraph run_conn["run_conn (shared)"]
        R1[split stream into read + write halves]
        R2[wrap with FramedRead / FramedWrite codec]
        R3[send Hello with PROTOCOL_VERSION + VV]
        R4[tokio::select loop]
        R5[frame from reader -> decode -> inbound_sender]
        R6[msg from outbound_receiver -> encode -> writer]

        R1 --> R2 --> R3 --> R4
        R4 --> R5 --> R4
        R4 --> R6 --> R4
    end
```

### msg_router - event loop

```mermaid
flowchart TD
    START[run starts\nseq_expected = Map\ncausal_buf = Map\nincompatible_peers = Set\nown_seq = 0]

    START --> SEL{tokio::select}

    SEL -->|new_peer_receiver| NP[insert addr -> sender\ninto peers map]
    NP --> SEL

    SEL -->|inbound_receiver| IB[on_inbound addr msg]
    IB --> CHECK{addr in\nincompatible_peers?}
    CHECK -->|yes| SEL
    CHECK -->|no| MATCH{match msg}

    MATCH -->|OpBroadcast| OB{seq vs expected}
    OB -->|eq| DELIVER[send to remote_op_sender\napply to doc\ndrain causal_buf]
    OB -->|greater gap| BUFFER{buf len < 4096?}
    BUFFER -->|yes| INSERT[park in causal_buf]
    BUFFER -->|no| DROP[warn + drop]
    OB -->|less| SEEN[already seen, skip]
    DELIVER --> SEL
    INSERT --> SEL
    DROP --> SEL
    SEEN --> SEL

    MATCH -->|Hello| PV{protocol_version\n== PROTOCOL_VERSION?}
    PV -->|mismatch| BAN[add addr to\nincompatible_peers\nreturn]
    PV -->|match| DELTA[ops_since remote_vv\nsend StateSync if any missing]
    BAN --> SEL
    DELTA --> SEL

    MATCH -->|StateSync| SS[apply all ops to doc\nforward each to remote_op_sender\ndrain causal_buf per actor]
    SS --> SEL

    SEL -->|local_op_receiver| LO[own_seq++\napply to doc\nbuild OpBroadcast\nsend to all peers\nremove dead peers]
    LO --> SEL
```

### sync_tick flow

```mermaid
flowchart LR
    T[timer fires every 500ms] --> P[collect + sort peer addrs]
    P --> S[pick addr at tick_count mod len]
    S --> VV[lock doc\nget version_vector clone\ndrop lock]
    VV --> H[send Msg::Hello\nprotocol_version replica_id vv\nto selected peer]
    H --> R[peer runs on_inbound Hello\ncomputes ops_since our_vv\nsends back StateSync]
    R --> A[router applies missing ops\nforwards to TUI]
```

### snapshot - atomic write

```mermaid
flowchart LR
    A[autosave timer fires] --> B[lock doc\nops_all clone\ndrop lock]
    B --> C[bincode encode replica_id + ops]
    C --> D[OpenOptions write+create+truncate\nopen ops.bin.tmp]
    D --> E[write_all blob]
    E --> F[sync_all - flush to disk]
    F --> G[rename ops.bin.tmp -> ops.bin\natomic at OS level]
    G --> H["#[cfg(unix)]\nFile::open dir\nsync_all - flush dir entry"]
```

---

## crdt-client - internal structure

```mermaid
graph TD
    subgraph client["crdt-client"]
        MAIN["main.rs\nparse args\nload snapshot\ncreate docs + channels\nstart transport tasks\nrun app\nfinal snapshot save"]
        APP["app.rs\nApp { document, cursor, dirty }\nevent loop:\n- crossterm key events\n- remote_op try_recv\n- render each frame"]
        BRIDGE["bridge.rs\nhandle_key_event\nkey -> Option<Operation>\ncursor movement\ninsert/delete"]
        EDITOR["editor.rs\nratatui widgets\nrender doc text + cursor highlight"]
    end

    MAIN -->|tui_doc + channels| APP
    APP -->|key event| BRIDGE
    BRIDGE -->|Operation| APP
    APP -->|frame| EDITOR
    EDITOR -->|ratatui render| TERM([terminal])
```

### main.rs wiring sequence (startup)

```mermaid
sequenceDiagram
    participant M as main.rs
    participant RID as replica_id
    participant SNAP as snapshot
    participant DOC as Document x2
    participant ROUTER as msg_router
    participant SYNC as sync_tick
    participant TCP as tcp_peer
    participant APP as app.rs

    M->>RID: load_or_create from data_dir
    M->>SNAP: load from data_dir
    M->>DOC: create tui_doc + transport_doc
    M->>DOC: replay saved ops into both docs
    M->>ROUTER: start (inbound_rx, local_op_rx, remote_op_tx, transport_doc)
    M->>SYNC: start (replica_id, transport_doc, peers, 500ms)
    M->>SNAP: autosave (data_dir, replica_id, transport_doc, 30s)
    M->>TCP: listen on bound listener
    M->>TCP: dial each peer
    M->>APP: run (tui_doc, local_op_sender, remote_op_receiver)
    APP-->>M: returns on quit
    M->>SNAP: final save
```

---

## End-to-end flows

### Local keystroke - across all crates

```mermaid
sequenceDiagram
    participant K as keyboard
    participant Bridge as bridge.rs
    participant App as app.rs (tui_doc)
    participant Router as msg_router (transport_doc)
    participant TCP as tcp_peer
    participant Peer as remote peer

    K->>Bridge: KeyEvent Char 'a'
    Bridge->>Bridge: insert_at_cursor\nparent = id_at(cursor)
    Bridge->>App: tui_doc.insert_after(parent, 'a') -> Operation
    App->>App: cursor++, mark dirty
    App->>Router: local_op_sender.send(op)
    Router->>Router: own_seq++\ntransport_doc.apply(op)
    Router->>TCP: Msg::OpBroadcast { from, seq, op }
    TCP->>TCP: encode to bincode + 4-byte len
    TCP->>Peer: TCP bytes
```

### Remote op arrives - across all crates

```mermaid
sequenceDiagram
    participant Peer as remote peer
    participant TCP as tcp_peer
    participant Router as msg_router (transport_doc)
    participant App as app.rs (tui_doc)

    Peer->>TCP: TCP bytes
    TCP->>TCP: FramedRead.next() -> decode Msg::OpBroadcast
    TCP->>Router: inbound_sender.send((addr, msg))
    Router->>Router: check incompatible_peers
    Router->>Router: seq == expected?\ntransport_doc.apply(op)
    Router->>App: remote_op_sender.send(op)
    Note over App: next render frame
    App->>App: try_recv -> tui_doc.apply(op)
    App->>App: re-render with new text
```

### Anti-entropy - node catches up after reconnect

```mermaid
sequenceDiagram
    participant ST as sync_tick
    participant TCP as tcp_peer (us)
    participant Router as msg_router (them)
    participant App as app.rs (us)

    Note over ST: every 500ms
    ST->>TCP: Msg::Hello { vv: our_vv }
    TCP->>Router: inbound Hello
    Router->>Router: ops_since(our_vv)\nfinds ops we missed
    Router->>TCP: Msg::StateSync { ops: missing }
    TCP->>Router: inbound StateSync (our side)
    Router->>Router: apply each op to transport_doc
    Router->>App: remote_op_sender.send per op
    App->>App: tui_doc.apply each op
```

---

## Channel map - full system

```mermaid
graph LR
    subgraph client["crdt-client"]
        APP_SEND[local_op_sender]
        APP_RECV[remote_op_receiver]
        APP[app.rs]
    end

    subgraph transport["crdt-transport"]
        ROUTER[msg_router]
        NP[new_peer_sender]
        IB[inbound_sender]
        subgraph peers["per-peer senders (inside peers map)"]
            P1[peer A sender]
            P2[peer B sender]
        end
        TCP1[tcp_peer A]
        TCP2[tcp_peer B]
    end

    APP -->|Operation| APP_SEND --> ROUTER
    ROUTER -->|Operation| APP_RECV --> APP

    TCP1 -->|PeerHandle| NP --> ROUTER
    TCP2 -->|PeerHandle| NP

    TCP1 -->|SocketAddr + Msg| IB --> ROUTER
    TCP2 -->|SocketAddr + Msg| IB

    ROUTER --> P1 --> TCP1
    ROUTER --> P2 --> TCP2
```

All channels: `tokio::sync::mpsc`. No shared memory between TUI and transport except `Arc<Mutex<Document>>` for the transport doc (used by router, sync_tick, autosave).

---

## Two-document design

```mermaid
graph TD
    SNAP[snapshot load] -->|saved ops| BOTH

    subgraph BOTH[startup replay]
        TUI_DOC[tui_doc\nnot behind Mutex\nowned by app.rs]
        TR_DOC[transport_doc\nArc Mutex Document\nshared by router + sync_tick + autosave]
    end

    LOCAL[local op from keyboard] -->|"apply to both via:\n1. bridge applies to tui_doc\n2. local_op_sender -> router applies to transport_doc"| BOTH

    REMOTE[remote op from network] -->|"1. router applies to transport_doc\n2. remote_op_sender -> app applies to tui_doc"| BOTH
```

`transport_doc` must apply local AND remote ops to keep its VV accurate. If it only applies remote ops, sync_tick sends a stale VV and peers re-send their entire history every tick.
