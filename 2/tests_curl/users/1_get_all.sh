#!/bin/bash
echo "Fetching all users:"
curl -s -X GET http://localhost:8000/api/users | jq || curl -s -X GET http://localhost:8000/api/users
echo -e "\n"
