PACKAGEVERSION=$(shell ls kerub*war | sed -e "s/kerub-//g" | sed -e "s/.war//g")
ROOT=/tmp/${BUILD_ID}
WORK=${PWD}

all: kerub.tgz

kerub.tgz: dist-tree MANIFEST
	bash -c "cd $(ROOT) && pkg create -r '' -M $(WORK)/MANIFEST"
	mv $(ROOT)/kerub*txz $(WORK)

dist-tree:
	mkdir -p -v		$(ROOT)
	mkdir -p -v		$(ROOT)/usr/local/jetty
	mkdir -p -v		$(ROOT)/usr/local/kerub
	cp kerub*.war		$(ROOT)/usr/local/kerub/kerub.war
	mkdir -p -v		$(ROOT)/etc/kerub/local
	mkdir -p -v		$(ROOT)/etc/kerub/cluster

MANIFEST: MANIFEST.json 
	cat MANIFEST.json | sed -e "s/VERSION/$(PACKAGEVERSION)-$(BUILD_ID)/g" > MANIFEST
	sh files.sh $(ROOT) >> MANIFEST
	echo }} >> MANIFEST

clean:
	rm -rf $(ROOT) 
	rm -f MANIFEST *.txz

