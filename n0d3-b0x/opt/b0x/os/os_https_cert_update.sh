#!/bin/bash

# Load _ENV_ params
. $SRC/_ENV_

cp ${SSL_PATH_DIR}/chain.pem ${SSL_PATH_DIR}/_chain.pem
cp ${SSL_PATH_DIR}/cert.pem ${SSL_PATH_DIR}/_cert.pem
cp ${SSL_PATH_DIR}/fullchain.pem ${SSL_PATH_DIR}/_fullchain.pem
cp ${SSL_PATH_DIR}/privkey.pem ${SSL_PATH_DIR}/_privkey.pem

curl --insecure --cert  ${CCA_KEY}:${CCA_PWD} -u "${SSL_REPO_USER}:${SSL_REPO_PWD}" "${SSL_URL_REPO}/chain.pem" > ${SSL_PATH_DIR}/chain.pem
curl --insecure --cert  ${CCA_KEY}:${CCA_PWD} -u "${SSL_REPO_USER}:${SSL_REPO_PWD}" "${SSL_URL_REPO}/cert.pem" > ${SSL_PATH_DIR}/cert.pem
curl --insecure --cert  ${CCA_KEY}:${CCA_PWD} -u "${SSL_REPO_USER}:${SSL_REPO_PWD}" "${SSL_URL_REPO}/fullchain.pem" > ${SSL_PATH_DIR}/fullchain.pem
curl --insecure --cert  ${CCA_KEY}:${CCA_PWD} -u "${SSL_REPO_USER}:${SSL_REPO_PWD}" "${SSL_URL_REPO}/privkey.pem" > ${SSL_PATH_DIR}/privkey.pem

sudo systemctl stop nginx ; sudo systemctl start nginx