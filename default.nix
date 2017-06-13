with (import <nixpkgs> {});

python27Packages.buildPythonPackage rec {
  name = "minieigen";

  src = pkgs.fetchurl {
    url = "https://github.com/eudoxos/minieigen/archive/master.zip";
    sha256 = "71d91f716aeb85e6433696fc0754c32d8f4956f3685d12df925c2c9183a2a108";
  };

  buildInputs = [ unzip python27Packages.boost boost.dev eigen3_3 ];

  patchPhase = ''
   sed -i "s/^.*libraries=libraries.//g" setup.py 
  '';

  preConfigure = ''
    export LDFLAGS="-L${eigen3_3.out}/lib -l boost_python"
    export CFLAGS="-I${eigen3_3.out}/include/eigen3"
  '';

}
