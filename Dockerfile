FROM alpine:3.5

ADD setK8NS.sh /usr/local/bin/

RUN wget -P /usr/local/bin http://storage.googleapis.com/kubernetes-release/release/v1.6.1/bin/linux/amd64/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/setK8NS.sh && \
    mkdir -p ~/.kube

CMD ["/usr/local/bin/kubectl"]