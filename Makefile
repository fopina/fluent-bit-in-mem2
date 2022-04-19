dev:
	docker build -f Dockerfile.build -o dist .

test: dev
	docker run --rm alpine:3.12 cat /proc/meminfo
	docker run --rm \
			-v $(pwd)/dist:/myplugin \
			fluent/fluent-bit:1.9.2 \
			/fluent-bit/bin/fluent-bit -v \
			-f 1 \
			-e /myplugin/flb-in_mem2.so \
			-i mem2 \
			-o stdout -m '*' \
			-o exit -m '*'