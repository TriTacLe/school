# CI/CD design

Two workflows. Code gate closed - no `.yml` files land until `.impl-unlocked` exists.

## ci.yml - continuous integration

Trigger: push to any branch, `pull_request` targeting master.

Jobs run in parallel. Each job uses the `setup-rust` composite action first.

| Job | Command | Notes |
|-----|---------|-------|
| fmt | `cargo fmt --check` | Fails fast; no style drift |
| clippy | `cargo clippy --workspace -- -D warnings` | Warnings are errors |
| test | `cargo test --workspace`, then `cargo test --workspace -- --ignored` | Fast run first, then proptest 1024 |
| audit | `cargo audit && bash scripts/preflight.sh` | CVE check + banned-crate grep |
| doc | `cargo doc --no-deps --workspace` | Build only on PRs; deploy to gh-pages on master push |
| coverage | `cargo tarpaulin --workspace --out Xml` + CodeCov upload | Runs after test succeeds |

## cd.yml - release

Trigger: tag matching `v*` (e.g. `v1.0.0`).

Matrix build, one leg per target:

| Target | Runner |
|--------|--------|
| `x86_64-unknown-linux-gnu` | `ubuntu-latest` |
| `aarch64-apple-darwin` | `macos-latest` |
| `x86_64-pc-windows-msvc` | `windows-latest` |

Steps per leg:
1. `setup-rust` composite action (toolchain + cross-compilation target)
2. `cargo build --release -p tui --target ${{ matrix.target }}`
3. Rename binary to `tui-${{ matrix.target }}` (append `.exe` on Windows)
4. `softprops/action-gh-release@v2` attaches all artifacts to the tag's GitHub Release

Examiner downloads the Linux binary directly from the Release page.

## Composite action: `.github/actions/setup-rust/action.yml`

Used by every job in both workflows. Two steps:

1. `dtolnay/rust-toolchain@stable` - installs pinned toolchain from `rust-toolchain.toml`, optionally adds cross-compilation targets
2. `Swatinem/rust-cache@v2` - caches `~/.cargo` and `target/` keyed on OS + toolchain + `Cargo.lock`

Cache means the second CI run on a PR that touches one file compiles only that file.

## What is not here

- No reusable `workflow_call` workflows. Two files is the right size for a 3-engineer course project.
- No nightly cron. Not needed before submission.
- No staging environment. There is nothing to deploy beyond the binary.
- No Docker images. Terminal binary ships as a native artifact.
