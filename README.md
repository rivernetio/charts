# How to submit charts

* `stable/` directory contains the source for the packaged and versioned charts. Add new charts directory with source under `stable/`.
* Add new charts to Makefile
* Run `make ECP=1` to build ecp charts packages; run 'make ECP=0' to build aiaas charts packages.
* Commit all changes
***Avoid committing tgz to repo/ without source***


