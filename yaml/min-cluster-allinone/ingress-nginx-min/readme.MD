#backend deploy
kubectl apply -f ingress-nginx-backend-deployment.yaml
kubectl apply -f ingress-nginx-backend-service.yaml
#controller deploy
kubectl apply -f ingress-nginx-deployoment.yaml
kubectl apply -f ingress-nginx-service.yaml
#进入ingress的pod
kubectl exec -it -n ingress-nginx nginx-ingress-controller-5c4b565896-6kk9n bash 
