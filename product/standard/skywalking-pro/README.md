## 微信技术公众号：千里行走

<img src="https://github.com/hepyu/k8s-app-config/blob/master/images/%E5%8D%83%E9%87%8C%E8%A1%8C%E8%B5%B0.jpg" width="25%">

## 实战交流群

<img src="https://github.com/hepyu/saf/blob/master/images/k8s.png" width="25%">

本例配置可以直接进行容器化；

但是如果用于生产环境，需要将生产级配置打开，同时注释掉测试用配置；

# (1).本例配置文件运行

本例配置可以直接容器化，进入当前目录执行命令即可：

kubectl apply -f .

但要注意需要执行两遍，因为namespace刚开始可能还没有初始化，会报错。

本地配置ingress宿主机的host,即可访问skywalking-ui。

ip skywalking-c0-ui.inc-inc.com

# (2).本例配置文件说明

|              Directory               |                             Description                             | 
| ------------------------------------ | ------------------------------------------------------------------- | 
| skywalking-c0-oap-deployment.yaml |  collector实例节点的deployment。|
| skywalking-c0-service.yaml | collecotr实例节点的service，包含headless svc。 |
| skywalking-c0-ui-deployment.yaml | ui实例节点的deployment。 |
| skywalking-c0-ui-ingress.yaml | ui实例节点的ingress。 |
| skywalking-c0-ui-service.yaml | ui实例节点的service，包含headless svc。 |
| skywalking-c0-configmap.yaml | sk-oap的配置文件，定义storage，服务发现等 |
| skywalking-c0-namespace.yaml | 定义namespace。 |


# (3).本例配置文件用于生产环境需要的改动

namespace需要统一改为自己合适的，存储空间适自己情况更改。

本例默认配置是测试资源级别的配置，同时提供生产环境的资源配置，只不过生产环境的资源配置默认是注释掉的(笔者阿里云机器资源有限)。

测试与生产的配置主要差异：

replicas, pod亲和，镜像仓库秘钥，pv存储大小，cpu/memory大小，ingress是否挂载云厂商的SLB等。

|              Directory               |                             Description                             | 
| ------------------------------------ | ------------------------------------------------------------------- | 
| skywalking-c0-oap-deployment.yaml |  修改replicas为合适的节点个数；打开亲和性affinity；修改resources；修改imagePullSecrets。|
| skywalking-c0-service.yaml | 修改namespace。 |
| skywalking-c0-ui-deployment.yaml | 修改replicas为合适的节点个数；打开亲和性affinity；修改resources；修改imagePullSecrets。 |
| skywalking-c0-ui-ingress.yaml | 修改namespace；如果使用云厂商的loadbalance，开启kubernetes.io/ingress.class挂载SLB。 |
| skywalking-c0-ui-service.yaml | 修改namespace。 |
| skywalking-c0-configmap.yaml | 修改namespace。 |
| skywalking-c0-namespace.yaml | 修改namespace。 |


# (4).skywalking容器化注意事项

参见：

[阿里云&kubernetes&微服务生产实践-6：skywalking-6.4.0生产级别容器化](https://mp.weixin.qq.com/s?__biz=Mzg4MDEzMDM4MA==&mid=2247484282&idx=1&sn=eb1697c87e9b6208ca1f7361ee04599a&chksm=cf78a359f80f2a4ffcb49018150ed22399ffc8c693efa20993569dd4cbeffdba098d79a7f8b1&token=2071926671&lang=zh_CN#rd)

# (5).相关资源

1.容器化实战交流钉钉群号：23394754。

2.笔者oraclejdk镜像制作

https://github.com/hepyu/oraclejdk-docker-image

3.笔者oraclejdk-skywalking镜像制作

https://github.com/hepyu/oraclejdk-skywalking-docker-image

4.k8s-app-config主流中间件容器化工程(持续更新)

https://github.com/hepyu/k8s-app-config
