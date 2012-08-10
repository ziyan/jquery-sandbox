BS_TARGET = sb.min.css
BS_SOURCES = \
	bootstrap/bootstrap.css \
	sb/sb.sass.css \
	bootstrap/bootstrap.responsive.css \

all: debug

debug: ../app/static/css/$(BS_TARGET)

release: $(BS_TARGET) ../app/static/css/$(BS_TARGET)
	cat $(BS_TARGET) | yuicompressor --type css > ../app/static/css/$(BS_TARGET)

../app/static/css/$(BS_TARGET): $(BS_TARGET)
	mkdir -p ../app/static/css
	cp $(BS_TARGET) ../app/static/css

$(BS_TARGET): $(BS_SOURCES)
	cat $(BS_SOURCES) > $(BS_TARGET)

%.sass.css: %.sass
	cat $< | sass --compass > $<.css

clean:
	find . -iname \*.sass.css -exec rm -f {} \;
	find . -iname \*.min.css -exec rm -f {} \;
	rm -rf .sass-cache
	rm -f ../app/static/css/$(BS_TARGET)
