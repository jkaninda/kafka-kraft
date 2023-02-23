[![Docker-build](https://github.com/jkaninda/kafka-kraft/actions/workflows/build.yml/badge.svg)](https://github.com/jkaninda/kafka-kraft/actions/workflows/build.yml)
![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/jkaninda/kafka-kraft?style=flat-square)
![Docker Pulls](https://img.shields.io/docker/pulls/jkaninda/kafka-kraft?style=flat-square)

# kafka-kraft
Kubernetes Apache Kafka Kraft

## Kubernetes

```yaml
#kafka.yaml
apiVersion: v1
kind: Service
metadata:
  name: kafka
  labels:
    app: kafka-app
spec:
  selector:
    app: kafka-app
  ports:
  - port: 9092
    targetPort: 9092
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: kafka-svc
  labels:
    app: kafka-app
spec:
  serviceName: kafka-svc
  replicas: 3
  selector:
    matchLabels:
      app: kafka-app
  template:
    metadata:
      labels:
        app: kafka-app
    spec:
      containers:
        - name: kafka-container
          image:  jkaninda/kafka-kraft:3.4.0
          ports:
            - containerPort: 9092
            - containerPort: 9093
          env:
            - name: REPLICAS
              value: '3'
            - name: SERVICE
              value: kafka-svc
            - name: NAMESPACE
              value: default
            - name: SHARE_DIR
              value: /mnt/kafka
            - name: CLUSTER_ID
              value: dev-cluster-1
            - name: DEFAULT_REPLICATION_FACTOR
              value: '3'
            - name: DEFAULT_MIN_INSYNC_REPLICAS
              value: '2'
          volumeMounts:
            - name: data
              mountPath: /mnt/kafka
      #imagePullSecrets:
      #  - name: registry-secret
  volumeClaimTemplates:
    - metadata:
        name: data
      spec:
        accessModes:
          - "ReadWriteOnce"
        resources:
          requests:
            storage: "10Gi"
```