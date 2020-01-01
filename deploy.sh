docker build -t ipuskaric12/multi-client:latest -t ipuskaric12/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ipuskaric12/multi-server:latest -t ipuskaric12/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ipuskaric12/multi-worker:latest -t ipuskaric12/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ipuskaric12/multi-client:latest
docker push ipuskaric12/multi-client:$SHA
docker push ipuskaric12/multi-server:latest
docker push ipuskaric12/multi-server:$SHA
docker push ipuskaric12/multi-worker:latest
docker push ipuskaric12/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=ipuskaric12/multi-client:$SHA
kubectl set image deployments/server-deployment server=ipuskaric12/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ipuskaric12/multi-worker:$SHA