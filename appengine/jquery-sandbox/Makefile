all: js_debug css_debug

update: js_release css_release
	appcfg.py update app

js_debug:
	cd js && make clean && make debug

js_release:
	cd js && make clean && make release

css_debug:
	cd css && make clean && make debug

css_release:
	cd css && make clean && make release

setup:
	pip install yuicompressor closure

server:
	dev_appserver.py -a 0.0.0.0 --high_replication app/
