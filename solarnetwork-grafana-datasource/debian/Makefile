NAME = solarnetwork-grafana-datasource
DIST =
VERSION = 4.0.0-1$(if $(DIST),+$(DIST),)
PLUGIN_BUILD_DIR = solarnetwork-grafana-datasource/dist
PLUGIN_INSTALL_DIR = var/lib/grafana/plugins/solarnetwork-solarnetwork-datasource

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
		--depends 'grafana (>= 12.1) | grafana-enterprise (>= 12.1)' \
		var

prep :
	mkdir -p $(PLUGIN_INSTALL_DIR)
	cp -av $(PLUGIN_BUILD_DIR)/* $(PLUGIN_INSTALL_DIR)
	rm -f $(PLUGIN_INSTALL_DIR)/*darwin*
	rm -f $(PLUGIN_INSTALL_DIR)/*windows*
	rm -f $(PLUGIN_INSTALL_DIR)/*arm

clean :
	rm -rf var
	rm -f $(NAME)_$(VERSION)*.deb

