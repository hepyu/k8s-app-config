# (1).镜像准备
docker pull elasticsearch:6.4.3

重命名镜像为：docker.elastic.co/elasticsearch/elasticsearch:6.4.3 
```
docker images |grep elasticsearch |awk '{print "docker tag ",$1":"$2,$1":"$2}' |sed -e 's#elasticsearch#docker.elastic.co/elasticsearch/elasticsearch#2' |sh -x
```

增加helm仓库:
```
Add the elastic helm charts repo:
helm repo add elastic https://helm.elastic.co
```

# (2).部署存储卷

```
kubectl apply -f es-min-data0-pv-local.yaml
kubectl apply -f es-min-data-storageclass-local.yaml
kubectl apply -f es-min-ingest0-pv-local.yaml
kubectl apply -f es-min-ingest-storageclass-local.yaml
kubectl apply -f es-min-master0-pv-local.yaml
kubectl apply -f es-min-master-storageclass-local.yaml
```

# (3).elasticsearch min-cluster deploy--有状态部署

## 1.master node:

helm install --name es-min-master --namespace es-min elastic/elasticsearch --version 6.4.3 --set masterService=es-min-master,nodeGroup=master,clusterName=es-min,roles.data=false,roles.ingest=false,volumeClaimTemplate.resources.requests.storage=1Gi,volumeClaimTemplate.storageClassName=es-min-master-pv-local,volumeClaimTemplate.accessModes[0]=ReadWriteOnce,replicas=1,minimumMasterNodes=1

## 2.ingest node:

helm install --name es-min-ingest --namespace es-min elastic/elasticsearch --version 6.4.3 --set masterService=es-min-master,nodeGroup=ingest,clusterName=es-min,roles.data=false,roles.master=false,volumeClaimTemplate.resources.requests.storage=1Gi,volumeClaimTemplate.storageClassName=es-min-ingest-pv-local,volumeClaimTemplate.accessModes[0]=ReadWriteOnce,replicas=1,minimumMasterNodes=1

## 3.data node:

helm install --name es-min-data --namespace es-min elastic/elasticsearch --version 6.4.3 --set masterService=es-min-master,nodeGroup=data,clusterName=es-min,roles.master=false,roles.ingest=false,volumeClaimTemplate.resources.requests.storage=1Gi,volumeClaimTemplate.storageClassName=es-min-data-pv-local,volumeClaimTemplate.accessModes[0]=ReadWriteOnce,replicas=1,minimumMasterNodes=1

# (4).QA

# QA1:直译意思是节点有了污点无法容忍，执行 kubectl get no -o yaml | grep taint -A 5 之后发现该节点是不可调度的。

```
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
输出与如下类似：
node "test-01" untainted
taint "node-role.kubernetes.io/master:" not found
taint "node-role.kubernetes.io/master:" not found
这将从拥有 node-role.kubernetes.io/master 污点的任何节点（包括主节点）上删除该污点，这意味着调度程序能够将 Pod 调度到任意节点执行。
```
