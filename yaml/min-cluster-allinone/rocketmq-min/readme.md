kubectl create secret docker-registry hpy --docker-server= --docker-username= --docker-password= --docker-email= -n rocketmq

(1).rocketmq容器化

1.建立pv存储
kubectl apply -f pv-rocketmq-min-c0-broker-master.yaml 
kubectl apply -f pv-rocketmq-min-c0-broker-slave.yaml

2.rocketmq容器化
kubectl apply -f rocketmq-min-c0-namesrv-prod.yaml 
kubectl apply -f rocketmq-min-c0-broker-master-prod.yaml
kubectl apply -f rocketmq-min-c0-broker-slave-prod.yaml

3.rocketmq-console容器化
kubectl apply -f rocketmq-min-c0-console-ng-prod.yaml

(2).ingress代理rocketmq-consle

kubectl apply -f ingress-rocketmq-min-c0-console.yaml
