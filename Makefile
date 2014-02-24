

.PHONY: test
test: build
	cabal test

.PHONY: build
build: configure
	cabal build

.PHONY: configure
configure:
	cabal configure --enable-tests

.PHONY: configure
run:
	./dist/build/lux/lux

.PHONY: clean
clean:
	cabal clean

.PHONY: lint
lint:
	hlint src
