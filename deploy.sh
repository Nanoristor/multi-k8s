docker build -t bmszone/bms-multi-client:latest -t bmszone/bms-multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bmszone/bms-multi-server:latest -t bmszone/bms-multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bmszone/bms-multi-worker:latest -t bmszone/bms-multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bmszone/bms-multi-client:latest
docker push bmszone/bms-multi-server:latest
docker push bmszone/bms-multi-worker:latest
docker push bmszone/bms-multi-client:$SHA
docker push bmszone/bms-multi-server:$SHA
docker push bmszone/bms-multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=bmszone/bms-multi-client:$SHA
kubectl set image deployments/server-deployment server=bmszone/bms-multi-server:$SHA
kubectl set image deployments/worker-deployment worker=bmszone/bms-multi-worker:$SHA
