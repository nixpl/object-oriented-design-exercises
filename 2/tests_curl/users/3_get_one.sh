#!/bin/bash
ID=${1:-1}
echo "Fetching user with ID $ID:"
curl -s -X GET http://localhost:8000/api/users/$ID
echo -e "\n"
