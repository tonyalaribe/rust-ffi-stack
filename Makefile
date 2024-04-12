GHC_VERSION := 9.6.4
ARCH := $(shell uname -m | sed 's/arm64/aarch64/')
OS := $(shell uname -s | sed 's/Darwin/osx/')
OS_ARCH := $(ARCH)-$(OS)
LINUX_HC_PATH := .stack-work/dist/x86_64-linux-tinfo6/ghc-$(GHC_VERSION)/build

prepare-rust-interop:
	cd ./greetings/ && \
	cargo build --release && \
	mkdir -p ./.stack-work/dist/$(OS_ARCH)/ghc-$(GHC_VERSION)/build/ && \
	mkdir -p $(LINUX_HC_PATH) && \
	cp ./target/release/libgreetings.a $(LINUX_HC_PATH)/libCgreetings.a && \
	cp ./target/release/libgreetings.so $(LINUX_HC_PATH)/libCgreetings.so || true && \
	cp ./target/release/libgreetings.so $(LINUX_HC_PATH)/libCgreetings-ghc$(GHC_VERSION).so || true && \
	cp ./target/release/libgreetings.a .stack-work/dist/$(OS_ARCH)/ghc-$(GHC_VERSION)/build/libCgreetings.a || true && \
	cp ./target/release/libgreetings.so .stack-work/dist/$(OS_ARCH)/ghc-$(GHC_VERSION)/build/libCgreetings.so || true && \
	cp ./target/release/libgreetings.dylib .stack-work/dist/$(OS_ARCH)/ghc-$(GHC_VERSION)/build/libCgreetings.dylib || true && \
	cp ./target/release/libgreetings.dylib .stack-work/dist/$(OS_ARCH)/ghc-$(GHC_VERSION)/build/libCgreetings-ghc$(GHC_VERSION).dylib  || true
