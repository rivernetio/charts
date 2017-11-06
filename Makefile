.DEFAULT_GOAL := install

PACKAGE=tensorflow-pv serving-pv mxnet-pv jenkins openface vote jupyterhub tomcat

init:
	helm init --client-only

$(PACKAGE): init
	helm package stable/$@

install: $(PACKAGE)
	mv *.tgz repo/stable
	helm repo index --url https://github.com/rivernetio/charts/raw/master/repo/stable repo/stable

cleanall:
	rm -f repo/stable/*

