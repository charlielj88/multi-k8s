docker build -t charlielj88/multi-client:latest -t charlielj88/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t charlielj88/multi-server:latest -t charlielj88/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t charlielj88/multi-worker:latest -t charlielj88/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push charlielj88/multi-client:latest
docker push charlielj88/multi-server:latest
docker push charlielj88/multi-worker:latest

docker push charlielj88/multi-client:$SHA
docker push charlielj88/multi-server:$SHA
docker push charlielj88/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=charlielj88/multi-server:$SHA
kubectl set image deployments/client-deployment client=charlielj88/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=charlielj88/multi-worker:$SHA