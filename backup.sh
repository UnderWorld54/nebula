#!/bin/bash
# Script de sauvegarde Nebula
# Sauvegarde PostgreSQL + dossiers MinIO


set -e
BACKUP_DIR="/home/etudiant/backups"
DATE=$(date +%Y%m%d_%H%M%S)


echo "💾 Sauvegarde Nebula - $DATE"
echo "========================================"


# 1. Sauvegarde PostgreSQL
echo "🗄️  Sauvegarde PostgreSQL..."
POSTGRES_CONTAINER=$(docker ps -q -f name=postgres)
if [ -n "$POSTGRES_CONTAINER" ]; then
  docker exec $POSTGRES_CONTAINER pg_dump -U nebula nebula > $BACKUP_DIR/postgres_$DATE.sql
  echo "  ✅ PostgreSQL sauvegardd dans postgres_$DATE.sql"
else
  echo "  ❌ Conteneur PostgreSQL introuvable"
fi


# 2. Compresser les sauvegardes
echo "📦 Compression..."
if [ -f "$BACKUP_DIR/postgres_$DATE.sql" ]; then
  gzip $BACKUP_DIR/postgres_$DATE.sql
  echo "  ✅ Compressé : postgres_$DATE.sql.gz"
fi


# 3. Supprimer les sauvegardes de plus de 7 jours
echo "🗑️  Nettoyage des anciennes sauvegardes..."
find $BACKUP_DIR -name "*.gz" -mtime +7 -delete
echo "  ✅ Sauvegardes > 7 jours supprimées"


echo ""
echo "🎉 Sauvegarde terminée !"
ls -lh $BACKUP_DIR/
