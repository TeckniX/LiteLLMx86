#!/usr/bin/env bash

MODEL_FILE="./models/MiniCPM5-2B-Q4_K_M.gguf"
HOST=0.0.0.0
PORT=8080

# Start llama-server in the background
llama-server -m $MODEL_FILE \
  --host ${HOST} \
  --port ${PORT} \
  -t 8 \
  -c 2048 \
  --chat-template minicpm &

# Wait for llama-server to be ready
sleep 2

# Start litellm router on port 4000
litellm --config config.yaml --port 4000
