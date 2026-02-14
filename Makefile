BINARY_NAME=sentinel-api
AGENT_NAME=sentinel-agent
OUT_DIR=bin

.PHONY: all bpf wasm build clean

all: bpf wasm build

bpf:
	@echo "Compiling eBPF bytecode..."
	# clang -O2 -target bpf -c internal/platform/ebpf/sentinel.c -o assets/sentinel.o

wasm:
	@echo "Compiling Rust WASM modules..."
	# cd execution-engine && cargo build --target wasm32-wasi --release

build:
	@echo "Building Go binaries..."
	go build -ldflags="-s -w" -o $(OUT_DIR)/$(BINARY_NAME) ./cmd/sentinel-api
	go build -ldflags="-s -w" -o $(OUT_DIR)/$(AGENT_NAME) ./cmd/sentinel-agent

clean:
	rm -rf $(OUT_DIR)
	go clean
