# synology-nbd-server
A nbd-server package for synology DSM. 

I've made this to build nbd-server 3.20 for the ds415play, which doesn't have NBD by default.

It uses docker to build inside an Ubuntu container, using Synologys toolkit. So, you one just need to have docker installed to be able to build this package.

This depot can be used to build other linux packages as well, with just basic knownledge of Synology toolkit. 

All that is needed to build is to create the following files in a folder with the package name (you can copy mine from the `nbd` folder as a starting point):
  - `<pkgname>/INFO.sh` - with basic information about the package, used by the toolkit to create the info in the spk
  - `<pkgname>/SynoBuildConf/build` - the script called by the toolkit to build the package
  - `<pkgname>/SynoBuildConf/install` - the script called by the toolkit to prepare the built files to be packaged into the spk.
  - `<pkgname>/scripts/postinst` - the script called after installing the files in the spk inside the NAS machine, so we can copy stuff around, create config files, etc
  - `<pkgname>/scripts/postuninst` - the script called after removing the spk files from the system, so we can cleanup whatever that was done in the `postinst` script.
  - `<pkgname>/scripts/start-stop-status` - the main script responsible for starting, stopping and verify if the package is running or not. 
  
  
Apart from those, the <pkgname>_build.sh script also needs to be created to extract/copy the original package source code to be built and copying/creating the files above to `synology/source/<pkgname>/`, where Synologys toolkit will look for when running. (my `nbd_build.sh` script is a good starting point as well!)
  
Enjoy! 
