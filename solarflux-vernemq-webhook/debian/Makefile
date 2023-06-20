NAME = solarflux-vernemq-webhook
DIST = 
VERSION = 1.1.0-1$(if $(DIST),+$(DIST),)
PATHS = lib var
APP_BUILD_ROOT = solarflux-vernemq-webhook
ASSEMBLE_DIR = assemble
CONF_NAME = example

all : build assemble package

app_version:
	# extract the app version from gradle.properties
	$(eval APP_VERSION = $(shell grep -E '^version\b' $(APP_BUILD_ROOT)/gradle.properties |awk -F '[[:space:]]*=[[:space:]]*' '{ print $$2; }'))

build:
	$(APP_BUILD_ROOT)/gradlew clean build -x test -p "$(APP_BUILD_ROOT)"

assemble: build app_version
	rm -rf $(ASSEMBLE_DIR)
	mkdir $(ASSEMBLE_DIR)
	cp -a root/* $(ASSEMBLE_DIR)
	cp -a conf/$(CONF_NAME)/* $(ASSEMBLE_DIR)/var/lib/fluxhook
	cp -a $(APP_BUILD_ROOT)/build/libs/solarflux-vernemq-webhook-$(APP_VERSION).jar $(ASSEMBLE_DIR)/var/lib/fluxhook
	ln -s solarflux-vernemq-webhook-$(APP_VERSION).jar $(ASSEMBLE_DIR)/var/lib/fluxhook/solarflux-vernemq-webhook.jar
	find assemble \( -name .gitignore -or -name .DS_Store \) -delete

package: assemble
	fpm -s dir \
		-t deb \
		-n $(NAME) \
		-v $(VERSION) \
		-a all \
		-m 'packaging@solarnetwork.org.nz' \
		--vendor 'SolarNetwork Foundation' \
		--description 'SolarFlux Authentication VerneMQ Webhook' \
		--license 'GPL 2.0' \
		--url "https://github.com/SolarNetwork/solarnet-os-packages/tree/develop/$(NAME)/debian" \
		--depends 'java17-runtime-headless' \
		-f \
		--after-install $(NAME).postinst \
		--before-remove $(NAME).prerm \
		--after-remove $(NAME).postrm \
		--chdir $(ASSEMBLE_DIR) \
		$(PATHS)
	
clean : 
	rm $(NAME)_$(VERSION)_all.deb
