kubectl create namespace nginx-ingress-min
kubectl apply -f nginx-ingress-min-serviceaccount.yaml

kubectl apply -f nginx-ingress-min-configmap.yaml
kubectl apply -f nginx-ingress-min-role.yaml
kubectl apply -f nginx-ingress-min-rolebinding.yaml

kubectl apply -f nginx-ingress-min-clusterrolebinding.yaml
kubectl apply -f nginx-ingress-min-clusterrole.yaml


kubectl apply -f nginx-ingress-min-backend-deployment.yaml
kubectl apply -f nginx-ingress-min-backend-service.yaml
kubectl apply -f nginx-ingress-min-controller-deployment.yaml
kubectl apply -f nginx-ingress-min-controller-service.yaml
