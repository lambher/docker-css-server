#!/bin/bash
# Script de démarrage pour le serveur Counter-Strike: Source GunGame

# Définition des variables d'environnement par défaut si elles ne sont pas déjà définies
export RCON_PASSWORD="${RCON_PASSWORD:-mypassword123}"
export SERVER_HOSTNAME="${SERVER_HOSTNAME:-CSS GunGame Server [Belair73]}"

echo "=================================================="
echo " Démarrage du serveur CSS GunGame "
echo " Nom du serveur : $SERVER_HOSTNAME"
echo "=================================================="

# Lance le serveur avec Docker Compose et reconstruit les images si nécessaire
docker compose up --build
