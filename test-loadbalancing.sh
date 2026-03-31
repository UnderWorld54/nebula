#!/bin/bash
# Test de load balancing : appelle /posts 10 fois
# et vérifie que différents conteneurs répondent


echo "⚖️  Test de load balancing (post-service)"
echo "========================================"


for i in $(seq 1 10); do
  HOSTNAME=$(curl -s http://localhost/posts | grep -o '"hostname":"[^"]*"' | cut -d'"' -f4)
  echo "  Requête $i → conteneur: $HOSTNAME"
done


echo ""
echo "✅ Si tu vois des hostnames différents, le load balancing fonctionne !"
