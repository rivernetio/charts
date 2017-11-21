.DEFAULT_GOAL := install

PACKAGE=tensorflow tensorflow-serving jupyter 
PACKAGE_ECP=tomcat vote

init:
	helm init --client-only

$(PACKAGE): init
	helm package stable/$@

$(PACKAGE_ECP): init
	helm package stable/$@

install: $(PACKAGE)
	mv *.tgz repo/stable
	helm repo index --url https://github.com/rivernetio/charts/raw/master/repo/stable repo/stable

install_ecp: $(PACKAGE) $(PACKAGE_ECP)
	mv *.tgz repo/local
	helm repo index --url http://127.0.0.1:8879/charts repo/local

cleanall:
	rm -f repo/stable/*
	rm -f repo/local/*

