GHC_VERSION := 9.8.1
ARCH := $(shell uname -m | sed 's/arm64/aarch64/')
OS := $(shell uname -s | sed 's/Darwin/osx/')
OS_ARCH := $(ARCH)-$(OS)
LINUX_HC_PATH := .stack-work/dist/x86_64-linux-tinfo6/ghc-$(GHC_VERSION)/build

prepare-rust-interop:
	cd ./rust-interop/ && \
	cargo build --release && \
	mkdir -p ./.stack-work/dist/$(OS_ARCH)/ghc-$(GHC_VERSION)/build/ && \
	mkdir -p ./.stack-work/dist/x86_64-linux-tinfo6/ghc-9.8.1/build/ && \
	cp ./target/release/librust_interop.a $(LINUX_HC_PATH)/libCrust_interop.a \
	cp ./target/release/librust_interop.so $(LINUX_HC_PATH)/libCrust_interop.so || true && \
	cp ./target/release/librust_interop.a .stack-work/dist/$(OS_ARCH)/ghc-$(GHC_VERSION)/build/libCrust_interop.a || true && \
	cp ./target/release/librust_interop.so .stack-work/dist/$(OS_ARCH)/ghc-$(GHC_VERSION)/build/libCrust_interop.so || true && \
	cp ./target/release/librust_interop.dylib .stack-work/dist/$(OS_ARCH)/ghc-$(GHC_VERSION)/build/libCrust_interop.dylib || true && \
	cp ./target/release/librust_interop.dylib .stack-work/dist/$(OS_ARCH)/ghc-$(GHC_VERSION)/build/libCrust_interop-ghc$(GHC_VERSION).dylib  || true
