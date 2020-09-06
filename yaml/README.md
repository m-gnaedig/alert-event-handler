# Alert-Event-Handler Helm Chart
WebHook Alert-Event-Handler for Prometheus Alertmanager and Grafana Notification Channels.

### Configure Alert-Event-Handler Commands
Add your necessary commands to configmap.yaml

### Deploy Alert-Event-Handler via YAML files

```
kubectl apply -f alert-event-handler.yaml
kubectl apply -f configmap.yaml
kubectl apply -f service.yaml
```