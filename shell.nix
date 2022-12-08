{ pkgs ? import <nixpkgs> { } }:

with pkgs;

mkShell rec {
  name = "stable-diffusion-pip-shell";
  venvDir = "venv";

  buildInputs = [
    python310Packages.python
    python310Packages.venvShellHook
  ];

  LD_LIBRARY_PATH = lib.makeLibraryPath [
    stdenv.cc.cc.lib
    cudaPackages.cudatoolkit
    cudaPackages.cudnn
    libGL
    glib
  ] + ":/run/opengl-driver/lib";

  postVenvCreation = ''
    unset SOURCE_DATE_EPOCH
    pip install -r requirements_versions.txt --no-cache-dir
    pip install -e .
  '';

  postShellHook = ''
    # allow pip to install wheels
    unset SOURCE_DATE_EPOCH

    echo 'Run: python launch.py --listen'
  '';
}
