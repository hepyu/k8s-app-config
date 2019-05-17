参考URL:
https://github.com/elastic/helm-charts/tree/master/elasticsearch

docker pull elasticsearch:6.4.3

重命名镜像为：docker.elastic.co/elasticsearch/elasticsearch:6.4.3
docker images |grep elasticsearch |awk '{print "docker tag ",$1":"$2,$1":"$2}' |sed -e 's#elasticsearch#docker\.elastic\.co\/elasticsearch\/elasticsearch#2' |sh -x

Add the elastic helm charts repo
helm repo add elastic https://helm.elastic.co
Install it
masterService=es-c1-master,

(1).最小配置

最小配置可能有问题，资源不够会不断重启。
3master, 3slave, 3ingest

1.master node:
helm install --name es-c1-master --namespace elasticsearch elastic/elasticsearch --version 6.4.3 --set masterService=es-c1-master,nodeGroup=master,clusterName=es-c1,roles.data=false,roles.ingest=false,volumeClaimTemplate.resources.requests.storage=1Gi,volumeClaimTemplate.storageClassName=es-c1-skywalking,volumeClaimTemplate.accessModes[0]=ReadWriteOnce,resources.requests.memory=1024Mi,resources.limits.memory=1024Mi,esJavaOpts="-Xmx512m -Xms512m",replicas=3,minimumMasterNodes=3
2.ingest node:
helm install --name es-c1-ingest --namespace elasticsearch elastic/elasticsearch --version 6.4.3 --set masterService=es-c1-master,nodeGroup=ingest,clusterName=es-c1,roles.data=false,roles.master=false,volumeClaimTemplate.resources.requests.storage=1Gi,volumeClaimTemplate.storageClassName=es-c1-skywalking-ingest,volumeClaimTemplate.accessModes[0]=ReadWriteOnce,resources.requests.memory=1024Mi,resources.limits.memory=1024Mi,esJavaOpts="-Xmx512m -Xms512m",replicas=3,minimumMasterNodes=3
3.data node:
helm install --name es-c1-data --namespace elasticsearch elastic/elasticsearch --version 6.4.3 --set masterService=es-c1-master,nodeGroup=data,clusterName=es-c1,roles.master=false,roles.ingest=false,volumeClaimTemplate.resources.requests.storage=1Gi,volumeClaimTemplate.storageClassName=es-c1-skywalking-data,volumeClaimTemplate.accessModes[0]=ReadWriteOnce,resources.requests.memory=1024Mi,resources.limits.memory=1024Mi,esJavaOpts="-Xmx512m -Xms512m",replicas=3,minimumMasterNodes=3

4.kibana:
helm install --name es-c1-kibana elastic/kibana --namespace kibana --version 6.4.3 --set elasticsearchHosts=http://es-c1-ingest.elasticsearch:9200,elasticsearchURL=http://es-c1-ingest.elasticsearch:9200

(2).内存默认配置

使用es-helm的默认配置。
3master, 3ingest, 3data

1.master node:
helm install --name es-c1-master --namespace elasticsearch elastic/elasticsearch --version 6.4.3 --set masterService=es-c1-master,nodeGroup=master,clusterName=es-c1,roles.data=false,roles.ingest=false,volumeClaimTemplate.resources.requests.storage=1Gi,volumeClaimTemplate.storageClassName=es-c1-skywalking,volumeClaimTemplate.accessModes[0]=ReadWriteOnce,replicas=3,minimumMasterNodes=3
2.ingest node:
helm install --name es-c1-ingest --namespace elasticsearch elastic/elasticsearch --version 6.4.3 --set masterService=es-c1-master,nodeGroup=ingest,clusterName=es-c1,roles.data=false,roles.master=false,volumeClaimTemplate.resources.requests.storage=1Gi,volumeClaimTemplate.storageClassName=es-c1-skywalking-ingest,volumeClaimTemplate.accessModes[0]=ReadWriteOnce,replicas=3,minimumMasterNodes=3
3.data node:
helm install --name es-c1-data --namespace elasticsearch elastic/elasticsearch --version 6.4.3 --set masterService=es-c1-master,nodeGroup=data,clusterName=es-c1,roles.master=false,roles.ingest=false,volumeClaimTemplate.resources.requests.storage=1Gi,volumeClaimTemplate.storageClassName=es-c1-skywalking-data,volumeClaimTemplate.accessModes[0]=ReadWriteOnce,replicas=3,minimumMasterNodes=3

4.kibana:
helm install --name es-c1-kibana elastic/kibana --namespace kibana --version 6.4.3 --set elasticsearchHosts=http://es-c1-ingest.elasticsearch:9200,elasticsearchURL=http://es-c1-ingest.elasticsearch:9200


(3).最小集群

使用es-helm的默认配置。
1master, 1ingest, 1data

clusterName=es-min-c0

1.master node:
helm install --name es-min-c0-master --namespace elasticsearch elastic/elasticsearch --version 6.4.3 --set masterService=es-min-c0-master,nodeGroup=master,clusterName=es-min-c0,roles.data=false,roles.ingest=false,volumeClaimTemplate.resources.requests.storage=1Gi,volumeClaimTemplate.storageClassName=pv-es-min-c0-master,volumeClaimTemplate.accessModes[0]=ReadWriteOnce,replicas=1,minimumMasterNodes=1
2.ingest node:
helm install --name es-min-c0-ingest --namespace elasticsearch elastic/elasticsearch --version 6.4.3 --set masterService=es-min-c0-master,nodeGroup=ingest,clusterName=es-min-c0,roles.data=false,roles.master=false,volumeClaimTemplate.resources.requests.storage=1Gi,volumeClaimTemplate.storageClassName=pv-es-min-c0-ingest,volumeClaimTemplate.accessModes[0]=ReadWriteOnce,replicas=1,minimumMasterNodes=1
3.data node:
helm install --name es-min-c0-data --namespace elasticsearch elastic/elasticsearch --version 6.4.3 --set masterService=es-min-c0-master,nodeGroup=data,clusterName=es-min-c0,roles.master=false,roles.ingest=false,volumeClaimTemplate.resources.requests.storage=1Gi,volumeClaimTemplate.storageClassName=pv-es-min-c0-data,volumeClaimTemplate.accessModes[0]=ReadWriteOnce,replicas=1,minimumMasterNodes=1

4.kibana deploy:
helm install --name es-min-c0-kibana elastic/kibana --namespace kibana --version 6.4.3 --set elasticsearchHosts=http://es-min-c0-ingest.elasticsearch:9200,elasticsearchURL=http://es-min-c0-ingest.elasticsearch:9200