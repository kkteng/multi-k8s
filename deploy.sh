docker build -t kkteng/multi-client:latest -t kkteng/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kkteng/multi-server:latest -t kkteng/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kkteng/multi-worker:latest -t kkteng/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kkteng/multi-client:latest
docker push kkteng/multi-server:latest
docker push kkteng/multi-worker:latest
docker push kkteng/multi-client:$SHA
docker push kkteng/multi-server:$SHA
docker push kkteng/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kkteng/multi-server:$SHA
kubectl set image deployments/client-deployment client=kkteng/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kkteng/multi-worker:$SHA
