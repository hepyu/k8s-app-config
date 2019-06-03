# exec order

```
kubectl apply -f mysql-min-storageclass-local.yaml
kubectl apply -f mysql-min-pv-local.yaml
kubectl apply -f mysql-min-pvc.yaml
kubectl apply -f mysql-min-secret.yaml
kubectl apply -f mysql-min-deployment.yaml
kubectl apply -f mysql-min-service.yaml
```

如果使用nfs存储，使用mysql-min-pv-nfs.yaml代替mysql-min-pv-local.yaml,同时要注意修改pvc中的storageClass，要改成nfs标识(无实际意义，更规范):

kubectl apply -f mysql-min-pv-nfs.yaml
