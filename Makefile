BIN := ./node_modules/.bin

# The Platform Canonical User IDs and Cloudfront Canonical User IDs copied from ajs-renderer. They allow Cloudfront distributions to access objects in the S3 bucket:
# https://github.com/segmentio/ajs-renderer/blob/aef7f4a39a948bb04beb81cf673ea68a2811a016/.run/ajs-renderer.yml#L55-L57
# CF_CUIDs taken from CloudFront Origin Access Identities for cdn.segment.build and custom domain
upload-assets:
	S3_BUCKET_NAME=metarouter-ajs-next-destinations-stage \
	LOCAL_PATH=build \
	CONTENT_ENCODING=gzip \
	PLAT_CUID="26ddcb2aa369112c5b16d5a23c1524ada51dafbd45801c4c4514eb801bf38200" \
	CF_CUIDS="26ddcb2aa369112c5b16d5a23c1524ada51dafbd45801c4c4514eb801bf38200" \
	node scripts/upload-assets.js
.PHONY: upload-assets

# The Platform Canonical User IDs and Cloudfront Canonical User IDs copied from ajs-renderer. They allow Cloudfront distributions to access objects in the S3 bucket:
# https://github.com/segmentio/ajs-renderer/blob/aef7f4a39a948bb04beb81cf673ea68a2811a016/.run/ajs-renderer.yml#L73-L76
# CF_CUIDs taken from CloudFront Origin Access Identities for cdn.segment.com and cdn.segment.io and custom domain
publish-assets:
	S3_BUCKET_NAME=segment-ajs-next-destinations-production \
	LOCAL_PATH=build \
	CONTENT_ENCODING=gzip \
	PLAT_CUID="26ddcb2aa369112c5b16d5a23c1524ada51dafbd45801c4c4514eb801bf38200" \
	CF_CUIDS="26ddcb2aa369112c5b16d5a23c1524ada51dafbd45801c4c4514eb801bf38200" \
	node scripts/upload-assets.js
.PHONY: upload-assets

build:
	yarn build
	node ./scripts/build-shells.js
.PHONY: build

build-and-upload: build
	make upload-assets
.PHONY: build-and-upload

build-and-publish: build
	make publish-assets
.PHONY: build-and-publish

local-server:
	yarn build
	node ./scripts/build-shells.js
	npx serve
.PHONY: local-server
