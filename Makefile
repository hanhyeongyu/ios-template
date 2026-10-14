TUIST = TUIST_ROOT_DIR=${PWD} mise exec -- tuist
COMMA := ,

all:
	$(TUIST) generate

dev-%:
	$(TUIST) generate template $(subst $(COMMA), ,$*) --cache-profile all-possible

module:
	$(TUIST) scaffold module --name $(name)

platform:
	$(TUIST) scaffold platform --name $(name)

cache:
	$(TUIST) cache

cache-clean:
	$(TUIST) clean binaries
