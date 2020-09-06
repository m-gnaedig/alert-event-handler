# Alert-Event-Handler
WebHook Alert-Event-Handler for Prometheus Alertmanager and Grafana Notification Channels. This solution is designed to use in a Kubernetes Cluster.

## First Concept 
This Event-Handler shall execute individual commands like oc commands or kubectl commands listed in a shell script and triggered by Prometheus Alertmanager or Grafana Alert. It can also be used for every command which can be executed in a shell script.

### Included Recourses 
* [WebHook](https://github.com/adnanh/webhook) (Thanks for the great project)
* [OpenShift Client](https://docs.openshift.com/container-platform/4.5/cli_reference/openshift_cli/getting-started-cli.html)
* [Kubectl](https://kubernetes.io/de/docs/tasks/tools/install-kubectl/)

### Deploy
* Deploy via [Kubectl](./yaml)  
* Deploy via [Helm](./hrel)

### Configuration
The commands which shall be executed by an alert can be listed in the file "hook1.sh".

After Create and Deploy the Pod to your Kubernetes Cluster you need also an Kubernetes Service to the Alert-Event-Handler Pod. 

Than you can setup your Event-Handler as a WebHook Alert Receiver in your Prometheus Alertmannager or Grafana Notification Channel.  
http://\<Service-To-Your-Alert-Event-Handler>:9000/hooks/commands 

At the moment there is no Username and Password implemented.
 
#### ToDo:
* Add a solution for WebHook Authentification
 
#### News:
* **28.08.2020:** First idea of this project
* **29.08.2020:** Add OC OpenShift Client to Dockerfile
* **30.08.2020:** Add kubectl to Dockerfile
* **04.09.2020:** Add OC OpenShift Client Version 3.11.276 to Dockerfile
* **05.09.2020:** Create Helm Chart  