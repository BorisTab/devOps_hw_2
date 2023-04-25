kind create cluster

istioctl install --set meshConfig.outboundTrafficPolicy.mode=REGISTRY_ONLY --set profile=demo -y

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.7/config/manifests/metallb-native.yaml
kubectl wait --namespace metallb-system \
                --for=condition=ready pod \
                --selector=app=metallb \
                --timeout=90s
kubectl apply -f https://kind.sigs.k8s.io/examples/loadbalancer/metallb-config.yaml

kubectl create namespace hw
kubectl label namespace hw istio-injection=enabled 

helm install hw ./charts -n hw
kubectl wait --namespace hw \
                --for=condition=ready pod \
                --selector=app=back-server \
                --timeout=90s
kubectl wait --namespace hw \
                --for=condition=ready pod \
                --selector=app=front-server \
                --timeout=90s

ip=$(kubectl -n istio-system get service "istio-ingressgateway" -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
port=$(kubectl -n istio-system get service "istio-ingressgateway" -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')

echo -e "\n\nGo to http://${ip}:${port}/ from your browser"