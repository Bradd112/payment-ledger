APP_DIR=payment-ledger-laravel
IMAGE=payment-ledger-php
CONTAINER=payment-ledger-app

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
		-v $(PWD)/$(APP_DIR):/var/www/html \
		$(IMAGE) composer $(cmd)

artisan:
	docker run --rm -it \
		-v $(PWD)/$(APP_DIR):/var/www/html \
		$(IMAGE) php artisan $(cmd)
