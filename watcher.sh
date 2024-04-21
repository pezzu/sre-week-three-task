#!/usr/bin/env bash

namespace="sre"
deployment="swype-app"
maxRestarts=3
timeout=20

while [ true ]; do
    restarts=`kubectl get pods -n $namespace | grep $deployment | grep -v grep | awk '{ print $4 }'`
    echo "Current restarts count: $restarts"
    if [ $restarts -gt $maxRestarts ]; then
        echo "Maximum number of restarts reached. Scalling $namespace:$deployment down"
        kubectl scale deployment -n $namespace $deployment --replicas=0
        break
    fi
    sleep $timeout
done
