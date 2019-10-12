## 详述文章

1.grafana&prometheus生产级容器化监控-1：生产级容器化

https://mp.weixin.qq.com/s?__biz=Mzg4MDEzMDM4MA==&mid=2247484212&idx=1&sn=a544362016d88465b14897cd5ee5c2c5&chksm=cf78a317f80f2a01cf7636e223dd23cb04c15c3620ccab61972c4c8169d63994e16c3444daa8&token=1057335909&lang=zh_CN#rd

# (2).grafana/prometheus生产级实践

生产容器化合理拓扑：

![image](https://github.com/hepyu/k8s-app-config/blob/master/product/standard/grafana-prometheus-pro/images/grafana-prometheus%E7%94%9F%E4%BA%A7%E7%BA%A7%E5%AE%9E%E8%B7%B5.jpg)

基础服务进行prometheus编程监控关键指标，下图为oss上传服务的架构图，prometheus用来监控上传文件的大小/时间等关键指标，确认业务调用方是否正确使用了oss上传服务：

![image](https://github.com/hepyu/k8s-app-config/blob/master/product/standard/grafana-prometheus-pro/images/caf-cdn%E6%96%B9%E6%A1%88.jpg)

# (3)容器化执行步骤

## 1.注意事项

a.本配置使用的是local-pv，生产使用要换成云存储，本配置提供nfs的配置(已注释)。

b.imagePullSecret是注释掉的，生产要打开，因为镜像仓库都是有secret的。

c.注意先建立pv目录和挂载，注意目录的权限，否则prometehus, grafana容器化失败，给775或777。

## 2.容器化步骤

kubectl apply -f grafana-prometheus-image-repo-secret.yaml(生产环境需要改成自己的秘钥，本地部署不要执行)

kubectl apply -f grafana-prometheus-namespace.yaml

分别进入子目录执行：kubectl apply -f .
