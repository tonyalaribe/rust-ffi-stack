GHC_VERSION := 9.6.4
ARCH := $(shell uname -m | sed 's/arm64/aarch64/')
OS := $(shell uname -s | sed 's/Darwin/osx/')
OS_ARCH := $(ARCH)-$(OS)
LINUX_HC_PATH := .stack-work/dist/x86_64-linux-tinfo6/ghc-$(GHC_VERSION)/build
RUSTLIB := greetings 
WORKING_DIR := $(shell pwd)

prepare-rust-interop:
	cd ./greetings/ && \
	cargo build --release && \
	mkdir -p ./.stack-work/dist/$(OS_ARCH)/ghc-$(GHC_VERSION)/build/ && \
	mkdir -p $(LINUX_HC_PATH) && \
	cp ./target/release/lib$(RUSTLIB).a $(LINUX_HC_PATH)/libC$(RUSTLIB).a && \
	cp ./target/release/lib$(RUSTLIB).so $(LINUX_HC_PATH)/libC$(RUSTLIB).so || true && \
	cp ./target/release/lib$(RUSTLIB).so $(LINUX_HC_PATH)/libC$(RUSTLIB)-ghc$(GHC_VERSION).so || true && \
	cp ./target/release/lib$(RUSTLIB).a .stack-work/dist/$(OS_ARCH)/ghc-$(GHC_VERSION)/build/libC$(RUSTLIB).a || true && \
	cp ./target/release/lib$(RUSTLIB).so .stack-work/dist/$(OS_ARCH)/ghc-$(GHC_VERSION)/build/libC$(RUSTLIB).so || true && \
	cp ./target/release/lib$(RUSTLIB).dylib .stack-work/dist/$(OS_ARCH)/ghc-$(GHC_VERSION)/build/libC$(RUSTLIB).dylib || true && \
	cp ./target/release/lib$(RUSTLIB).dylib .stack-work/dist/$(OS_ARCH)/ghc-$(GHC_VERSION)/build/libC$(RUSTLIB)-ghc$(GHC_VERSION).dylib  || true
	@echo WORKING_DIR
