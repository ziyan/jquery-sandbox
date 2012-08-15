WORKER_JS_TARGET = build/worker.js
WORKER_JS_SOURCES = \
	src/js/json2.js \
	src/js/worker.coffee.js \

SANDBOX_JS_TARGET = build/sandbox.js
SANDBOX_JS_SOURCES = \
	src/js/json2.js \
	src/js/sandbox.coffee.js \

JQUERY_SANDBOX_JS_TARGET = build/jquery.sandbox.js
JQUERY_SANDBOX_JS_SOURCES = \
	src/js/jquery.sandbox.coffee.js \

SANDBOX_HTML_TARGET = build/sandbox.html
SANDBOX_HTML_SOURCES = \
	src/html/sandbox.header.html \
	build/sandbox.min.js \
	src/html/sandbox.footer.html \

TEST_HTML_TARGET = build/test.html
TEST_HTML_SOURCES = \
	src/html/test.html \

all: build/jquery.sandbox.min.js build/worker.min.js build/sandbox.html build/test.html

$(TEST_HTML_TARGET): $(TEST_HTML_SOURCES)
	@mkdir -p build
	@cat $(TEST_HTML_SOURCES) > $(TEST_HTML_TARGET)

$(SANDBOX_HTML_TARGET): $(SANDBOX_HTML_SOURCES)
	@mkdir -p build
	@cat $(SANDBOX_HTML_SOURCES) > $(SANDBOX_HTML_TARGET)

$(WORKER_JS_TARGET): $(WORKER_JS_SOURCES)
	@mkdir -p build
	@cat $(WORKER_JS_SOURCES) > $(WORKER_JS_TARGET)

$(SANDBOX_JS_TARGET): $(SANDBOX_JS_SOURCES)
	@mkdir -p build
	@cat $(SANDBOX_JS_SOURCES) > $(SANDBOX_JS_TARGET)

$(JQUERY_SANDBOX_JS_TARGET): $(JQUERY_SANDBOX_JS_SOURCES)
	@mkdir -p build
	@cat $(JQUERY_SANDBOX_JS_SOURCES) > $(JQUERY_SANDBOX_JS_TARGET)

%.min.js: %.js
	@cat $< | closure > $@

%.coffee.js: %.coffee
	@cat $< | coffee -c -s > $@

clean:
	@find . -iname \*.coffee.js -exec rm -f {} \;
	@find . -iname \*.min.js -exec rm -f {} \;
	@rm -rf build