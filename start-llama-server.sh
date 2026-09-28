#!/usr/bin/env bash

MODEL_FILE="./models/MiniCPM5-2B-Q4_K_M.gguf"
HOST=0.0.0.0
PORT=8080

# Start llama-server in the background
llama-server -m $MODEL_FILE \
  --host ${HOST} \
  --port ${PORT} \
  -t 8 \
  -c 4096 \
  -ub 512 \
  -b 512 \
  --cache-type-k q4_0 \
  --cache-type-v q4_0 \
  --mlock \
  --prio 2 \
  --chat-template minicpm &

# Wait for llama-server to be ready
sleep 2

# Start litellm router on port 4000
litellm --config config.yaml --port 4000
