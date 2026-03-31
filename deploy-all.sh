#!/bin/bash
# Déploie tous les services en une fois
# Usage : ./deploy-all.sh v2


VERSION=$1
if [ -z "$VERSION" ]; then
  echo "❌ Usage : ./deploy-all.sh <version>"
  exit 1
fi


for SERVICE in api-gateway user-service post-service media-service notification-service; do
  ./deploy.sh $SERVICE $VERSION
done


echo ""
echo "🎉 Tous les services déployés en $VERSION !"
