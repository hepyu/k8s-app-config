kubectl apply -f redis-cluster-min-namespace.yaml
kubectl create configmap redis-conf --namespace=redis-cluster-min --from-file=redis.conf

kubectl apply -f redis-cluster-min-service.yaml 
#kubectl apply -f redis-cluster-min-secret.yaml
kubectl apply -f redis-cluster-min-pv-local.yaml
kubectl apply -f redis-cluster-min-statefulset.yaml
