## 微信技术公众号：千里行走

本例配置可以直接用于生产环境，configservice/adminservice/portal都是2副本，可以根据业务规模调整线上副本数;

本例生产级实践基于apollo官方的容器化配置文件大幅修改;

# (1).前置说明

本例相对于官方做了如下几处改动：

1.修改基础镜像为oracle-jdk，并增加redis-cli, telnet等常用工具包。

2.基础镜像增加skywalking-agent的支持，通过configmap中的配置参数来决定在启动apollo服务的时候是否开启链路追踪。

# (2).基础镜像

1.oraclejdk-docker-image:

第一层基础镜像。

使用oraclejdk8制作的镜像，包含telnet, redis-cli, mysql-client等工具包。

地址：  https://github.com/hepyu/oraclejdk-docker-image

2.oraclejdk-skywalking-docker-image

第二层镜像，基于oraclejdk-docker-image镜像。

加入了skywalking-agent支持。

地址：  https://github.com/hepyu/oraclejdk-skywalking-docker-image

3.apollo-skywalking-pro镜像，是基于镜像制作oraclejdk-skywalking-docker-image。

# (3).本例配置文件说明

|              Directory               |                             Description                             |                       备注                       |
| ------------------------------------ | ------------------------------------------------------------------- | --------------------------------------------------- |
| apollo-adminservice | admin容器，抽象api，提供给apollo-portal用。                                    |
| apollo-configservice | config容器，提供配置服务。 |
| apollo-portal | portal容器，提供web操作页面。 |
| apollo-configservice-transition | config容器，为容器外的独立部署服务提供配置服务，容器化过渡阶段存在，完成后剔除。 |

# (4).如何使用

顺次执行本目录下的yaml文件；注意pv存储，本例配置文件默认是本地pv存储，生产环境需要替换为云存储(提供样例配置)。

skywalking的关键配置位于config/admin/portal下的config.yaml文件，通过环境变量SKYWALKING_AGENT来配置是否开启skywalking-agent探针；当然也可以在这里调整JVM启动参数。

当配置如下时表示关闭skywalking-agent探针：
SKYWALKING_AGENT: ''

```
SERVICE_NAME: apollo-configservice

  APOLLO_CONFIG_SERVICE_NAME: apollo-configservice
  
  LOG_DIR: /opt/logs/apollo-config-server
  
  SERVER_PORT: '8080'
  
  SERVER_URL: http://$APOLLO_CONFIG_SERVICE_NAME:$SERVER_PORT
  
  TIME_ZONE: Asia/Shanghai
  
  SKYWALKING_AGENT: '-javaagent:/app/3rd/skywalking-agent/skywalking-agent.jar=agent.service_name=apollo-configservice-k8s,collector.backend_service=skywalking-c0-oap.skywalking:11800'
  
  #SKYWALKING_AGENT: ''
  
  JAVA_OPTS: >-
    -Xms1024m -Xmx1024m -Xss256k -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=256m -XX:NewSize=512m -XX:MaxNewSize=512m -XX:SurvivorRatio=8
    -server -XX:-ReduceInitialCardMarks
    -XX:ParallelGCThreads=4 -XX:MaxTenuringThreshold=9 -XX:+DisableExplicitGC -XX:+ScavengeBeforeFullGC -XX:SoftRefLRUPolicyMSPerMB=0 
    -XX:+ExplicitGCInvokesConcurrent -XX:+HeapDumpOnOutOfMemoryError -XX:-OmitStackTraceInFastThrow 
    -Duser.timezone=$TIME_ZONE -Dclient.encoding.override=UTF-8 -Dfile.encoding=UTF-8 
    -Djava.security.egd=file:/dev/./urandom
    -Dserver.port=$SERVER_PORT -Dlogging.file=$LOG_DIR/$SERVICE_NAME.log -XX:HeapDumpPath=$LOG_DIR/
    $SKYWALKING_AGENT
    
  application-github.properties: |
    spring.datasource.url=jdbc:mysql://mysql-min.mysql-min:3306/DevApolloConfigDB?characterEncoding=utf8
    spring.datasource.username=apollo
    spring.datasource.password=admin
    spring.jpa.database-platform=org.hibernate.dialect.MySQL5Dialect
    eureka.service.url=http://apollo-configservice/eureka/
```

# (5).特别注意

## 1.sk-agent和sky-oap一定要配置正确的时区

都要配置:  TIME_ZONE: Asia/Shanghai

因为skywalking的默认时区是UTC0，大陆的APP的服务的时区是UTC8，如果sk-agent和sk-oap的时区不一致时，sk-ui不会显示数据/拓扑。

## 2.sk-oap的elasticsearch版本选择

尽量选择sk使用的版本，比如sk6.4.0用的是es6.3.2那我们搭建es时就要选择这个版本。避免es版本差异带来的各种奇怪问题。

## 3.制作apollo-skywalking-docker-image镜像注意sk-plugin选择

参照官方/社区的issue：https://github.com/ctripcorp/apollo/issues/2448

我们的目的是：

a. 监控Apollo-Config、Admin、Portal之间的调用以及拓扑

b. 监控Apollo-Client 与 Config之间的调用及拓扑

第一种情况：Portal与Config/Admin之间采用RestTemplate/HttpClient 发起调用，这个插件在Skywalking支持列表。

第二种情况，Apollo-Client 采用的是 HttpURLConnection 发起Http请求。和 HttpClient 有些区别，默认插件不支持。需要使用可选插件：bootstrap-plugins/apm-jdk-http-plugin-6.4.0.jar，将这个jar包拷贝到plugins目录下。

##  4.apollo-portal开启多副本要注意配置session亲和性

config/admin/portal的负载均衡都需要配置：sessionAffinity: ClientIP；

如果你还是用的ingress代理apollo-portal，那么ingress也需要配置亲和性保证session的正确传递：

nginx.ingress.kubernetes.io/affinity: cookie

ingress的亲和性配置参见文件：https://github.com/hepyu/k8s-app-config/blob/master/product/standard/apollo-pro/apollo-portal/apollo-portal-ingress.yaml

如果不配置亲和性，apollo-portal开启多副本后将出现无法登陆的现象。

## 5.使用oraclejdk

因为apollo官方的镜像里没有调试工具，如jstat等，很不方便。

## 6.修改支持的环境

在apolloPortalDB的ServerConfig表中存放了支持的环境：pro,uat,fat,dev，如果只配置了pro，需要把其余的3个删除，否则portal会一直报错：

'''
Env is down. env: UAT, failed times: 39, meta server address: http://apollo.meta
'''


# (6).相关文章

1.官方地址容器化配置地址：

https://github.com/ctripcorp/apollo/tree/master/scripts/apollo-on-kubernetes/kubernetes

2.官方apollo容器化步骤(Step by Step):

https://github.com/ctripcorp/apollo/blob/master/scripts/apollo-on-kubernetes/README.md

3.笔者apollo容器化步骤(Step by Step):

https://www.toutiao.com/i6698673592915198478/

相对于官方文档增加了镜像仓库推送/db初始化的更加详细的操作，根据笔者的习惯整理了步骤，作为笔者自己的笔记/备份

4.笔者apollo容器化的生产级实践与总结：

阿里云&kubernetes&微服务生产实践-1：apollo架构-1

https://mp.weixin.qq.com/s?__biz=Mzg4MDEzMDM4MA==&mid=2247484149&idx=1&sn=6c2d50aeeadbb30f07de7f5c3d2ec545&chksm=cf78a2d6f80f2bc0319e55a16a8903ce9f2af2f0bb7a85d64bbcdb6ba0fb2c1654f87842ca8c&token=1699061844&lang=zh_CN#rd

# (7).apollo容器化混合架构

从非容器化到容器化的过渡阶段时的apollo容器化拓扑，与最终容器化后完成的apollo容器化拓扑，也是我在生产环境的做法，经过生产检验。

<b>详细内容参见笔者微信公众号：千里行走，搜索“阿里云&kubernetes&微服务生产实践-1：apollo架构-1”。</b>

apollo配置中心本身非常简单，但是从非容器化向容器化过渡时，会遇到一些实际问题，要求在工程拓扑上兼容4种版本的代码。

原因在于apollo配置中心的url需要hard code到自研框架中；非容器化时，我们需要配置多个url保证apollo的高可用，但是容器化后只需要一个url(k8s-servic负载均衡)就可以了。

适配这些情况改代码的周期和风险太大，不可接受，通过在k8s中建立不同的service负载均衡的域名(与非容器化的域名对应)这种方式可以0成本的解决过渡阶段的这些问题。

<img src="https://github.com/hepyu/kubernetes-microsvc-product-practice/blob/master/images/%E9%98%BF%E9%87%8C%E4%BA%91%26kubernetes%26%E5%BE%AE%E6%9C%8D%E5%8A%A1%E7%94%9F%E4%BA%A7%E5%AE%9E%E8%B7%B5-1%EF%BC%9Aapollo%E6%9E%B6%E6%9E%84-1.jpg" width="100%">


# (8).TODO

1.增加PV存储，将日志放到PV：待做
