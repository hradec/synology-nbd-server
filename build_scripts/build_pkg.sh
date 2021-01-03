#!/bin/bash

CD=$(dirname $(readlink -f $BASH_SOURCE))/../
cd $CD

pkg=$1
version=$2
platform=$3
if [ "$pkg" == "" ] ; then
	echo "
$0 <pkg name> [version (default to 6.2)] [platform (default to evansport)]

	ERROR: 	we need the name of the package to build, 
		which should match the source folder name 
		in synology/source/<pkg name>/


	"
else
	if [ "$version" == "" ] ; then
		version=6.2
	fi
	if [ "$platform" == "" ] ; then
		platform=evansport
	fi

	mkdir -p ./synology/source/

	./build_scripts/run.sh /bin/bash -c "
		cd /root/synology &&
	        git clone https://github.com/SynologyOpenSource/pkgscripts-ng.git  ./pkgscripts-ng || (cd ./pkgscripts-ng && git pull && cd .. ) &&  \
		( [ ! -e build_env/ds.$platform-$version ] && ./pkgscripts-ng/EnvDeploy -v $version -p $platform || true ) &&
		rm -rf build_env/*/source/* && \
		pkgscripts-ng/PkgCreate.py -v $version -p $platform $pkg &&
		cp build_env/ds.evansport-6.2/image/packages/*.spk  ./
	" && \
	mkdir -p packages/ds.$platform-$version/
	cp synology/*.spk ./packages/ds.$platform-$version/

fi
