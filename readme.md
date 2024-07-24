kubectl label namespace sock-shop app.kubernetes.io/managed-by=Helm
kubectl annotate namespace sock-shop meta.helm.sh/release-name=app1
kubectl annotate namespace sock-shop meta.helm.sh/release-namespace=sock-shop



helm install app1 app --namespace sock-shop
