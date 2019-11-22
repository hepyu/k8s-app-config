kubectl create namespace inc
kubectl apply -f service-apollo-admin-server-dev.yaml
kubectl apply -f service-apollo-config-server-dev.yaml
kubectl apply -f service-apollo-portal-server.yaml
kubectl apply -f apollo-configservice-transition-service-dev.yaml
kubectl apply -f apollo-configservice-transition-ingress-dev.yaml
