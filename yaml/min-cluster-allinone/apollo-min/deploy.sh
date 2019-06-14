kubectl create namespace apollo-min
kubectl apply -f service-apollo-admin-server-dev.yaml
kubectl apply -f service-apollo-config-server-dev.yaml
kubectl apply -f service-apollo-portal-server.yaml
