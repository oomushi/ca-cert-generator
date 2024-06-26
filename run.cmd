@echo off
docker pull smallstep/step-ca
docker pull alpine/openssl
docker pull realguess/jq
start cmd /c docker run -it -v "%cd%:/home/step" -p 9000:9000  -e "DOCKER_STEPCA_INIT_NAME=Smallstep"  -e "DOCKER_STEPCA_INIT_DNS_NAMES=localhost,$(hostname -f)" -e "DOCKER_STEPCA_INIT_REMOTE_MANAGEMENT=true" --name step smallstep/step-ca
echo Copiarsi la password dall'altra schermata quindi premere invio
PAUSE >nul
docker run -it -v "%cd%:/home/step" --entrypoint /home/step/resources/script.sh --name jq realguess/jq
docker restart step
docker exec -it step step ca certificate "nethical.vitaever.localhost" --not-after=26280h /home/step/cert/client.crt /home/step/cert/client.key
docker exec -it step step ca root /home/step/cert/ca.crt
docker run -it -v "%cd%:/home/step" --name openssl alpine/openssl pkcs12 -export -out /home/step/cert/client.p12 -inkey /home/step/cert/client.key -in /home/step/cert/client.crt -certfile /home/step/cert/ca.crt
docker stop step
docker stop openssl
docker stop jq
docker rm step
docker rm openssl
docker rm jq
rmdir certs config db secrets templates /S /Q
