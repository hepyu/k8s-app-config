# 容器化步骤

顺次执行容器化命令：
```
kubectl apply -f kibana-min-deployment.yaml
kubectl apply -f kibana-min-service.yaml
```

或者直接执行本目录下的deploy.sh：
```
sh deploy.sh
```
