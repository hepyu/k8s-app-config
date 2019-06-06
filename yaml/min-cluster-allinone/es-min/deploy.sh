kubectl apply -f es-min-data-storageclass-local.yaml
kubectl apply -f es-min-ingest-storageclass-local.yaml
kubectl apply -f es-min-master-storageclass-local.yaml

kubectl apply -f es-min-data0-pv-local.yaml
kubectl apply -f es-min-ingest0-pv-local.yaml
kubectl apply -f es-min-master0-pv-local.yaml

kubectl apply -f es-min-data-statefulset.yaml
kubectl apply -f es-min-ingest-statefulset.yaml
kubectl apply -f es-min-master-statefulset.yaml

kubectl apply -f es-min-pvc.yaml
kubectl apply -f es-min-service.yaml
