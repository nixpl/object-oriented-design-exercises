#!/bin/bash
ID=${1:-1}
echo "Deleting product with ID $ID:"
curl -s -X DELETE http://localhost:8000/api/products/$ID
echo -e "\n"
