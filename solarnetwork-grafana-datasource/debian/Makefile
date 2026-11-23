NAME = solarnetwork-grafana-datasource
DIST =
VERSION = 4.0.0-2$(if $(DIST),+$(DIST),)
PLUGIN_SRC_DIR = solarnetwork-grafana-datasource
PLUGIN_BUILD_DIR = $(PLUGIN_SRC_DIR)/dist
PLUGIN_INSTALL_DIR = var/lib/grafana/plugins/solarnetwork-solarnetwork-datasource
PLUGIN_GIT_URL = https://github.com/SolarNetwork/solarnetwork-grafana-datasource.git
PLUGIN_GIT_REF = ab380537b29bee05b1f97c9372fb28bfe0971574

deb : prep
	fpm -s dir \
		-t deb \
		-n $(NAME) \
		-v $(VERSION) \
		-a all \
		-m 'SolarNetwork Packaging <packaging@solarnetwork.org.nz>' \
		--vendor 'SolarNetwork Foundation' \
		--description 'SolarNetwork data source plugin for Grafana' \
		--license 'General Public License 3.0' \
		--url "https://github.com/SolarNetwork/solarnet-os-packages/tree/develop/solarnetwork-grafana-datasource/debian" \
		--force \
		--after-install $(NAME).postinst \
		--after-remove $(NAME).postrm \
		--depends 'grafana (>= 12.1) | grafana-enterprise (>= 12.1)' \
		var lib

prep :
	test -x $(PLUGIN_BUILD_DIR)/gpx_solarnetwork_datasource_linux_amd64
	test -x $(PLUGIN_BUILD_DIR)/gpx_solarnetwork_datasource_linux_arm64
	rm -rf var
	mkdir -p $(PLUGIN_INSTALL_DIR)
	cp -av $(PLUGIN_BUILD_DIR)/* $(PLUGIN_INSTALL_DIR)
	rm -f $(PLUGIN_INSTALL_DIR)/*darwin*
	rm -f $(PLUGIN_INSTALL_DIR)/*windows*
	rm -f $(PLUGIN_INSTALL_DIR)/*arm
	rm -f $(PLUGIN_INSTALL_DIR)/*.map
	find var lib -type d -exec chmod 755 {} +
	find lib -type f -exec chmod 644 {} +

plugin :
	[ -d $(PLUGIN_SRC_DIR) ] || git clone $(PLUGIN_GIT_URL) $(PLUGIN_SRC_DIR)
	git -C $(PLUGIN_SRC_DIR) fetch -q origin
	git -C $(PLUGIN_SRC_DIR) checkout -q --detach $(PLUGIN_GIT_REF)
	cd $(PLUGIN_SRC_DIR) && npm ci --no-audit --no-fund && npm run build
	cd $(PLUGIN_SRC_DIR) && mage -v build:linux build:linuxARM64

clean :
	rm -rf var
	rm -f $(NAME)_$(VERSION)*.deb

.PHONY : deb prep plugin clean
