NAME = solarnetwork-grafana-datasource
DIST =
VERSION = 3.0.0-1$(if $(DIST),+$(DIST),)
PLUGIN_INSTALL_DIR = solarnetwork-grafana-datasource/dist
PLUGIN_DEST_DIR = var/lib/grafana/plugins/solarnetwork-solarnetwork-datasource

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
		--depends 'grafana (>= 10)' \
		var

prep :
	mkdir -p var/lib/grafana/plugins
	cp -av $(PLUGIN_INSTALL_DIR) $(PLUGIN_DEST_DIR)
	rm -f $(PLUGIN_DEST_DIR)/*darwin*
	rm -f $(PLUGIN_DEST_DIR)/*windows*
	rm -f $(PLUGIN_DEST_DIR)/*arm

clean :
	rm -f $(NAME)_$(VERSION)*.deb

