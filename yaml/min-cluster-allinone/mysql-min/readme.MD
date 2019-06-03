# (1).前述

实际生产环境中，为了稳定和高可用(晚上睡觉踏实)，我们并不会把mysql装在k8s集群中，一般是用阿里云的RDS或者自己在高性能机器上搭建mysql。

但是，对于dev, test环境，我们完全可以把mysql部署到各自的k8s集群,非常有助于提升效率,而且还有助于k8s的经验积累.

# (2).exec order

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
