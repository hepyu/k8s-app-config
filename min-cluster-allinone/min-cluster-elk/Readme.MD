docker pull elasticsearch:6.4.3

重命名镜像为：docker.elastic.co/elasticsearch/elasticsearch:6.4.3
docker images |grep elasticsearch |awk '{print "docker tag ",$1":"$2,$1":"$2}' |sed -e 's#elasticsearch#docker\.elastic\.co\/elasticsearch\/elasticsearch#2' |sh -x

Add the elastic helm charts repo
helm repo add elastic https://helm.elastic.co

(1).elasticsearch min-cluster deploy--有状态部署

1.master node:
helm install --name es-min-c0-master --namespace elasticsearch elastic/elasticsearch --version 6.4.3 --set masterService=es-min-c0-master,nodeGroup=master,clusterName=es-min-c0,roles.data=false,roles.ingest=false,volumeClaimTemplate.resources.requests.storage=1Gi,volumeClaimTemplate.storageClassName=pv-local-es-min-c0-master,volumeClaimTemplate.accessModes[0]=ReadWriteOnce,replicas=1,minimumMasterNodes=1
2.ingest node:
helm install --name es-min-c0-ingest --namespace elasticsearch elastic/elasticsearch --version 6.4.3 --set masterService=es-min-c0-master,nodeGroup=ingest,clusterName=es-min-c0,roles.data=false,roles.master=false,volumeClaimTemplate.resources.requests.storage=1Gi,volumeClaimTemplate.storageClassName=pv-local-es-min-c0-ingest,volumeClaimTemplate.accessModes[0]=ReadWriteOnce,replicas=1,minimumMasterNodes=1
3.data node:
helm install --name es-min-c0-data --namespace elasticsearch elastic/elasticsearch --version 6.4.3 --set masterService=es-min-c0-master,nodeGroup=data,clusterName=es-min-c0,roles.master=false,roles.ingest=false,volumeClaimTemplate.resources.requests.storage=1Gi,volumeClaimTemplate.storageClassName=pv-local-es-min-c0-data,volumeClaimTemplate.accessModes[0]=ReadWriteOnce,replicas=1,minimumMasterNodes=1

4.kibana
helm install --name kibana-es-min-c0 elastic/kibana --namespace kibana --version 6.4.3 --set elasticsearchHosts=http://es-min-c0-ingest.elasticsearch:9200,elasticsearchURL=http://es-min-c0-ingest.elasticsearch:9200

(2).QA:
QA1:直译意思是节点有了污点无法容忍，执行 kubectl get no -o yaml | grep taint -A 5 之后发现该节点是不可调度的。
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
