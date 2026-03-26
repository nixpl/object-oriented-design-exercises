#!/bin/bash
echo "Creating a new product:"
curl -s -X POST http://localhost:8000/api/products \
  -H "Content-Type: application/json" \
  -d '{"name": "Mechanical Keyboard", "price": 350.00}'
echo -e "\n"
