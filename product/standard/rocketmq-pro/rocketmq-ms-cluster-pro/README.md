# 头条技术号：实战架构

# 微信公众号：千里行走

本例配置可以直接进行容器化；

但是如果用于生产环境，需要将生产级配置打开，同时注释掉测试用配置；

采用rocketmq的master-slave结构进行容器化；

dledger多副本结构由于源码分隔符问题，造成我们生产环境容器化代价过大，所以没有选用。

# (1).本例配置文件运行

本例配置可以直接容器化，进入当前目录执行命令即可：

kubectl apply -f .

但要注意需要执行两遍，因为namespace刚开始可能还没有初始化，会报错。

# (2).本例配置文件说明

|              Directory               |                             Description                             | 
| ------------------------------------ | ------------------------------------------------------------------- | 
| rocketmq-broker-configmap.yaml |  broker的配置文件，定义存储位置，以及brokerName，brokerRole等；这个文件里的rewrite-broker-config.sh脚本是关键部分，自动根据statefulset的隐藏参数pod序号来修改broker config文件中的brokerName和brokerRole(偶主奇从)。                                 |
| rocketmq-broker-pv.yaml | 定义PV存储，生产环境我们用的阿里云的nas云存储，测试用时需要配置local pv。 |
| rocketmq-broker-statefulset.yaml | 定义容器及其相关。 |
| rocketmq-console-ingress.yaml | 配置rocketmq-console到ingress，方便办公环境访问。 |
| rocketmq-console-pv.yaml | rocketmq-console的存储，同样生产环境我们用的是阿里云的nas云存储，测试要配置local pv。 |
| rocketmq-console-pvc.yaml | rocketmq-console的pvc定义。 |
| rocketmq-console-service.yaml | rocketmq-console的负载均衡定义。 |
| rocketmq-console-statefulset.yaml | rocketmq-console的容器及相关定义。 |
| rocketmq-namespace.yaml | namespace定义。 |
| rocketmq-namesrv-pv.yaml | rocketmq-namesrv的pv存储，生产环境我们用的阿里云的nas云存储，测试用时需要配置local pv。 |
| rocketmq-namesrv-service.yaml | rocketmq-namesrv的负载均衡。 |
|  rocketmq-namesrv-statefulset.yaml| rocketmq-namesrv的容器及相关定义。 |

# (3).本例配置文件用于生产环境需要的改动

namespace需要统一改为自己合适的，存储空间适自己情况更改。

|              Directory               |                             需要修改                             | 
| ------------------------------------ | ------------------------------------------------------------------- | 
| rocketmq-broker-configmap.yaml | 修改namespace。                                   |
| rocketmq-broker-pv.yaml | 修改namespace；注释掉local pv及其亲和性；使用自己公司的存储，本例提供nfs的配置，需要自己配置url。 |
| rocketmq-broker-statefulset.yaml | 修改namespace；修改replicas为4；打开亲和性affinity；修改resources；修改imagePullSecrets。  |
| rocketmq-console-ingress.yaml | 修改namespace；如果使用云厂商的loadbalance，开启kubernetes.io/ingress.class挂载SLB。 |
| rocketmq-console-pv.yaml | 修改namespace；注释掉local pv及其亲和性；使用自己公司的存储，本例提供nfs的配置，需要自己配置url。 |
| rocketmq-console-pvc.yaml | 修改namespace。 |
| rocketmq-console-service.yaml | 修改namespace。 |
| rocketmq-console-statefulset.yaml | 修改namespace。 |
| rocketmq-namespace.yaml | 修改namespace。 |
| rocketmq-namesrv-pv.yaml | 修改namespace；注释掉local pv及其亲和性；使用自己公司的存储，本例提供nfs的配置，需要自己配置url。 |
| rocketmq-namesrv-service.yaml | 修改namespace。 |
| rocketmq-namesrv-statefulset.yaml| 修改namespace；修改replicas为4；打开亲和性affinity；修改resources；修改imagePullSecrets。 |

# (附1).相关资源

1.官方rocketmq镜像与容器化

https://github.com/apache/rocketmq-docker

2.笔者rocketmq镜像制作

https://github.com/hepyu/rocketmq-docker-image

3.笔者oracle-jdk生产级镜像，包含redis-cli, mysql-cli等基本组件。

https://github.com/hepyu/oraclejdk-docker-image

4.笔者oracle-jdk-skywalking生产级镜像，包含redis-cli, mysql-cli等基本组件，同时集成了链路追踪skywalking-agent。

https://github.com/hepyu/oraclejdk-skywalking-docker-image

# (附2).rocketmq生产实践相关文章

1.rocketmq-1：集群主要结构和监控，性能测试与成本控制

https://www.toutiao.com/i6692649658075841035/

2.rocketmq-2：性能测试方案&压测&选型&结论

https://www.toutiao.com/i6695346973442048525/

3.rocketmq-3：rocketmq流控，重试机制与应对

https://www.toutiao.com/i6692678327557161476/

4.rocketmq-4：线上rocketmq slave节点的ECS宕机恢复实记

https://www.toutiao.com/i6701245783687037444/
