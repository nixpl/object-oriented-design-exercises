#!/bin/bash
ID=${1:-1}
echo "Deleting category with ID $ID:"
curl -s -X DELETE http://localhost:8000/api/categories/$ID
echo -e "\n"
