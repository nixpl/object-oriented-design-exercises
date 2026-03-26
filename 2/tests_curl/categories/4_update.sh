#!/bin/bash
ID=${1:-1}
echo "Updating name for category with ID $ID to Smart Home:"
curl -s -X PUT http://localhost:8000/api/categories/$ID \
  -H "Content-Type: application/json" \
  -d '{"name": "Smart Home"}'
echo -e "\n"
