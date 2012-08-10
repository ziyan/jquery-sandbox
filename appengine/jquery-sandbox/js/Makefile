BS_TARGET = sb.min.js
BS_SOURCES = \
	json2.js \
	debug.js \
	jquery/jquery.js \
	bootstrap/bootstrap.js \
	sb/sb.coffee.js \
	sb/init.coffee.js \

all: debug

debug: ../app/static/js/$(BS_TARGET)

release: $(BS_TARGET) ../app/static/js/$(BS_TARGET)
	cat $(BS_TARGET) | closure --warning_level QUIET > ../app/static/js/$(BS_TARGET)

../app/static/js/$(BS_TARGET): $(BS_TARGET)
	mkdir -p ../app/static/js
	cp $(BS_TARGET) ../app/static/js

$(BS_TARGET): $(BS_SOURCES)
	cat $(BS_SOURCES) > $(BS_TARGET)

%.coffee.js: %.coffee
	cat $< | coffee -c -s > $<.js

clean:
	find . -iname \*.coffee.js -exec rm -f {} \;
	find . -iname \*.min.js -exec rm -f {} \;
	rm -f ../app/static/js/$(BS_TARGET)
