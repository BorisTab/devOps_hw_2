# k8s and istio
## Prerequisites
* Docker
* kubectl
* helm
* kind
* istioctl
## Deploy
Exec run.sh from root project directory (hw1):
```bash
./run.sh
```

## Test
Follow the link specified at the end of the run.sh script execution or \
\
Get host ip:
```bash
kubectl -n istio-system get service "istio-ingressgateway" -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
```

Get host port:
```bash
kubectl -n istio-system get service "istio-ingressgateway" -o jsonpath='{.spec.ports[?(@.name=="http2")].port}'
```
Go to `http://<ip>:<port>/` from your browser

## Workflow
Ingress Gateway sends all requests from metalLB load balancer to front-server. When you go to the above URL, you get front-server home page. When you press "Example" button, front-server makes a request to back-server, back-server make a request to example.com through Egress Gateway (we can see logs with `kubectl logs -l istio=egressgateway -c istio-proxy -n istio-system`)
