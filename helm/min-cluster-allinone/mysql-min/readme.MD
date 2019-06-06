部署命令：

```
kubectl apply -f mysql-min-pv-local.yaml
kubectl apply -f mysql-min-storageclass-local.yaml

helm install --name mysql-min stable/mysql --namespace=mysql-min --set "persistence.size=1Gi,persistence.storageClass=mysql-min-storageclass-local,mysqlUser=apollo,mysqlPassword=admin,mysqlRootPassword=root"
```
