## 微信技术公众号：千里行走

<img src="https://github.com/hepyu/k8s-app-config/blob/master/images/%E5%8D%83%E9%87%8C%E8%A1%8C%E8%B5%B0.jpg" width="25%">

## 实战交流群

<img src="https://github.com/hepyu/saf/blob/master/images/k8s.png" width="25%">

# (1).生产级实践

可以直接用于生产，中间件版本可以根据各自情况更改。

|              目录               |                            地址                              |                       备注                       |
| ------------------------------------ | ------------------------------------------------------------------- | --------------------------------------------------- |
| apollo配置中心                      | https://github.com/hepyu/k8s-app-config/tree/master/product/standard/apollo-pro                                    | apollo1.4.0版本。 |
| apollo配置中心，支持skywalking链路探针                      | https://github.com/hepyu/k8s-app-config/tree/master/product/standard/apollo-skywalking-pro                                    | apollo1.4.0版本, skywalking6.4.0版本。 |
| rocketmq消息队列中间件                        | https://github.com/hepyu/k8s-app-config/tree/master/product/standard/rocketmq-pro/rocketmq-ms-cluster-pro                 | rocketmq4.3.2版本。 |
| elasticsearch搜索中间件                        | https://github.com/hepyu/k8s-app-config/tree/master/product/standard/elasticsearch-pro | elasticsearch6.3.2版本。|
| skywalking链路追踪中间件                        | https://github.com/hepyu/k8s-app-config/tree/master/product/standard/skywalking-pro                 | skywalking6.4.0版本。
| grafana/prometheus监控                        | https://github.com/hepyu/k8s-app-config/tree/master/product/standard/grafana-prometheus-pro                 | grafana6.4.2, prometheus2.13.0
| python-rocketmq-exporter监控, python版本                        | https://github.com/hepyu/k8s-app-config/tree/master/product/standard/grafana-prometheus-pro/exporter-mq-rocketmq                 | 使用python开发的exporter,主要监控消息堆积数，精确到进程粒度。不建议使用，建议使用下方的go版本。|
| go-rocketmq-exporter监控, go版本                        | https://github.com/hepyu/RocketmqExporter             | 使用go开发的exporter,主要监控消息堆积数，精确到进程粒度。|
| kube-prometheus | https://github.com/hepyu/k8s-app-config/tree/master/product/standard/kube-prometheus-pro/kube-prometheus-pro-0.3.0 | 做了一些生产级改造，版本为release-0.3.0|

# (2).相对有价值的研究性实战

|              目录               |                            地址                              |                       备注                       |
| ------------------------------------ | ------------------------------------------------------------------- | --------------------------------------------------- |
| redis-cluster容器化                      | https://github.com/hepyu/k8s-app-config/tree/master/yaml/min-cluster-allinone/redis-cluster-min                                    | redis5.0.x版本。 |
| dubbo-admin容器化 | https://github.com/hepyu/k8s-app-config/tree/master/yaml/min-cluster-allinone/dubbo-admin ||

# (3).工程目的

提供生产级实践；

提供一个低成本容器化所有组件的最佳实践，方便大家学习/研究;

|              Directory               |                             Description                             |                       备注                       |
| ------------------------------------ | ------------------------------------------------------------------- | --------------------------------------------------- |
| helm                        | 提供helm方式的容器化，步骤及注意事项。                                    |
| helm/min-cluster-allinone   | 用最小资源使用helm方式将大部分基础组件容器化。                            | 最小资源要求是8核32G，需要留足够的内存给os和demo。     |
| other                       | 备份性质目录，没有实际意义。                                |                                              |
| wayne                       | 使用cicd进行最小资源条件下的容器化，目前暂停，意义不大。                  |                                              |
| yaml                        | 提供yaml方式的容器化，步骤及注意事项。  |                                              |
| yaml/min-cluster-allinone   | 用最小资源使用helm方式将大部分基础组件容器化，适当修改可直接用于生产环境。| 最小资源要求是8核32G，需要留足够的内存给os和demo。     |
| product/standard   | 重点/持续维护目录，提供笔者生产实践中的容器化yaml配置文件；使用者需要注意的是要调整资源声明，由于笔者也会使用此目录下文件在私服搭建，而由于私服资源有限，会调整资源到最小比例，对于request/limit会提供两组配置，一组是最小配置，一组是生产环境笔者的实践配置，github中的配置文件会注释掉实践配置，开启最小配置。    |
