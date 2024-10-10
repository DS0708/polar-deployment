#!/bin/sh

# echo "\n🔌 Enabling NGINX Ingress Controller...\n"

# kubectl apply -f ./platform/development/ingress

# sleep 15

echo "\n📦 Deploying platform services..."

kubectl apply -f ./platform/development/services

sleep 5

echo "\n⌛ Waiting for PostgreSQL to be deployed..."

while [ $(kubectl get pod -l db=polar-postgres | wc -l) -eq 0 ] ; do
  sleep 5
done

echo "\n⌛ Waiting for PostgreSQL to be ready..."

kubectl wait \
  --for=condition=ready pod \
  --selector=db=polar-postgres \
  --timeout=180s

echo "\n⌛ Waiting for Redis to be deployed..."

while [ $(kubectl get pod -l db=polar-redis | wc -l) -eq 0 ] ; do
  sleep 5
done

echo "\n⌛ Waiting for Redis to be ready..."

kubectl wait \
  --for=condition=ready pod \
  --selector=db=polar-redis \
  --timeout=180s

echo "\n📦 Deploying applications..."

kubectl apply -f ./applications/development

sleep 5

echo "\n⛵ Happy Sailing!\n"