#!/bin/bash
echo "Creating a new user:"
curl -s -X POST http://localhost:8000/api/users \
  -H "Content-Type: application/json" \
  -d '{"email": "student@uj.edu.pl"}'
echo -e "\n"
