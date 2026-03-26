#!/bin/bash
ID=${1:-1}
echo "Fetching product with ID $ID:"
curl -s -X GET http://localhost:8000/api/products/$ID
echo -e "\n"
