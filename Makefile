APP_DIR=payment-ledger-laravel
IMAGE=payment-ledger-php
CONTAINER=payment-ledger-app
UID := $(shell id -u)
GID := $(shell id -g)

build:
	docker build -t $(IMAGE) .

serve:
	docker run --rm -it \
		-p 80:8000 \
		-v $(PWD)/$(APP_DIR):/var/www/html \
		--name $(CONTAINER) \
		$(IMAGE)

composer:
	docker run --rm -it \
		--user $(UID):$(GID) \
		-e COMPOSER_HOME=/tmp/composer \
		-v $(PWD)/$(APP_DIR):/var/www/html \
		$(IMAGE) composer $(if $(cmd),$(cmd),$(filter-out $@,$(MAKECMDGOALS)))

artisan:
	docker run --rm -it \
		--user $(UID):$(GID) \
		-v $(PWD)/$(APP_DIR):/var/www/html \
		$(IMAGE) php artisan $(if $(cmd),$(cmd),$(filter-out $@,$(MAKECMDGOALS)))

# Allow: make composer require vendor/package:^1.0
%:
	@:
