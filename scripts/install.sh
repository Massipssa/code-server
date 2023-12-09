VALUES_PATH="."
helm install vscode -f ${VALUES_PATH} 

# forward service port
kubectl port-forward svc/code-server  80:80