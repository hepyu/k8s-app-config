# (1).上传elasticsearch镜像到私服
docker pull elasticsearch:6.4.3

重命名镜像为私服地址：hpy253215039/elasticsearch:6.4.3
docker images |grep elasticsearch |awk '{print "docker tag ",$1":"$2,$1":"$2}' |sed -e 's#elasticsearch#hpy253215039\/elasticsearch#2' |sh -x

docker login后执行命令推送镜像到私服：
docker push hpy253215039/elasticsearch:6.4.3

# (2).部署存储卷

sh ./deploy.sh

deploy.sh中放置了所有配置文件的执行命令。

# (3).QA

## QA1:直译意思是节点有了污点无法容忍，执行 kubectl get no -o yaml | grep taint -A 5 之后发现该节点是不可调度的。
taints:
    - effect: NoSchedule
      key: node-role.kubernetes.io/master
  status:
    addresses:
    - address: 172.26.237.195
pod describe info:
Events:
  Type     Reason            Age               From               Message
  ----     ------            ----              ----               -------
  Warning  FailedScheduling  7s (x4 over 81s)  default-scheduler  0/1 nodes are available: 1 node(s) had taints that the pod didn't tolerate.

这是因为kubernetes出于安全考虑默认情况下无法在master节点上部署pod，于是用下面方法解决：
kubectl taint nodes --all node-role.kubernetes.io/master-
打印：
node/future untainted
