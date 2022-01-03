FROM rust:alpine
RUN rustup component add rust-analysis --toolchain 1.51.0-x86_64-unknown-linux-musl
RUN rustup component add rust-src --toolchain 1.51.0-x86_64-unknown-linux-musl
RUN rustup component add rls --toolchain 1.51.0-x86_64-unknown-linux-musl
RUN apk add git
