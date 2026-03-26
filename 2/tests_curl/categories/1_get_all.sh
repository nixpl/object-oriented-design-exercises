#!/bin/bash
echo "Fetching all categories:"
curl -s -X GET http://localhost:8000/api/categories | jq || curl -s -X GET http://localhost:8000/api/categories
echo -e "\n"
