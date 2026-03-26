#!/bin/bash
ID=${1:-1}
echo "Updating email for user with ID $ID to admin@uj.edu.pl:"
curl -s -X PUT http://localhost:8000/api/users/$ID \
  -H "Content-Type: application/json" \
  -d '{"email": "admin@uj.edu.pl"}'
echo -e "\n"
