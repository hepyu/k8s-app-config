# (1).前序执行

apollo依赖mysql, 需要根据如下链接先行部署mysql到k8s。
https://github.com/hepyu/k8s-app-config/blob/master/yaml/min-cluster-allinone/mysql-min/readme.MD

如果使用容器外部的mysql，需要自行修改。


# (2).apollo部署

这是apollo的最小部署，config/admin/portal都是只有1个实例。

```
kubectl apply -f service-apollo-config-server-dev.yaml
kubectl apply -f service-apollo-admin-server-dev.yaml	
kubectl apply -f service-apollo-portal-server.yaml
```
