all:

pelias-api:
	mkdir pelias-api
	curl -sL https://github.com/pelias/api/archive/2d136f75e.tar.gz | tar -C pelias-api --strip-components=1 -xzvf -

pelias-api/node_modules: pelias-api
	cd pelias-api && npm install
	patch -p1 < patches/cluster2-pids-logs.patch

install:
	find pelias-api -type f -exec install -v -D -m0755 '{}' '$(DESTDIR)/usr/lib/nodejs/{}' \;
	mkdir -p '$(DESTDIR)/var/run/pelias-api' '$(DESTDIR)/var/log/pelias-api'
