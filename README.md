
# QA

## QA1.storage资源不足发生pod驱逐
demo机器盘小，我都调成了100M。
```
Events:
  Type     Reason            Age                    From               Message
  ----     ------            ----                   ----               -------
  Warning  FailedScheduling  6m14s (x6 over 7m37s)  default-scheduler  0/1 nodes are available: 1 node(s) had taints that the pod didn't tolerate.
  Normal   Scheduled         6m14s                  default-scheduler  Successfully assigned es-min-kibana/es-min-kibana-kibana-6c685b8d68-cbstb to future
  Normal   Pulling           6m13s                  kubelet, future    pulling image "docker.elastic.co/kibana/kibana:6.4.3"
  Normal   Pulled            5m13s                  kubelet, future    Successfully pulled image "docker.elastic.co/kibana/kibana:6.4.3"
  Normal   Created           5m13s                  kubelet, future    Created container
  Normal   Started           5m12s                  kubelet, future    Started container
  Warning  Unhealthy         4m6s (x4 over 4m55s)   kubelet, future    Readiness probe failed:
  Warning  Evicted           4m6s                   kubelet, future    The node was low on resource: ephemeral-storage. Container kibana was using 66732Ki, which exceeds its request of 0.
  Normal   Killing           4m6s                   kubelet, future    Killing container with id docker://kibana:Need to kill Pod
```
