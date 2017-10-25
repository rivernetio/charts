# Deploy gitlab

```
tar -zcvf gitlab-ce-0.1.1.tgz gitlab-ce
helm install --name gitlab --namespace=skyform-ecp gitlab-ce-0.1.1.tgz
```

# Login gitlab

```
gitlab NodePort: 31092
User Name: root
Password: password
External URL: http://223.223.188.133:31092
```
