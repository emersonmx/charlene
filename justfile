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

[private]
setup-web:
    cd web && npm install

build-gui: setup-web
    cargo tauri build --config ./gui/tauri.conf.json

build *ARGS:
    cargo build {{ ARGS }}

run-tui:
    cargo run --bin charlene-tui

run-gui: setup-web
    cargo tauri dev --config ./gui/tauri.conf.json

run *ARGS:
    cargo run {{ ARGS }}

watch *ARGS:
    bacon {{ ARGS }}

format:
    cargo clippy --fix --allow-dirty --locked --workspace --all-targets --all-features
    cargo fmt
    cd web && npm run format

lint:
    cargo clippy --locked --workspace --all-targets --all-features
    cargo fmt --check --verbose
    cd web && npm run lint

ci:
    cargo clippy --locked --workspace --all-targets --profile ci --all-features
    cargo fmt --check
    cd web && npm run lint

test *ARGS:
    cargo nextest {{ ARGS }}

coverage *ARGS:
    cargo tarpaulin {{ ARGS }}

review-snap *ARGS:
    cargo insta review {{ ARGS }}

clean *ARGS:
    cargo clean {{ ARGS }}
    cd web && rm -rf node_modules dist
