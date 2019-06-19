docker build -t garrickd/multi-client:latest -t garrickd/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t garrickd/multi-server:latest -t garrickd/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t garrickd/multi-worker:latest -t garrickd/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push garrickd/multi-client:latest
docker push garrickd/multi-server:latest
docker push garrickd/multi-worker:latest

docker push garrickd/multi-client:$SHA
docker push garrickd/multi-server:$SHA
docker push garrickd/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=garrickd/multi-server:$SHA
kubectl set image deployments/client-deployment client=garrickd/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=garrickd/multi-worker:$SHA

