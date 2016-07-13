version = 2.7
python = bin/python

all: build robot

build: $(python)
	@mkdir -p var/www/extra
	@mkdir -p var/log
	@touch var/log/sites.log
	@bin/pip install -r requirements.txt

$(python):
	virtualenv -p python$(version) --no-site-packages .

robot:
	@scripts/start.sh

develop:
	@scripts/restart.sh

clean:
	@rm -rf bin parts develop-eggs \
		lib include var

.PHONY: all build robot clean
