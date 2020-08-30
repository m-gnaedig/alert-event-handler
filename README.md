# Alert-Event-Handler
Webhook Alert-Event-Handler for Prometheus Alertmanager and Grafana Notification Channels.

## First Concept 
The Event-Handler shall execute individual commands like oc commands or kubectl commands listed in a shell script triggered by Prometheus Alertmanager or Grafana Alert.

### Included Recourses 
* [WebHook](https://github.com/adnanh/webhook) (Thanks for the great project)
* [OpenShift Client](https://docs.openshift.com/container-platform/4.5/cli_reference/openshift_cli/getting-started-cli.html)
* [Kubectl](https://kubernetes.io/de/docs/tasks/tools/install-kubectl/)

### Configuration
The commands which shall be executed by an alert can be listed in the file "hook1.sh".

After Create and Deploy the Pod to your Cluster you need also an Kubernetes Service to the Alert-Event-Handler Pod. Than you can execute the Event-Handler by this URL: 
http://\<YourService-To-Alert-Event-Handler>:9000/hooks/oc-commands