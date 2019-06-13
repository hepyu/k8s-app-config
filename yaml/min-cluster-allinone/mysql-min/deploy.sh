kubectl create namespace mysql-min
kubectl apply -f mysql-min-storageclass-local.yaml
kubectl apply -f mysql-min-pv-local.yaml
kubectl apply -f mysql-min-pvc.yaml
kubectl apply -f mysql-min-secret.yaml
kubectl apply -f mysql-min-service.yaml
kubectl apply -f mysql-min-deployment.yaml
