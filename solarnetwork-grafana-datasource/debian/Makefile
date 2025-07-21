NAME = solarnetwork-grafana-datasource
DIST = 
VERSION = 2.0.0-1$(if $(DIST),+$(DIST),)
PLUGIN_INSTALL_DIR = solarnetwork-grafana-datasource/dist

deb : prep
	fpm -s dir \
		-t deb \
		-n $(NAME) \
		-v $(VERSION) \
		-m 'SolarNetwork Packaging <packaging@solarnetwork.org.nz>' \
		--vendor 'SolarNetwork Foundation' \
		--description 'SolarNetwork data source plugin for Grafana' \
		--license 'General Public License 3.0' \
		--url "https://github.com/SolarNetwork/solarnet-os-packages/tree/develop/solarnetwork-grafana-datasource/debian" \
		--force \
		--after-install $(NAME).postinst \
		--after-remove $(NAME).postrm \
		var
	
prep :
	mkdir -p var/lib/grafana/plugins
	cp -av $(PLUGIN_INSTALL_DIR) var/lib/grafana/plugins/solarnetwork-datasource

clean : 
	rm -f $(NAME)_$(VERSION)*.deb
