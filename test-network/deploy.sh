#!/bin/bash

export PATH=${PWD}/../bin:$PATH

export FABRIC_CFG_PATH=$PWD/../config/

echo ${PWD}

bash /home/tommy/codebase/hyperledger/test-network/network.sh down

bash /home/tommy/codebase/hyperledger/test-network/network.sh up createChannel -c mychannel -ca

bash /home/tommy/codebase/hyperledger/test-network/network.sh deployCC -ccn basic -ccp /home/tommy/codebase/auti-local-chaincode -ccl go

# Environment variables for Org1

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_ADDRESS=localhost:7051


# peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C mychannel -n basic --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"InitLedger","Args":[]}'

# ./network.sh up createChannel -c globalchannel -ca

# ./network.sh deployCC -c globalchannel -ccn basic-global -ccp ../asset-transfer-basic/chaincode-go-global/ -ccl go

# cd ../asset-transfer-basic/application-go
# rm wallet/appUser.id 

# cd ../application-go-global
# rm wallet/appUser.id 