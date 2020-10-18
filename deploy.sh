docker build -t newtoniumx3/multi-client:latest -t newtoniumx3/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t newtoniumx3/multi-server:latest -t newtoniumx3/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t newtoniumx3/multi-worker:latest -t newtoniumx3/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push newtoniumx3/multi-client:latest
docker push newtoniumx3/multi-client:$SHA
docker push newtoniumx3/multi-server:latest
docker push newtoniumx3/multi-server:$SHA
docker push newtoniumx3/multi-worker:latest
docker push newtoniumx3/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=newtoniumx3/multi-server:$SHA
kubectl set image deployments/client-deployment client=newtoniumx3/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=newtoniumx3/multi-worker:$SHA

