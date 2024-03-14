#!/bin/bash

curl -X POST "http://localhost:8000/v1/completions" \
-H "Content-Type: application/json" \
-H "Authorization: Bearer None" \
--data-raw '{
    "model": "mistralai/Mistral-7B-v0.1",
    "prompt": "How can I get the current date as an ISO formatted string in TypeScript?",
    "temperature": 0.0,
    "best_of": 1,
    "max_tokens": 221,
    "stream": true
}'