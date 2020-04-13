docker build -t houyunting/multi-client:latest -t houyunting/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t houyunting/multi-server:latest -t houyunting/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t houyunting/multi-worker:latest -t houyunting/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push houyunting/multi-client:latest
docker push houyunting/multi-server:latest
docker push houyunting/multi-worker:latest

docker push houyunting/multi-client:$SHA
docker push houyunting/multi-server:$SHA
docker push houyunting/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=houyunting/multi-server:$SHA
kubectl set image deployments/client-deployment client=houyunting/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=houyunting/multi-worker:$SHA