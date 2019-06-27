(1).部署skywalking oap:

注意：
需要先安装es-min，skywalking oap的es指向的是es-min的service。

helm install c7n/skywalking-oap \
--set elasticsearch.host=es-min-ingest.es-min:9200 \
--set env.JAVA_OPTS="-Xms1024M -Xmx1024M" \
--version 0.1.0 \
--name skywalking-oap \
--namespace skywalking-min

(2).安装skywalking ui

注意：
需要先安装ingress。

helm install c7n/skywalking-ui \
--set service.enabled=true \
--set ingress.enabled=true \
--set ingress."hosts[0]"=skywalking.future.com \
--set env.JAVA_OPTS="-Xms1024M -Xmx1024M" \
--version 0.1.1 \
--name skywalking-ui \
--namespace skywalking-min
