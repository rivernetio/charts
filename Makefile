.DEFAULT_GOAL := install

init:
	helm init --client-only

tensorflow: init
	helm package stable/$@

package: tensorflow

install: package
	mv *.tgz repo/stable
	helm repo index --url https://github.com/rivernetio/charts/raw/master/repo/stable repo/stable

