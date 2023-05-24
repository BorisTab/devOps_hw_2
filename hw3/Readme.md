# k8s and istio
## Prerequisites
* Docker
* kubectl
* helm
* kind
* istioctl
## Deploy
Exec setup_istio.sh from root project directory (hw1) and follow instructions:
```bash
./setup_istio.sh
```

## Test
Follow the instruction specified at the end of the run_app.sh script execution or \
\
Get host ip:
```bash
kubectl -n istio-system get service "istio-ingressgateway" -o jsonpath='{.status.loadBalancer.ingress[0].ip}'
```
Test with curl:
```bash
curl --cert charts/certs/client1-crt.pem --key charts/certs/client1-key.pem --cacert charts/certs/ca-crt.pem https://<ip>
```
