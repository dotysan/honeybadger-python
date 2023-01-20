SHELL:= /usr/bin/env bash
.EXPORT_ALL_VARIABLES:
PIP_REQUIRE_VIRTUALENV ?= true

.PHONY: test develop django clean

test: develop
	source .venv/bin/activate && \
	python setup.py test

develop: .venv/bin/wheel
	source .venv/bin/activate && \
	python setup.py develop

django: develop
ifndef HONEYBADGER_API_KEY
	$(error HONEYBADGER_API_KEY is undefined)
endif
	source .venv/bin/activate && \
	cd examples/django_app && \
	pip install --requirement requirements.txt && \
	python manage.py migrate && \
	python manage.py runserver

.venv/bin/wheel: .venv/
	source .venv/bin/activate && \
	pip install --upgrade pip setuptools wheel

.venv/:
	python3 -m venv .venv

clean:
	rm -fr .venv/
	rm -f examples/django_app/db.sqlite3
