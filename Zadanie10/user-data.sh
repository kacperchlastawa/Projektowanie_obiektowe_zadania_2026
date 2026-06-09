#!/bin/bash
# Aktualizacja systemu
sudo apt-get update -y

# Instalacja Dockera i Docker Compose
sudo apt-get install -y docker.io docker-compose

# Uruchomienie i włączenie Dockera
sudo systemctl start docker
sudo systemctl enable docker

# Dodanie użytkownika 'ubuntu' do grupy docker (by nie musiał używać sudo)
sudo usermod -aG docker ubuntu
