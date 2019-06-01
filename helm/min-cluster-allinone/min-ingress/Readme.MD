下载镜像：
docker pull ibmcom/defaultbackend
重命名镜像为：k8s.gcr.io/defaultbackend:1.4
docker images |grep defaultbackend |awk '{print "docker tag ",$1":"$2,$1":"$2}' |sed -e 's#ibmcom\/defaultbackend#k8s\.gcr\.io\/defaultbackend#2' |sh -x

(1).nginx-ingress deploy:
helm install --name ingress-min --namespace ingress --set "controller.service.externalIPs[0]=47.92.123.228,controller.service.type=NodePort" stable/nginx-ingress