#!/usr/bin/env bash

namespace="sre"
deployment="swype-app"
maxRestarts=3
timeout=30

# check if the namespace exists
if ! kubectl get namespace $namespace &> /dev/null; then
  echo "Namespace $namespace does not exist"
  exit 1
fi

echo "Montioring $namespace:$deployment for restarts"

while [ true ]; do
  restarts=`kubectl get pods -n $namespace -l app=$deployment -o jsonpath="{.items[0].status.containerStatuses[0].restartCount}"`
  echo "Current restarts count: $restarts"
  if [ $restarts -gt $maxRestarts ]; then
    echo "Maximum number of restarts reached. Scalling $namespace:$deployment down"
    kubectl scale deployment -n $namespace $deployment --replicas=0
    break
  fi
  sleep $timeout
done
