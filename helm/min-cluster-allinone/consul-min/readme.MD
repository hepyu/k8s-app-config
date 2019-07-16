helm install --name consul --namespace=consul stable/consul --set 'Replicas=1,StorageClass=consul-data-pv'
