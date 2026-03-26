#!/bin/bash
echo "Fetching all products:"
curl -s -X GET http://localhost:8000/api/products | jq || curl -s -X GET http://localhost:8000/api/products
echo -e "\n"
