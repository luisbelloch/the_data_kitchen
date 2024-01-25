SRC := docs
OUT := app/docs
MD_FILES := $(wildcard $(SRC)/*.md)
HTML_FILES := $(patsubst $(SRC)/%.md,$(OUT)/%.html,$(MD_FILES))

.PHONY: all
all: $(HTML_FILES) $(OUT)/classic.css $(OUT)/recipe.css

.PHONY: clean
clean:
	rm -rf $(OUT)

.PHONY: watch
watch:
	fswatch -d $(SRC) --latency 1 | xargs -n1 -I{} sh -c "make clean && make -j5 all"

$(OUT):
	mkdir -p $@

$(OUT)/%.html: docs/%.md $(OUT)
	pandoc --standalone --template docs/template.html $< -o $@

$(OUT)/%.css: docs/%.css
	cp $< $@


