NAME = vernemq
VERNEMQ_VERSION = 1.13.0
VERSION = $(VERNEMQ_VERSION)-1
VERNEMQ_DIR = vernemq
PATHS = etc lib usr var
DEB_BUILD_ROOT = build
VERNEMQ_BUILD_DIR = $(VERNEMQ_DIR)/_build/default/rel/vernemq

dist : clean checkout pkg

pkg : build assemble
	fpm -s dir \
		-t deb \
		-n $(NAME) \
		-v $(VERSION) \
		-m 'packaging@solarnetwork.org.nz' \
		--vendor 'SolarNetwork Foundation' \
		--description 'VerneMQ MQTT broker' \
		--license 'Apache 2.0' \
		-f \
		-d 'libsnappy1v5 (>= 1.1.8)' \
		-d 'libc6 (>= 2.17)' \
		-d 'libgcc-s1 (>= 3.0)' \
		-d 'libssl1.1 (>= 1.1.1)' \
		-d 'libstdc++6 (>= 5.2)' \
		--after-install $(NAME).postinst \
		--before-remove $(NAME).prerm \
		--chdir $(DEB_BUILD_ROOT) \
		$(PATHS)
		
clean :
	git -C $(VERNEMQ_DIR) clean -fdxq
	rm -rf $(DEB_BUILD_ROOT)
	rm -f $(NAME)_$(VERSION)_*.deb

checkout :
	git -C $(VERNEMQ_DIR) checkout $(VERNEMQ_VERSION)

build : $(VERNEMQ_DIR)/_build/default/rel/vernemq

$(VERNEMQ_DIR)/_build/default/rel/vernemq :
	$(MAKE) -C $(VERNEMQ_DIR) rel OVERLAY_VARS=vars/deb_vars.config

assemble : $(DEB_BUILD_ROOT)

$(DEB_BUILD_ROOT) : build
	mkdir -p $(DEB_BUILD_ROOT)/etc
	mkdir -p $(DEB_BUILD_ROOT)/usr/bin
	mkdir -p $(DEB_BUILD_ROOT)/usr/lib
	mkdir -p $(DEB_BUILD_ROOT)/usr/share
	mkdir -p $(DEB_BUILD_ROOT)/var/lib/vernemq
	mkdir -p $(DEB_BUILD_ROOT)/var/log
	cp -a $(VERNEMQ_BUILD_DIR) $(DEB_BUILD_ROOT)/usr/lib
	mv $(DEB_BUILD_ROOT)/usr/lib/vernemq/etc $(DEB_BUILD_ROOT)/etc/vernemq
	ln $(DEB_BUILD_ROOT)/usr/lib/vernemq/bin/vernemq $(DEB_BUILD_ROOT)/usr/bin
	ln $(DEB_BUILD_ROOT)/usr/lib/vernemq/bin/vmq-admin $(DEB_BUILD_ROOT)/usr/bin
	ln $(DEB_BUILD_ROOT)/usr/lib/vernemq/bin/vmq-passwd $(DEB_BUILD_ROOT)/usr/bin
	mv $(DEB_BUILD_ROOT)/usr/lib/vernemq/share $(DEB_BUILD_ROOT)/usr/share/vernemq
	mv $(DEB_BUILD_ROOT)/usr/lib/vernemq/data $(DEB_BUILD_ROOT)/var/lib/vernemq
	mv $(DEB_BUILD_ROOT)/usr/lib/vernemq/log $(DEB_BUILD_ROOT)/var/log/vernemq
	cp -ar root/* $(DEB_BUILD_ROOT)
