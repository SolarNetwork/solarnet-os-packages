NAME = solarflux-vernemq-webhook
DIST = 
VERSION = 1.3.0-1$(if $(DIST),+$(DIST),)
PATHS = lib usr var
APP_BUILD_ROOT = solarflux-vernemq-webhook
ASSEMBLE_DIR = assemble

all : build assemble package

build:
	$(APP_BUILD_ROOT)/../gradlew nativeCompile -p "$(APP_BUILD_ROOT)"

assemble: build
	rm -rf $(ASSEMBLE_DIR)
	mkdir $(ASSEMBLE_DIR)
	cp -a root/* $(ASSEMBLE_DIR)
	cp -a $(APP_BUILD_ROOT)/build/native/nativeCompile/solarflux-webhook $(ASSEMBLE_DIR)/var/lib/fluxhook
	find assemble \( -name .gitignore -or -name .DS_Store \) -delete

package: assemble
	fpm -s dir \
		-t deb \
		-n $(NAME) \
		-v $(VERSION) \
		-m 'packaging@solarnetwork.org.nz' \
		--vendor 'SolarNetwork Foundation' \
		--description 'SolarFlux Authentication VerneMQ Webhook' \
		--license 'GPL 2.0' \
		--url "https://github.com/SolarNetwork/solarnet-os-packages/tree/develop/$(NAME)/debian" \
		-f \
		--after-install $(NAME).postinst \
		--before-remove $(NAME).prerm \
		--after-remove $(NAME).postrm \
		--chdir $(ASSEMBLE_DIR) \
		$(PATHS)
	
clean : 
	rm $(NAME)_$(VERSION)_all.deb
	$(APP_BUILD_ROOT)/../gradlew clean

