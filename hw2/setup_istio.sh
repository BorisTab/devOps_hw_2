kind create cluster

istioctl install --set meshConfig.outboundTrafficPolicy.mode=REGISTRY_ONLY --set profile=demo -y

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml
kubectl wait --namespace metallb-system \
                --for=condition=ready pod \
                --selector=app=metallb \
                --timeout=90s
kubectl apply -f https://kind.sigs.k8s.io/examples/loadbalancer/metallb-config.yaml

ip=$(kubectl -n istio-system get service "istio-ingressgateway" -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

echo -e "\n\nUse IP ${ip} to create mTLS certificates, the IP will need to be entered in the specified location, run create_certs.sh"
