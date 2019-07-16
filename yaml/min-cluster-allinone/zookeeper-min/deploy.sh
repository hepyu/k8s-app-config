kubectl apply -f zookeeper-min-statefulset.yaml
kubectl apply -f zookeeper-min-pv.yaml

#kubectl delete pv zookeeper-min-data0-pv-local zookeeper-min-data1-pv-local  zookeeper-min-data2-pv-local
