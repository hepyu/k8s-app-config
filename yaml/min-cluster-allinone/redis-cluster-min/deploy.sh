kubectl create namespace redis-cluster-min
kubectl apply -f redis-configmap.yaml
kubectl apply -f redis-service.yaml
kubectl apply -f redis-statefulset.yaml
kubectl apply -f redis-pv-local.yaml
