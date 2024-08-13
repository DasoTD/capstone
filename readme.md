kubectl label namespace sockshop app.kubernetes.io/managed-by=Helm
kubectl annotate namespace sockshop meta.helm.sh/release-name=app1
kubectl annotate namespace sockshop meta.helm.sh/release-namespace=sockshop



helm install app1 app --namespace sockshop

aws eks update-kubeconfig --region us-east-1 --name sockshopeks
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.1/deploy/static/provider/aws/deploy.yaml

it is only you that matter