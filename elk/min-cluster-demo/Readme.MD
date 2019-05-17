
(1).elasticsearch min-cluster deploy:
1.master node:
helm install --name es-min-c0-master --namespace elasticsearch elastic/elasticsearch --version 6.4.3 --set masterService=es-min-c0-master,nodeGroup=master,clusterName=es-min-c0,roles.data=false,roles.ingest=false,volumeClaimTemplate.resources.requests.storage=1Gi,volumeClaimTemplate.storageClassName=pv-es-min-c0-master,volumeClaimTemplate.accessModes[0]=ReadWriteOnce,replicas=1,minimumMasterNodes=1
2.ingest node:
helm install --name es-min-c0-ingest --namespace elasticsearch elastic/elasticsearch --version 6.4.3 --set masterService=es-min-c0-master,nodeGroup=ingest,clusterName=es-min-c0,roles.data=false,roles.master=false,volumeClaimTemplate.resources.requests.storage=1Gi,volumeClaimTemplate.storageClassName=pv-es-min-c0-ingest,volumeClaimTemplate.accessModes[0]=ReadWriteOnce,replicas=1,minimumMasterNodes=1
3.data node:
helm install --name es-min-c0-data --namespace elasticsearch elastic/elasticsearch --version 6.4.3 --set masterService=es-min-c0-master,nodeGroup=data,clusterName=es-min-c0,roles.master=false,roles.ingest=false,volumeClaimTemplate.resources.requests.storage=1Gi,volumeClaimTemplate.storageClassName=pv-es-min-c0-data,volumeClaimTemplate.accessModes[0]=ReadWriteOnce,replicas=1,minimumMasterNodes=1

(2).kibana deploy:
helm install --name kibana-es-min-c0 elastic/kibana --namespace elasticsearch --version 6.4.3 --set elasticsearchHosts=http://es-min-c0-ingest.elasticsearch:9200,elasticsearchURL=http://es-min-c0-ingest.elasticsearch:9200