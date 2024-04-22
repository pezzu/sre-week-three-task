# Dealing with toil

## Setup

```sh
minikube start
```

```sh
kubectl create namespace sre
```

```sh
kubectl apply -f upcommerce-deployment.yml
kubectl apply -f swype-deployment.yml
```

## Task 1 - big red button

Start [watcher.sh](watcher.sh)

```sh
nohup watcher.sh > ./watcher.out 2>&1 &
```

To scale swype service back run:

```sh
kubectl scale deployment -n sre swype-app --replicas=1
```

## Task 2 - addressing the toil in the ticketing system

Current ticketing system has an issues with recurring obsolete issues and a lack of clear prioritization for incoming issues.

The potential list of solutions may incude:

1. **Implement Alert Correlation and Deduplication:**

   - The functionality available in Prometheus Alertmanager and in PagerDuty. These tools can group similar alerts together, reducing noise and preventing duplicate notifications for the same issue across multiple zones.

1. **Dynamic Alert Threshold Adjustment**

   - Available in Grafana and Datadog, which allow dynamic adjustment of alert thresholds based on historical data and current system behavior. This helps in reducing false positives and obsolete alerts by adapting to changing conditions.

1. **Automated Remediation**

   - An automation frameworks, such as Ansible, can remediate common issues flagged by alerts. This can reduce the manual toil associated with handling recurring problems and free up engineering time for more development tasks.

1. **Customized Alert Escalation Policies:**

   - Develop customized alert escalation policies based on the criticality of services and the potential impact of issues. This ensures that high-priority alerts receive immediate attention while less critical ones are addressed in a timely manner, reducing the risk of missing important alerts.

1. **Explore Open Source Solutions:**

   - OSS tools like Zabbix, Nagios, or Icinga, which offer customizable alerting capabilities and can be tailored to specific requirements without incurring significant costs.
