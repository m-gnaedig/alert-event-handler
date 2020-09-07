FROM        golang:alpine3.11 AS build
MAINTAINER  Manfred Gnaedig <manfred.gnaedig@gmail.com>

# Install WebHook
ENV         WEBHOOK_VERSION 2.7.0
WORKDIR     /go/src/github.com/adnanh/webhook
RUN         apk add --update -t build-deps curl libc-dev gcc libgcc
RUN         curl -L --silent -o webhook.tar.gz https://github.com/adnanh/webhook/archive/${WEBHOOK_VERSION}.tar.gz && \
            tar -xzf webhook.tar.gz --strip 1 &&  \
            go get -d && \
            go build -o /usr/local/bin/webhook && \
            apk del --purge build-deps && \
            rm -rf /var/cache/apk/* && \
            rm -rf /go
FROM        alpine:3.11
COPY        --from=build /usr/local/bin/webhook /usr/local/bin/webhook
RUN         mkdir -p /var/scripts/
COPY        hooks.json /etc/webhook/hooks.json
COPY        hook1.sh /var/scripts/hook1.sh
RUN         chmod +x /var/scripts/hook1.sh
RUN         chmod +x /var/scripts/
RUN         mkdir -p /usr/local/openresty/nginx/client_body_temp
RUN         mkdir -p /usr/local/openresty/nginx/proxy_temp

# Install OC OpenShift Client
ENV         OC_OPENSHIFT_CLIENT_VERSION 3.11.276
RUN         apk  --no-cache add ca-certificates wget
RUN         wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
RUN         wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.28-r0/glibc-2.28-r0.apk
RUN         apk  add glibc-2.28-r0.apk
RUN         apk add --no-cache --virtual .build-deps \
              curl \
              tar \
		      gcc \
		      libc-dev \
		      make \
              && curl --retry 7 -Lo /tmp/client-tools.tar.gz "https://mirror.openshift.com/pub/openshift-v3/clients/${OC_OPENSHIFT_CLIENT_VERSION}/linux/oc.tar.gz"
RUN         tar zxf /tmp/client-tools.tar.gz -C /usr/local/bin oc \
            && rm /tmp/client-tools.tar.gz \
            && apk del .build-deps
RUN         apk add --update ca-certificates
RUN         chmod +x /usr/local/bin/oc
RUN         mkdir /.kube
RUN         touch /.kube/config
RUN         chmod 666 /.kube/config
RUN         /usr/local/bin/oc version

# Install kubectl command line tool
# https://kubernetes.io/de/docs/tasks/tools/install-kubectl/
ENV         KUBECTL_VERSION v1.19.0
RUN         apk update && apk add git curl
RUN         curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl
RUN         chmod u+x kubectl && mv kubectl /usr/local/bin/kubectl
RUN         chmod +x /usr/local/bin/kubectl
RUN         ls -all /usr/local/bin/

# General Container Settings 
WORKDIR     /etc/webhook
VOLUME      ["/etc/webhook"]
EXPOSE      9000
ENTRYPOINT  ["/usr/local/bin/webhook"]
CMD         ["-verbose", "-hooks=/etc/webhook/hooks.json", "-hotreload"]
