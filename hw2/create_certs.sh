dir=charts/certs/

echo "Write some Common Name, for example 'root.localhost'"
read -p "Press enter to continue"
openssl req -new -x509 -days 9999 -keyout ${dir}ca-key.pem -out ${dir}ca-crt.pem

echo -e "\n\n\n\n\n\nWrite IP from 'setup_istio.sh' to the Common Name"
read -p "Press enter to continue"
openssl genrsa -out ${dir}server-key.pem 4096
openssl req -new -key ${dir}server-key.pem -out ${dir}server-csr.pem
openssl x509 -req -days 9999 -in ${dir}server-csr.pem -CA ${dir}ca-crt.pem -CAkey ${dir}ca-key.pem -CAcreateserial -out ${dir}server-crt.pem
openssl verify -CAfile ${dir}ca-crt.pem ${dir}server-crt.pem

echo -e "\n\n\n\n\n\nWrite a Common Name that is different from the previous 2, for example 'client.localhost'"
read -p "Press enter to continue"
openssl genrsa -out ${dir}client1-key.pem 4096
openssl req -new -key ${dir}client1-key.pem -out ${dir}client1-csr.pem
openssl x509 -req -days 9999 -in ${dir}client1-csr.pem -CA ${dir}ca-crt.pem -CAkey ${dir}ca-key.pem -CAcreateserial -out ${dir}client1-crt.pem
openssl verify -CAfile ${dir}ca-crt.pem ${dir}client1-crt.pem

echo -e "\n\nRun run_app.sh"
