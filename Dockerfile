FROM alpine:latest
ENV OCTANT_VERSION=0.25.1
ENV OCTANT_CHECKSUM=b12bb6752e43f4e0fe54278df8e98dee3439c4066f66cdb7a0ca4a1c7d8eaa1e
ADD https://github.com/vmware-tanzu/octant/releases/download/v${OCTANT_VERSION}/octant_${OCTANT_VERSION}_Linux-64bit.tar.gz /tmp/octant.tar.gz

ENV GCLOUD_VERSION=414.0.0
ENV GCLOUD_CHECKSUM=e0382917353272655959bb650643c5df72c85de326a720b97e562bb6ea4478b1
ADD https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${GCLOUD_VERSION}-linux-x86_64.tar.gz /tmp/gcloud.tar.gz

RUN apk add helm kubectx curl python3

RUN sha256sum /tmp/octant.tar.gz | grep "$OCTANT_CHECKSUM" && \
    if [[ $? -ne 0 ]]; then echo "Bad checksum"; exit 444; fi && \
    tar -xzvf /tmp/octant.tar.gz --strip 1 -C /opt && rm /tmp/octant.tar.gz

RUN mkdir -p /opt/gcloud && sha256sum /tmp/gcloud.tar.gz | grep "$GCLOUD_CHECKSUM" && \
    if [[ $? -ne 0 ]]; then echo "Bad checksum"; exit 444; fi && \
    tar -xzvf /tmp/gcloud.tar.gz --strip 1 -C /opt/gcloud && rm /tmp/gcloud.tar.gz && \
    /opt/gcloud/install.sh -q --usage-reporting false

RUN /opt/gcloud/bin/gcloud components install kubectl gke-gcloud-auth-plugin

COPY docker-entrypoint.sh /
COPY gcloud.sh /etc/profile.d

RUN addgroup -g 2000 -S octant && adduser -u 1000 -h /home/octant -G octant -S octant
USER octant

EXPOSE 7777
ENTRYPOINT /docker-entrypoint.sh
