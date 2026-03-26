#!/bin/bash
echo "Creating a new category:"
curl -s -X POST http://localhost:8000/api/categories \
  -H "Content-Type: application/json" \
  -d '{"name": "Electronics"}'
echo -e "\n"
