#!/bin/bash
# Test fonctionnel : vérifie que tous les services répondent


echo "🧪 Tests fonctionnels Nebula"
echo "========================================"
PASS=0
FAIL=0


test_endpoint() {
  local name=$1
  local url=$2
  local expected=$3
  RESPONSE=$(curl -s -m 5 $url)
  if echo "$RESPONSE" | grep -q "$expected"; then
    echo "  ✅ $name"
    PASS=$((PASS+1))
  else
    echo "  ❌ $name - Réponse: $RESPONSE"
    FAIL=$((FAIL+1))
  fi
}


test_endpoint "API Gateway"       http://localhost/           "api-gateway"
test_endpoint "User Service"      http://localhost/users      "user-service"
test_endpoint "Post Service"      http://localhost/posts      "post-service"
test_endpoint "Media Service"     http://localhost/media      "media-service"
test_endpoint "Notifications"     http://localhost/notifications "notification-service"


echo ""
echo "Résultats : $PASS passés, $FAIL échoués"
