kubectl create namespace rocketmq-min
kubectl apply -f rocketmq-min-c0-namesrv-prod.yaml
kubectl apply -f rocketmq-min-c0-broker-master0-pv-local.yaml
kubectl apply -f rocketmq-min-c0-broker-master-prod.yaml
kubectl apply -f rocketmq-min-c0-broker-slave0-pv-local.yaml
kubectl apply -f rocketmq-min-c0-broker-slave-prod.yaml
kubectl apply -f rocketmq-min-c0-console-ng-prod.yaml
