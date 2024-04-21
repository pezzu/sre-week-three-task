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
  pod=`kubectl get pods -n $namespace | grep -v grep | grep $deployment`
  if [ -z "$pod" ]; then
    echo "Deployment $namespace:$deployment not found"
    exit 1
  fi
  restarts=`echo $pod | awk '{print $4}'`
  echo "Current restarts count: $restarts"
  if [ $restarts -gt $maxRestarts ]; then
    echo "Maximum number of restarts reached. Scalling $namespace:$deployment down"
    kubectl scale deployment -n $namespace $deployment --replicas=0
    break
  fi
  sleep $timeout
done
