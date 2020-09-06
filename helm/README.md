# Alert-Event-Handler Helm Chart
WebHook Alert-Event-Handler for Prometheus Alertmanager and Grafana Notification Channels.

### Configure Alert-Event-Handler Commands
Add your necessary commands to values.yaml

### Deploy via Helm 3
```
helm repo add alert-event-handler https://m-gnaedig.github.io/alert-event-handler/helm/
helm repo update
helm upgrade --install -f values.yaml alert-event-handler --namespace=<YourNamespace> alert-event-handler/alert-event-handler
```