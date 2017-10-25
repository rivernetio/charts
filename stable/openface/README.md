# Change websocket from 9000 to 31500 before pushing image to harbor

```
docker pull docker.io/bamos/openface
docker run -p 9000:9000 -p 8000:8000 -t -i bamos/openface /bin/bash
cd /root/openface/demos/web/
edit file index.html"; replace 9000 with 31500
docker commit $CONTAINER_ID registry.harbor:5000/demo/openface
docker push registry.harbor:5000/demo/openface 
```
