#!/bin/bash
ID=${1:-1}
echo "Fetching category with ID $ID:"
curl -s -X GET http://localhost:8000/api/categories/$ID
echo -e "\n"
