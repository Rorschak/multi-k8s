docker build -t rorschak/multi-client:latest -t rorschak/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rorschak/multi-server:latest -t rorschak/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rorschak/multi-worker:latest -t rorschak/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rorschak/multi-client:latest
docker push rorschak/multi-server:latest
docker push rorschak/multi-worker:latest

docker push rorschak/multi-client:$SHA
docker push rorschak/multi-server:$SHA
docker push rorschak/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployents/server-deployment server=rorschak/multi-server:$SHA
kubectl set image deployents/client-deployment client=rorschak/multi-client:$SHA
kubectl set image deployents/worker-deployment worker=rorschak/multi-worker:$SHA
