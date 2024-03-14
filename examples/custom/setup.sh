#!/bin/bash

## BENCHMARK SCRIPT. LAUNCH server and client

python3 -V
python3 -m venv venv
source venv/bin/activate

pip3 install -e . 
pip3 install aiohttp

# start a server on process 1

python3 -m vllm.entrypoints.openai.api_server \
    --model mistralai/Mistral-7B-v0.1 \
    --max-model-len 2048 \
    --disable-log-requests


# By default it makes 1000 requests for benchmarking. use -h flag to see all input fields
<<COMMENT
# install relevant dataset
wget https://huggingface.co/datasets/anon8231489123/ShareGPT_Vicuna_unfiltered/resolve/main/ShareGPT_V3_unfiltered_cleaned_split.json

# make requests to the server
python3 benchmarks/benchmark_serving.py \
    --model mistralai/Mistral-7B-v0.1 \
    --tokenizer mistralai/Mistral-7B-v0.1 \
    --endpoint /v1/completions \
    --dataset ShareGPT_V3_unfiltered_cleaned_split.json \
    --request-rate 3.0 \
    --backend openai
COMMENT


# install lint dependencies
