#######################################################################################################################
# Root CA
#######################################################################################################################
.PHONY: gen-ca-secret-key
gen-ca-secret-key: ## gen-ca-secret-key
	openssl genpkey -algorithm ed25519 -out ca-secret.key


.PHONY: gen-ca-csr
gen-ca-csr: ## gen-ca-csr
	openssl req -new -key ca-secret.key -out ca.csr \
		-subj "/CN=Root CA"

.PHONY: gen-ca-cert
gen-ca-cert: ## gen-ca-cert
	openssl x509 -req -in ca.csr -signkey ca-secret.key -out ca.crt -days 3650

#######################################################################################################################
# Server Cert for {{_input_:domain}}
#######################################################################################################################
.PHONY: gen-secret-key
gen-secret-key: ## gen-secret-key
	openssl genpkey -algorithm ed25519 -out server-secret.key

.PHONY: gen-csr
gen-csr: ## gen-csr
	openssl req -new -key server-secret.key -out server.csr \
		-subj "/CN={{_input_:domain}}"

.PHONY: gen-extfile
gen-extfile: ## gen-extfile
	echo "subjectAltName=DNS:{{_input_:domain}}" > extfile.cnf

.PHONY: gen-cert
gen-cert: ## gen-cert
	openssl x509 -req -in server.csr -CA ca.crt -CAkey ca-secret.key -CAcreateserial -out server.crt -days 3650 \
		-extfile extfile.cnf

.PHONY: create-k8s-secret
create-k8s-secret: ## create-k8s-secret
	kubectl create secret tls server-cert \
		--cert=server.crt \
		--key=server-secret.key
