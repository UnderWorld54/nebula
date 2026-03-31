#!/bin/bash
# Test de charge : envoie 100 requêtes en parallèle


echo "💥 Test de charge - 100 requêtes"
echo "========================================"


START=$(date +%s%N)
SUCCESS=0
FAIL=0


for i in $(seq 1 100); do
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" -m 5 http://localhost/posts)
  if [ "$STATUS" = "200" ]; then
    SUCCESS=$((SUCCESS+1))
  else
    FAIL=$((FAIL+1))
  fi
done


END=$(date +%s%N)
DURATION=$(( (END - START) / 1000000 ))


echo ""
echo "Résultats :"
echo "  ✅ Réussies : $SUCCESS / 100"
echo "  ❌ Échouées : $FAIL / 100"
echo "  ⏱️  Durée totale : ${DURATION}ms"
echo "  📊 Moyenne : $((DURATION / 100))ms par requête"
