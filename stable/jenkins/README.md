# Build Jenkins Master image

```
cd master-image
docker build -t registry.harbor:5000/skyform-ecp/jenkins-master-k8s:v0.6.0 .
```

# Build Jenkins Slave image (jnlp+jdk8)

```
cd slave-image
docker build -t registry.harbor:5000/skyform-ecp/jnlp-slave:2.52 .
```

# Deploy Jenkins

```
tar -zcvf jenkins.tgz jenkins
helm install --name jenkins --namespace=skyform-ecp jenkins.tgz
```

# Login Jenkins

```
Jenkins NodePort: 31091
User Name: admin
Password: admin
```

# Functionality
ECP-CICD.docx introduces the architecture overview, functionalities, and demo cases.
