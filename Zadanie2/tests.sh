#!/bin/bash

echo "--- TEST 1: Pobieranie produktów (GET) ---"
curl -X GET http://localhost:8000/api/product
echo -e "\n"

echo "--- TEST 2: Dodawanie produktu 1 (POST) ---"
curl -X POST http://localhost:8000/api/product \
     -H "Content-Type: application/json" \
     -d '{"name": "Laptop Pro", "price": 4500.50, "description": "Super szybki laptop"}'
echo -e "\n"

echo "--- TEST 3: Dodawanie produktu 2 (POST) ---"
curl -X POST http://localhost:8000/api/product \
     -H "Content-Type: application/json" \
     -d '{"name": "Myszka bezprzewodowa", "price": 120.00, "description": "Ergonomiczna"}'
echo -e "\n"

echo "--- TEST 4: Ponowne pobieranie listy (GET) ---"
curl -X GET http://localhost:8000/api/product
echo -e "\n"