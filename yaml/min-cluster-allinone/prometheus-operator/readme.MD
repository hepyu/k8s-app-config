offical github:
https://github.com/coreos/prometheus-operator
https://github.com/coreos/kube-prometheus

yaml文件来自于kubkube-prometheus/manifests/.；

docker pull siriuszg/addon-resizer:1.8.4
docker images |grep addon-resizer |awk '{print "docker tag ",$1":"$2,$1":"$2}' |sed -e 's#siriuszg#k8s.gcr.io#2' |sh -x 
