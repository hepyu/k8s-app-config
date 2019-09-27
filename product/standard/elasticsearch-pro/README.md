# 头条技术号：实战架构

# 微信公众号：千里行走

本例配置可以直接进行容器化；

但是如果用于生产环境，需要将生产级配置打开，同时注释掉测试用配置；

# (1).本例配置文件运行

本例配置可以直接容器化，进入当前目录执行命令即可：

kubectl apply -f .

但要注意需要执行两遍，因为namespace刚开始可能还没有初始化，会报错。

本地配置ingress宿主机的host,即可访问kibana：

Ip http://es-c0-kibana-prod.inc-inc.com

# (2).本例配置文件说明

|              Directory               |                             Description                             | 
| ------------------------------------ | ------------------------------------------------------------------- | 
| es-c0-data-pv.yaml |  data实例节点的pv存储定义。|
| es-c0-data-service.yaml | data实例节点的service，包含headless svc。 |
| es-c0-data-statefulset.yaml | data实例节点的statefulset，测试配置使用本地pv，生产环境要换成云存储，本例提供阿里云nas配置。 |
| es-c0-ingest-deployment.yaml | ingest实例节点的deployment。 |
| es-c0-ingest-service.yaml | ingest实例节点的service，包含headless svc。 |
| es-c0-kibana-deployment.yaml | kibana实例节点的deployment。 |
| es-c0-kibana-ingerss.yaml | kibana实例节点的ingress挂载定义，通过Ingress将kibana暴露，使办公环境可访问。 |
| es-c0-kibana-service.yaml | kibana实例节点的service。 |
| es-c0-master-deployment.yaml | master实例节点的deployment。 |
| es-c0-master-service.yaml | kibana实例节点的service，包含headless svc。 |
| es-c0-namespace.yaml | 定义归属的namespace。 |

# (3).本例配置文件用于生产环境需要的改动

namespace需要统一改为自己合适的，存储空间适自己情况更改。

|              Directory               |                             Description                             | 
| ------------------------------------ | ------------------------------------------------------------------- | 
| es-c0-data-pv.yaml | 修改namespace；注释掉local pv及其亲和性；使用自己公司的存储，本例提供nfs的配置，需要自己配置url。 |
| es-c0-data-service.yaml | 修改namespace。 |
| es-c0-data-statefulset.yaml | 修改namespace；修改replicas为合适的节点个数；打开亲和性affinity；修改resources；修改imagePullSecrets。 |
| es-c0-ingest-deployment.yaml | 修改replicas为合适的节点个数；打开亲和性affinity；修改resources；修改imagePullSecrets。 |
| es-c0-ingest-service.yaml | 修改namespace。 |
| es-c0-kibana-deployment.yaml | 修改replicas为合适的节点个数；打开亲和性affinity；修改resources；修改imagePullSecrets。 |
| es-c0-kibana-ingerss.yaml | 修改namespace；如果使用云厂商的loadbalance，开启kubernetes.io/ingress.class挂载SLB。 |
| es-c0-kibana-service.yaml | 修改namespace。 |
| es-c0-master-deployment.yaml | 修改replicas为合适的节点个数；打开亲和性affinity；修改resources；修改imagePullSecrets。 |
| es-c0-master-service.yaml | 修改namespace。 |
| es-c0-namespace.yaml | 修改namespace。 |

