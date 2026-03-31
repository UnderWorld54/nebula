#!/bin/bash
# Script de déploiement automatisé Nebula
# Usage : ./deploy.sh [nom-du-service] [version]
# Exemple : ./deploy.sh api-gateway v2


set -e  # Arrête le script à la première erreur


SERVICE=$1
VERSION=$2
REGISTRY="10.100.12.105:5000"


# Vérifications
if [ -z "$SERVICE" ] || [ -z "$VERSION" ]; then
  echo "❌ Usage : ./deploy.sh <service> <version>"
  echo "   Ex : ./deploy.sh api-gateway v2"
  exit 1
fi


if [ ! -d "/home/etudiant/nebula/$SERVICE" ]; then
  echo "❌ Dossier $SERVICE introuvable"
  exit 1
fi


echo ""
echo "========================================"
echo "🚀 Déploiement de $SERVICE:$VERSION"
echo "========================================"


# Étape 1 : Build
echo ""
echo "🔨 1/4 Construction de l'image..."
docker build -t $REGISTRY/$SERVICE:$VERSION /home/etudiant/nebula/$SERVICE


# Étape 2 : Push
echo ""
echo "📤 2/4 Envoi vers le registry..."
docker push $REGISTRY/$SERVICE:$VERSION


# Étape 3 : Mise à jour du service
echo ""
echo "⚙️  3/4 Mise à jour du service Swarm..."
docker service update --image $REGISTRY/$SERVICE:$VERSION nebula_$SERVICE


# Étape 4 : Vérification
echo ""
echo "✅ 4/4 Vérification..."
docker service ls | grep nebula_$SERVICE


echo ""
echo "🎉 $SERVICE:$VERSION déployé avec succès !"
