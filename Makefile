WORKER_TARGET = build/worker.js
WORKER_SOURCES = \
	js/json2.js \
	js/worker.coffee.js \

SANDBOX_TARGET = build/sandbox.js
SANDBOX_SOURCES = \
	js/json2.js \
	js/sandbox.coffee.js \

JQUERY_SANDBOX_TARGET = build/jquery.sandbox.js
JQUERY_SANDBOX_SOURCES = \
	js/jquery.sandbox.coffee.js \

all: build/jquery.sandbox.min.js build/worker.min.js build/sandbox.html build/test.html

build/test.html: html/test.html
	@mkdir -p build
	@cat html/test.html > build/test.html

build/sandbox.html: html/sandbox.header.html html/sandbox.footer.html build/sandbox.min.js
	@mkdir -p build
	@cat html/sandbox.header.html build/sandbox.min.js html/sandbox.footer.html > build/sandbox.html

$(WORKER_TARGET): $(WORKER_SOURCES)
	@mkdir -p build
	@cat $(WORKER_SOURCES) > $(WORKER_TARGET)

$(SANDBOX_TARGET): $(SANDBOX_SOURCES)
	@mkdir -p build
	@cat $(SANDBOX_SOURCES) > $(SANDBOX_TARGET)

$(JQUERY_SANDBOX_TARGET): $(JQUERY_SANDBOX_SOURCES)
	@mkdir -p build
	@cat $(JQUERY_SANDBOX_SOURCES) > $(JQUERY_SANDBOX_TARGET)

%.min.js: %.js
	@cat $< | closure > $@

%.coffee.js: %.coffee
	@cat $< | coffee -c -s > $@

clean:
	@find . -iname \*.coffee.js -exec rm -f {} \;
	@find . -iname \*.min.js -exec rm -f {} \;
	@rm -rf build