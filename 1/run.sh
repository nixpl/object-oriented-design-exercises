#!/bin/bash

cd "$(dirname "$0")"

echo "building docker image..."
docker build -t bubblesort-app .

echo ""
echo "running container..."
docker run --rm bubblesort-app

echo ""
echo "done."