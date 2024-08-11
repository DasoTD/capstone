kubectl label namespace sockshopns app.kubernetes.io/managed-by=Helm
kubectl annotate namespace sockshopns meta.helm.sh/release-name=app1
kubectl annotate namespace sockshopns meta.helm.sh/release-namespace=sockshopns



helm install app1 app --namespace sockshopns
