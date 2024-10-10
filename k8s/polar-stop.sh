#!/bin/sh

echo "\n📦 Stopping platform services..."

kubectl delete -f ./platform/development/services

echo "\n⌛ Waiting for PostgreSQL to be removed..."

while [ $(kubectl get pod -l db=polar-postgres | wc -l) -ne 0 ] ; do
  sleep 5
done

echo "\n⌛ Waiting for Redis to be removed..."

while [ $(kubectl get pod -l db=polar-redis | wc -l) -ne 0 ] ; do
  sleep 5
done

echo "\n📦 Stopping applications..."

kubectl delete -f ./applications/development

# echo "\n🔄 Disabling NGINX Ingress Controller...\n"

# kubectl delete -f ./platform/development/ingress


echo "\n⛵ All clear! Goodbye!\n"
