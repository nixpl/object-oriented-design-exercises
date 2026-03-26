#!/bin/bash
ID=${1:-1}
echo "Deleting user with ID $ID:"
curl -s -X DELETE http://localhost:8000/api/users/$ID
echo -e "\n"
