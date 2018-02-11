.DEFAULT_GOAL := install

DOCKER_REGISTRY=docker.io
HARBOR_REGISTRY=registry.harbor:5000
HARBOR_REPOSITORY=$(HARBOR_REGISTRY)\/sky-firmament
SOURCE=src

ifeq ($(ECP), 1)
PACKAGE=tomcat vote tensorflow/4.1/tensorflow tensorflow/4.2/tensorflow tensorflow-serving jupyter mnist-demo mysql
else
PACKAGE=tensorflow/4.1/tensorflow tensorflow/4.2/tensorflow tensorflow-serving jupyter mnist-demo mysql
endif

init:
	helm init --client-only

prepare_build_env:
	rm -rf $(SOURCE)
	mkdir -p $(SOURCE)
	cp -rf stable/* $(SOURCE)
ifeq ($(ECP), 1)
	# tensorflow
	sed -i "s@$(DOCKER_REGISTRY)\/rivernet@$(HARBOR_REPOSITORY)@g" $(SOURCE)/tensorflow/4.1/tensorflow/values.yaml
	sed -i "s@$(DOCKER_REGISTRY)\/rivernet@$(HARBOR_REPOSITORY)@g" $(SOURCE)/tensorflow/4.2/tensorflow/values.yaml
	sed -i "s@$(DOCKER_REGISTRY)\/rivernet@$(HARBOR_REPOSITORY)@g" $(SOURCE)/tensorflow/4.2/tensorflow/templates/hybridjob.yaml
	# tensorflow-serving
	sed -i "s@$(DOCKER_REGISTRY)\/rivernet@$(HARBOR_REPOSITORY)@g" $(SOURCE)/tensorflow-serving/values.yaml
	sed -i "s@$(DOCKER_REGISTRY)\/rivernet@$(HARBOR_REPOSITORY)@g" $(SOURCE)/tensorflow-serving/templates/serving.yaml
	# jupyter
	sed -i "s@$(DOCKER_REGISTRY)\/rivernet@$(HARBOR_REPOSITORY)@g" $(SOURCE)/jupyter/values.yaml
	# tomcat
	sed -i "s@$(DOCKER_REGISTRY)\/bitnami@$(HARBOR_REPOSITORY)@g" $(SOURCE)/tomcat/values.yaml
	# vote
	sed -i "s@$(DOCKER_REGISTRY)\/rivernet@$(HARBOR_REPOSITORY)@g" $(SOURCE)/vote/charts/app/values.yaml
	sed -i "s@$(DOCKER_REGISTRY)\/rivernet@$(HARBOR_REPOSITORY)@g" $(SOURCE)/vote/charts/redis/values.yaml
	sed -i "s@$(DOCKER_REGISTRY)\/rivernet@$(HARBOR_REPOSITORY)@g" $(SOURCE)/vote/charts/redis/templates/deployment.yaml
	sed -i "s@$(DOCKER_REGISTRY)\/rivernet@$(HARBOR_REPOSITORY)@g" $(SOURCE)/vote/charts/redis/templates/export-job.yaml
	# mnist-demo
	sed -i "s@$(DOCKER_REGISTRY)\/rivernet@$(HARBOR_REPOSITORY)@g" $(SOURCE)/mnist-demo/values.yaml
	# mysql
	sed -i "s@$(DOCKER_REGISTRY)\/rivernet@$(HARBOR_REPOSITORY)@g" $(SOURCE)/mysql/values.yaml
	sed -i "s@$(DOCKER_REGISTRY)\/rivernet@$(HARBOR_REPOSITORY)@g" $(SOURCE)/mysql/templates/export-job.yaml
endif
	
$(PACKAGE): init prepare_build_env
	helm package $(SOURCE)/$@

install: $(PACKAGE)
ifeq ($(ECP), 1)
	mv *.tgz repo/local
	helm repo index --url http://127.0.0.1:8879/charts repo/local
else
	mv *.tgz repo/stable
	helm repo index --url https://github.com/rivernetio/charts/raw/master/repo/stable repo/stable
endif
	rm -rf $(SOURCE)

cleanall:
	rm -rf *.tgz
	rm -rf $(SOURCE)

