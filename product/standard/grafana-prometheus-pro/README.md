# (1).详述文章

# (2).grafana/prometheus生产级实践



# (3)容器化执行步骤

## 1.注意事项

a.本配置使用的是local-pv，生产使用要换成云存储，本配置提供nfs的配置(已注释)。

b.imagePullSecret是注释掉的，生产要打开，因为镜像仓库都是有secret的。

c.注意先建立pv目录和挂载，注意目录的权限，否则prometehus, grafana容器化失败，给775或777。

## 2.容器化步骤

kubectl apply -f grafana-prometheus-image-repo-secret.yaml(生产环境需要改成自己的秘钥，本地部署不要执行)

kubectl apply -f grafana-prometheus-namespace.yaml

分别进入子目录执行：kubectl apply -f .
