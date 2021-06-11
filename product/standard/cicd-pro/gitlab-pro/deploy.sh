kubectl create namespace gitlab
kubectl apply -f gitlab-rc.yml
kubectl apply -f gitlab-svc.yml
kubectl apply -f postgresql-rc.yml
kubectl apply -f postgresql-svc.yml
kubectl apply -f redis-rc.yml
kubectl apply -f redis-svc.yml
