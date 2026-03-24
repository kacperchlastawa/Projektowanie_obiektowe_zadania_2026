#!/bin/bash

IMAGE_NAME="pascal-bubble-sort-app"

echo "1. Budowanie obrazu Docker..."

docker build -t $IMAGE_NAME .

echo ""
echo "2. Uruchamianie aplikacji w kontenerze..."
echo "-----------------------------------------"

docker run --rm $IMAGE_NAME