SRC := docs
OUT := app/docs
MD_FILES := $(wildcard $(SRC)/*.md)
HTML_FILES := $(patsubst $(SRC)/%.md,$(OUT)/%.html,$(MD_FILES))

.PHONY: all
all: docs README.md
	 $(MAKE) -C app build

.PHONY: docs
docs: $(HTML_FILES) $(OUT)/classic.css $(OUT)/recipe.css

.PHONY: clean
clean:
	rm -rf $(OUT)
	-rm README.md

.PHONY: watch
watch:
	fswatch -d $(SRC) --latency 1 | xargs -n1 -I{} sh -c "make clean && make -j5 all"

.PHONY: spellcheck
spellcheck:
	$(foreach mdfile, $(MD_FILES), aspell check --dont-backup --mode=markdown --lang=en $(mdfile);)

$(OUT):
	mkdir -p $@

$(OUT)/%.html: docs/%.md $(OUT)
	pandoc --standalone --template docs/template.html $< -o $@

$(OUT)/%.css: docs/%.css
	cp $< $@

README.md:
	tail -n +6 $(SRC)/index.md | sed 's/\(\[.*\]\)(\.\//\1\(\.\/docs\//g;s/\.html/\.md/g' > README.md

