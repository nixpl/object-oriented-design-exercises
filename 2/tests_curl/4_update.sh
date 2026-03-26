#!/bin/bash
ID=${1:-1}
echo "Updating price for product with ID $ID to 299.99:"
curl -s -X PUT http://localhost:8000/api/products/$ID \
  -H "Content-Type: application/json" \
  -d '{"price": 299.99}'
echo -e "\n"
