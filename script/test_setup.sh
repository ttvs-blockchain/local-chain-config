#!/bin/bash

export PATH=${PWD}/../bin:$PATH
export FABRIC_CFG_PATH=${PWD}/../config

cd ..
DIR_PATH=${PWD}
echo ${PWD}
rm -rf tmp
mkdir -p tmp
cd tmp

git clone https://github.com/ttvs-blockchain/local-chaincode.git

cd ${DIR_PATH}/test-network
bash network.sh down
bash network.sh up createChannel -c mychannel -ca
bash network.sh deployCC -ccn basic -ccp ${DIR_PATH}/tmp/local-chaincode -ccl go

# Environment variables for Org1
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=localhost:7051
export CORE_CHAINCODE_ID_NAME=basic

# cd ${DIR_PATH}/tmp
# git clone https://github.com/ttvs-blockchain/local-chain.git
# cd local-chain

# go build -o local-chain
# chmod +x local-chain
# ./local-chain
