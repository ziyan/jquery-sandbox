SB_TARGET = sb.min.js
SB_SOURCES = \
	json2.js \
	debug.js \
	jquery/jquery.js \
	jquery/jquery.sandbox.coffee.js \
	bootstrap/bootstrap.js \
	sb/sb.coffee.js \
	sb/init.coffee.js \

JQUERY_SANDBOX_TARGET = jquery.sandbox.min.js
JQUERY_SANDBOX_SOURCES = \
	jquery/jquery.sandbox.coffee.js \

SANDBOX_TARGET = sandbox.min.js
SANDBOX_SOURCES = \
	json2.js \
	debug.js \
	jquery/jquery.js \
	sandbox/sandbox.coffee.js \

WORKER_TARGET = worker.min.js
WORKER_SOURCES = \
	json2.js \
	worker/worker.coffee.js \

all: debug

debug: ../app/static/js/$(SB_TARGET) ../app/static/js/$(JQUERY_SANDBOX_TARGET) ../app/static/js/$(SANDBOX_TARGET) ../app/static/js/$(WORKER_TARGET)

release: $(SB_TARGET) ../app/static/js/$(SB_TARGET) $(JQUERY_SANDBOX_TARGET) ../app/static/js/$(JQUERY_SANDBOX_TARGET) $(SANDBOX_TARGET) ../app/static/js/$(SANDBOX_TARGET) $(WORKER_TARGET) ../app/static/js/$(WORKER_TARGET)
	cat $(SB_TARGET) | closure --warning_level QUIET > ../app/static/js/$(SB_TARGET)
	cat $(JQUERY_SANDBOX_TARGET) | closure --warning_level QUIET > ../app/static/js/$(JQUERY_SANDBOX_TARGET)
	cat $(SANDBOX_TARGET) |  closure --warning_level QUIET > ../app/static/js/$(SANDBOX_TARGET)
	cat $(WORKER_TARGET) | closure --warning_level QUIET > ../app/static/js/$(WORKER_TARGET)

../app/static/js/$(SB_TARGET): $(SB_TARGET)
	mkdir -p ../app/static/js
	cp $(SB_TARGET) ../app/static/js

../app/static/js/$(JQUERY_SANDBOX_TARGET): $(JQUERY_SANDBOX_TARGET)
	mkdir -p ../app/static/js
	cp $(JQUERY_SANDBOX_TARGET) ../app/static/js

../app/static/js/$(SANDBOX_TARGET): $(SANDBOX_TARGET)
	mkdir -p ../app/static/js
	cp $(SANDBOX_TARGET) ../app/static/js

../app/static/js/$(WORKER_TARGET): $(WORKER_TARGET)
	mkdir -p ../app/static/js
	cp $(WORKER_TARGET) ../app/static/js

$(SB_TARGET): $(SB_SOURCES)
	cat $(SB_SOURCES) > $(SB_TARGET)

$(JQUERY_SANDBOX_TARGET): $(JQUERY_SANDBOX_SOURCES)
	cat $(JQUERY_SANDBOX_SOURCES) > $(JQUERY_SANDBOX_TARGET)

$(SANDBOX_TARGET): $(SANDBOX_SOURCES)
	cat $(SANDBOX_SOURCES) > $(SANDBOX_TARGET)

$(WORKER_TARGET): $(WORKER_SOURCES)
	cat $(WORKER_SOURCES) > $(WORKER_TARGET)

%.coffee.js: %.coffee
	cat $< | coffee -c -s > $<.js

clean:
	find . -iname \*.coffee.js -exec rm -f {} \;
	find . -iname \*.min.js -exec rm -f {} \;
	rm -f ../app/static/js/$(SB_TARGET)
	rm -f ../app/static/js/$(JQUERY_SANDBOX_TARGET)
	rm -f ../app/static/js/$(SANDBOX_TARGET)
	rm -f ../app/static/js/$(WORKER_TARGET)

