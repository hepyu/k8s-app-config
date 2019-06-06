# (1).下载镜像

docker pull kibana:6.4.3

重命名镜像为：docker.elastic.co/kibana/kibana:6.4.3
docker images |grep kibana |awk '{print "docker tag ",$1":"$2,$1":"$2}' |sed -e 's#kibana#docker\.elastic\.co\/kibana\/kibana#2' |sh -x

Add the elastic helm charts repo
helm repo add elastic https://helm.elastic.co


# (2).helm部署
helm install --name es-min-kibana elastic/kibana --namespace es-min-kibana --version 6.4.3 --set elasticsearchHosts=http://es-min-ingest.es-min:9200,elasticsearchURL=http://es-min-ingest.es-min:9200
