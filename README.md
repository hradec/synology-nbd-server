# synology-nbd-server
A nbd-server package for synology DSM.

I've made this to build nbd-server 3.20 for the ds415play, which doesn't have NBD by default.

It uses docker to build inside an Ubuntu container, using Synologys toolkit. So, you one just need to have docker installed to be able to build this package.

This depot can be used to build other linux packages as well, with just basic knownledge of Synology toolkit.

All that is needed to build is to create the following files in a folder with the package name (you can copy mine from the `nbd` folder as a starting point):
  | file | description |
  | :--- | :---- |
  | `<pkg>/INFO.sh` | with basic information about the package, used by the toolkit to create the info in the spk |
  | `<pkg>/SynoBuildConf/build` | the script called by the toolkit to build the package - make sure to setup CC and CXX env vars to the gcc and g++ compilers in the /usr/local/ path of the toolkit, or else it will build with the wrong gcc/g++! In the build script for nbd, I tried to be clever and find it in the /usr/local folder. It should work for all cases, but I only tested on evansport.
  | `<pkg>/SynoBuildConf/install` | the script called by the toolkit to prepare the built files to be packaged into the spk.|
  | `<pkg>/scripts/postinst` | the script called after installing the files in the spk inside the NAS machine, so we can copy stuff around, create config files, etc|
  | `<pkg>/scripts/postuninst` | the script called after removing the spk files from the system, so we can cleanup whatever that was done in the `postinst` script.|
  | `<pkg>/scripts/start-stop-status` | the main script responsible for starting, stopping and verify if the package is running or not. |


Apart from those, the `<pkgname>_build.sh` script also needs to be created to extract/copy the original package source code and copy the files above to `synology/source/<pkgname>/`, where Synologys toolkit will look for when building. (my `nbd_build.sh` script is a good starting point as well!)

Enjoy!
