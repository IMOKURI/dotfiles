#######################################################################################################################
# Root CA
#######################################################################################################################
.PHONY: gen-ca-secret-key
gen-ca-secret-key: ## gen-ca-secret-key
	openssl ecparam -name prime256v1 -genkey -noout -out ca-secret.key

.PHONY: gen-ca-csr
gen-ca-csr: ## gen-ca-csr
	openssl req -new -key ca-secret.key -out ca.csr \
		-subj "/CN={{_input_:domain}} Root CA"

.PHONY: gen-ca-extfile
gen-ca-extfile: ## gen-ca-extfile
	@echo "basicConstraints = critical, CA:TRUE" > ca-extfile.cnf
	@echo "keyUsage = critical, keyCertSign, cRLSign" >> ca-extfile.cnf

.PHONY: gen-ca-cert
gen-ca-cert: ## gen-ca-cert
	openssl x509 -req -in ca.csr -signkey ca-secret.key \
		-out ca.crt \
		-days 365 \
		-extfile ca-extfile.cnf

.PHONY: gen-ca
gen-ca: gen-ca-secret-key gen-ca-csr gen-ca-extfile gen-ca-cert ## gen-ca

.PHONY: check-ca-cert
check-ca-cert: ## check-ca-cert
	openssl x509 -in ca.crt -text

.PHONY: clean-ca
clean-ca: ## clean-ca
	rm -f ca-secret.key ca.csr ca.crt ca.srl ca-extfile.cnf

#######################################################################################################################
# Server Cert for {{_input_:domain}}
#######################################################################################################################
.PHONY: gen-server-secret-key
gen-server-secret-key: ## gen-server-secret-key
	openssl ecparam -name prime256v1 -genkey -noout -out server-secret.key

.PHONY: gen-server-csr
gen-server-csr: ## gen-server-csr
	openssl req -new -key server-secret.key -out server.csr \
		-subj "/CN={{_input_:domain}}"

.PHONY: gen-server-extfile
gen-server-extfile: ## gen-server-extfile
	@echo "basicConstraints = CA:FALSE" > extfile.cnf
	@echo "keyUsage = digitalSignature, keyEncipherment" >> extfile.cnf
	@echo "extendedKeyUsage = serverAuth" >> extfile.cnf
	@echo "subjectAltName = @alt_names" >> extfile.cnf
	@echo "" >> extfile.cnf
	@echo "[alt_names]" >> extfile.cnf
	@echo "DNS.1 = {{_input_:domain}}" >> extfile.cnf

.PHONY: gen-server-cert
gen-server-cert: ## gen-server-cert
	openssl x509 -req -in server.csr -CA ca.crt -CAkey ca-secret.key -CAcreateserial \
		-out server.crt \
		-days 365 \
		-extfile extfile.cnf

.PHONY: gen-server
gen-server: gen-server-secret-key gen-server-csr gen-server-extfile gen-server-cert ## gen-server

.PHONY: check-server-cert
check-server-cert: ## check-server-cert
	openssl x509 -in server.crt -text

.PHONY: clean-server
clean-server: ## clean-server
	rm -f server-secret.key server.csr server.crt extfile.cnf

.PHONY: create-k8s-secret
create-k8s-secret: ## create-k8s-secret
	kubectl create secret tls server-cert \
		--cert=server.crt \
		--key=server-secret.key
