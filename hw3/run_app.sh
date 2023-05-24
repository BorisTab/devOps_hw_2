dir=charts/certs/

kubectl create namespace hw
kubectl label namespace hw istio-injection=enabled 

kubectl create -n istio-system secret generic frontend-certs \
  --from-file=tls.key=${dir}server-key.pem \
  --from-file=tls.crt=${dir}server-crt.pem \
  --from-file=ca.crt=${dir}ca-crt.pem

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

echo -e "\n\nUse curl to check connection:\ncurl --cert ${dir}client1-crt.pem --key ${dir}client1-key.pem --cacert ${dir}ca-crt.pem https://${ip}"
