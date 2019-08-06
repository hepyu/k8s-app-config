# (1).本例生产级实践基于apollo官方的容器化配置文件修改

1.1.官方地址容器化配置地址：
https://github.com/ctripcorp/apollo/tree/master/scripts/apollo-on-kubernetes/kubernetes

1.2.官方apollo容器化步骤(Step by Step):
https://github.com/ctripcorp/apollo/blob/master/scripts/apollo-on-kubernetes/README.md

1.3.笔者apollo容器化步骤(Step by Step):
https://www.toutiao.com/i6698673592915198478/
相对于官方文档增加了镜像仓库推送/db初始化的更加详细的操作，根据笔者的习惯整理了步骤，作为笔者自己的笔记/备份

# (2).apollo容器化之工程拓扑

详细内容参见笔者文章，地址：


从非容器化到容器化的过渡阶段时的apollo容器化拓扑，与最终容器化后完成的apollo容器化拓扑。

apollo配置中心本身非常简单，但是从非容器化向容器化过渡时，会遇到一些实际问题，要求在工程拓扑上兼容4种版本的代码。

原因在于apollo配置中心的url需要hard code到自研框架中；非容器化时，我们需要配置多个url保证apollo的高可用，但是容器化后只需要一个url(k8s-servic负载均衡)就可以了。

适配这些情况改代码的周期和风险太大，不可接受，通过在k8s中建立不同的service负载均衡的域名(与非容器化的域名对应)这种方式可以0成本的解决过渡阶段的这些问题。

<img src="https://github.com/hepyu/kubernetes-microsvc-product-practice/blob/master/images/%E9%98%BF%E9%87%8C%E4%BA%91%26kubernetes%26%E5%BE%AE%E6%9C%8D%E5%8A%A1%E7%94%9F%E4%BA%A7%E5%AE%9E%E8%B7%B5-1%EF%BC%9Aapollo%E6%9E%B6%E6%9E%84-1.jpg" width="100%">
