#bin bash
#list of all nodes in the cluster
kubectl get nodes 
# get detailed information about the node.Replace <NODE_NAME> with the value you have copied.
kubectl describe node labs  
#create a new namespace. Add namespace name here
kubectl create namespace team-12-customers 
#list of all available workspaces within the Kubernetes cluster
kubectl get namespaces
# To store the configuration required to create the namespace in a Kubernetes manifest file, use the same command which you have used to create the namespace
kubectl create namespace team-12-customers --dry-run=client -o yaml > team-12-namespace.yml
# To view the contents of the manifest file, use the cat command as follows
cat team-12-namespace.yml
# To test that the manifest file works, first delete the namespace using the following command:
kubectl delete namespace team-12-customers
#Use the kubectl command to create the namespace from the file which contains the manifest
kubectl create -f team-12-namespace.yml
#Since the team will work only from this workspace, set it as the default workspace
kubectl config set-context --current --namespace=team-12-customers
# Use kubectl to create a new deployment named simple-api-deployment. With the --image option, specify the Docker image and the tag
kubectl create deployment simple-api-deployment --image=veveritaengineering/simple-api:1
#Use the following kubectl command to verify if the deployment was created:
kubectl get deployments
# List the pods created by the deployment using the following command
kubectl get pods
#To store the configuration required to create the deployment in a Kubernetes manifest file
kubectl create deployment simple-api-deployment --image=veveritaengineering/simple-api:1  --dry-run=client -o yaml > team-12-deployment.yml
#To view the contents of the manifest file, use the cat command as follows:
cat team-12-deployment.yml
# To test that the manifest file works, first delete the deployment using kubectl delete
kubectl delete deployment/simple-api-deployment
# Use the kubectl command to create the deployment from the file containing the manifest.
kubectl create -f team-12-deployment.yml
#Create a Kubernetes service that exposes the deployment on port 3000. Ensure that the service type is LoadBalancer.
kubectl expose deployment simple-api-deployment --type=LoadBalancer --port=3000
#Get information about the services available using the following command:
kubectl get services
#Use curl to access the application. Replace LOCAL_PORT with the local port where the service is accessible.
curl http://localhost:LOCAL_PORT
# To store the configuration required to create the service in a Kubernetes manifest file, use the same command which you have used to create the service
kubectl expose deployment simple-api-deployment --type=LoadBalancer --port=3000 --dry-run=client -o yaml > team-12-service-loadbalancer.yml
# To view the contents of the manifest file, use the cat command as follows
cat team-12-service-loadbalancer.yml
#To test that the manifest file works, first delete the service using kubectl delete
kubectl delete service/simple-api-deployment
# Use the kubectl command to create the service from the file containing the manifest.
kubectl create -f team-12-service-loadbalancer.yml
#To get information about the available services, use the following command:
kubectl get services
#Locate the kubernetes-dashboard.yaml file and verify its content using the cat command.
cat kubernetes-dashboard.yaml
#Use the kubectl command to deploy the Kubernetes Dashboard from the file containing the manifest.
kubectl create -f kubernetes-dashboard.yaml
# Use the following command to expose the Kubernetes Dashboard:
kubectl port-forward --address 0.0.0.0 -n kubernetes-dashboard service/kubernetes-dashboard 8080:80 &
#Using the kubectl scale command, increase the replicas from 1 to 4 for the simple-api-deployment
kubectl scale --replicas=4 deployment simple-api-deployment
# Verify that the four pods are now available by running the following command:
kubectl get pods
#Use kubectl get services to get the local port of the service.
kubectl get services
#Run the curl command against the application a few times and observe that the application is served by different pods
curl http://localhost:LOCAL_PORT
#1.	Verify the current version of the deployment by using kubectl describe to get details about the deployment:
kubectl describe deployment simple-api-deployment
#Use the command kubectl set image to change the tag for the simple-api-deployment deployment.
kubectl set image deployment/simple-api-deployment simple-api=veveritaengineering/simple-api:2
# Verify that the version change has been made by using kubectl describe
kubectl describe deployment simple-api-deployment
# Run the curl command against the application a few times and observe if the application version has changed:
curl http://localhost:LOCAL_PORT
# Use vim to open the manifest file:
vim team-12-deployment.yml
# Use the kubectl replace command to replace the deployment from the file containing the manifest.
kubectl replace -f team-12-deployment.yml
# Replicate the error by trying to access the application using curl. Replace LOCAL_PORT with the local port where the load balancer service is accessible.
curl http://localhost:LOCAL_PORT
# List all the pods using the following command:
kubectl get pods
# Modify the load balancer service to communicate with the application on port 3001. Using vim, edit the manifest file team-12-service-loadbalancer.yml
vim team-12-service-loadbalancer.yml
#Use the kubectl replace command to replace the service from the file containing the manifest.
kubectl replace -f team-12-service-loadbalancer.yml
# Use the previously used curl command to verify if the application is accessible.
curl http://localhost:LOCAL_PORT
# Use the kubectl delete command to delete the load balancer service by specifying the team-12-service-loadbalancer.yml manifest file.
kubectl delete -f team-12-service-loadbalancer.yml
# Use the kubectl delete command to delete the load balancer service by specifying the team-12-service-loadbalancer.yml manifest file.
kubectl delete -f team-12-service-loadbalancer.yml
# Use the kubectl delete command to delete the deployment specifying the team-12-deployment.yml manifest file.
kubectl delete -f team-12-deployment.yml




















