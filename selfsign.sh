DIR=$HOME/selfsigned
mkdir $DIR
KEY=$DIR/msix.key
CSR=$DIR/msix.csr
CRT=$DIR/msix.crt
PFX=$DIR/CERTIFICATE.pfx

openssl genrsa -out $KEY 2048
openssl req -new -key $KEY -out $CSR
openssl x509 -in $CSR -out $CRT -req -signkey $KEY -days 10000
openssl pkcs12 -export -out $PFX -inkey $KEY -in $CRT