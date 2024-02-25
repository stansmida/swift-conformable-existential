#!/bin/zsh

swift package \
	--allow-writing-to-directory "docs" \
	generate-documentation \
	--target SwiftConformableExistential \
	--disable-indexing \
	--transform-for-static-hosting \
	--hosting-base-path swift-conformable-existential \
	--output-path "docs"
