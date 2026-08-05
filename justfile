set quiet

setup:
    #!/usr/bin/env bash
    set -euo pipefail

    if ! command -v lefthook &> /dev/null; then
        echo "lefthook not found, installing..."
        go install github.com/evilmartians/lefthook/v2@latest
    fi
    lefthook install

    if ! command -v bacon &> /dev/null; then
        echo "bacon not found, installing..."
        cargo install --locked bacon
    fi

    if ! command -v cargo-nextest &> /dev/null; then
        echo "nextest not found, installing..."
        cargo install --locked cargo-nextest
    fi

    if ! command -v cargo-tarpaulin &> /dev/null; then
        echo "tarpaulin not found, installing..."
        cargo install --locked cargo-tarpaulin
    fi

    if ! command -v cargo-tauri &> /dev/null; then
        echo "tauri not found, installing..."
        cargo install --version "^2.0.0" --locked tauri-cli
    fi

    if ! command -v trunk &> /dev/null; then
        echo "trunk not found, installing..."
        cargo install --locked trunk
    fi

build-web:
    trunk build --config ./web/Trunk.toml --release

build-gui:
    cargo tauri build --config ./gui/tauri.conf.json

build *ARGS:
    cargo build {{ ARGS }}

run-tui:
    cargo run --bin charlene-tui

run-web:
    trunk serve --config ./web/Trunk.toml

run-gui:
    cargo tauri dev --config ./gui/tauri.conf.json

run *ARGS:
    cargo run {{ ARGS }}

watch *ARGS:
    bacon {{ ARGS }}

format:
    cargo fmt

lint:
    cargo clippy --locked --workspace --all-targets --all-features

lint-fix:
    cargo clippy --fix --allow-dirty --locked --workspace --all-targets --all-features

ci:
    cargo fmt --check
    cargo clippy --locked --workspace --all-targets --profile ci --all-features

test *ARGS:
    cargo nextest {{ ARGS }}

coverage *ARGS:
    cargo tarpaulin {{ ARGS }}

review-snap *ARGS:
    cargo insta review {{ ARGS }}

clean *ARGS:
    cargo clean {{ ARGS }}
