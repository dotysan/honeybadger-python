SHELL:= /usr/bin/env bash
.EXPORT_ALL_VARIABLES:
PIP_REQUIRE_VIRTUALENV ?= true

# this is just the preferred vwersion for development
PY:= python3.9

.PHONY: develop tests django flask clean

develop: .venv/bin/wheel
	source .venv/bin/activate && \
	pip install --editable .
#	pip install --requirement requirements.txt && \

#tests: .venv/bin/tox
tests: .venv/bin/wheel
	source .venv/bin/activate && \
	python setup.py test
#	tox --colored=yes run-parallel --parallel=auto --parallel-no-spinner --skip-missing-interpreters=false --parallel-live
#	strace -s 800 -ff -o tox.log tox --colored=yes run-parallel --parallel=auto --parallel-no-spinner --skip-missing-interpreters=false --exit-and-dump-after 2
#	tox run -- -v

.venv/bin/tox: .venv/bin/wheel
	source .venv/bin/activate && \
	pip install tox && \
	touch .venv/bin/tox

django: develop
ifndef HONEYBADGER_API_KEY
	$(error HONEYBADGER_API_KEY is undefined)
endif
	source .venv/bin/activate && \
	cd examples/django_app && \
	pip install --requirement requirements.txt && \
	python manage.py migrate && \
	echo "Go to http://127.0.0.1/api/div to generate an alert." && \
	python manage.py runserver

flask: develop
ifndef HONEYBADGER_API_KEY
	$(error HONEYBADGER_API_KEY is undefined)
endif
	source .venv/bin/activate && \
	cd examples/flask && \
	pip install --requirement requirements.txt && \
	echo "Go to http://localhost:5000/?a=1&b=0 to generate an alert." && \
	FLASK_APP=app.py flask run --port 5000

.venv/bin/wheel: .venv/
	source .venv/bin/activate && \
	pip install --upgrade pip setuptools wheel && \
	touch .venv/bin/wheel

.venv/:
	$(PY) -m venv .venv

clean:
	rm --force --recursive honeybadger.egg-info/ build/ dist/
	rm --force --recursive .venv/ .eggs/ .tox/ .pytest_cache/
	find -type d -name __pycache__ -print0 |xargs -r0 rm --force --recursive
	rm --force examples/django_app/db.sqlite3
