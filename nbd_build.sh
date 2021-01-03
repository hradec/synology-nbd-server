#!/bin/bash

pkg=nbd-3.20
version=6.2
platform=evansport

rm ./$pkg-*.spk

install_source() {
	CD="$(pwd)"
	rm -rf ./synology/source/$pkg
	mkdir -p ./synology/source/$pkg/
	cd ./synology/source/$pkg/
	tar xf $CD/nbd/$pkg.tar.xz
	mv */* ./
	cp -rfv $CD/nbd/* $CD/synology/source/$pkg/
	cd $CD
}

install_source && \
	./build_scripts/build_pkg.sh $pkg $version $platform || \
echo "Error!"
