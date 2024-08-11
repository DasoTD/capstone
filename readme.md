kubectl label namespace sockshop app.kubernetes.io/managed-by=Helm
kubectl annotate namespace sockshop meta.helm.sh/release-name=app1
kubectl annotate namespace sockshop meta.helm.sh/release-namespace=sockshop



helm install app1 app --namespace sockshop
