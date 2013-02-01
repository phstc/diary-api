TESTS = $(shell find test -name "*test.coffee")
COFFEE_FILES = $(shell find . -name "*.coffee")

# test: compile test-unit
test: test-unit

compile-all: compile

compile:
	coffee --join all.js --compile $(COFFEE_FILES)

test-unit:
	./node_modules/.bin/mocha $(TESTS) --reporter list --compilers coffee:coffee-script

server:
	supervisor coffee server.coffee


.PHONY: test-unit test compile
