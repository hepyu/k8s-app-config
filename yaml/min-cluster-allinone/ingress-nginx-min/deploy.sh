kubectl create namespace ingress-nginx

#backend deploy
kubectl apply -f ingress-nginx-backend-deployment.yaml
kubectl apply -f ingress-nginx-backend-service.yaml
#controller deploy
kubectl apply -f ingress-nginx-deployoment.yaml
kubectl apply -f ingress-nginx-service.yaml
