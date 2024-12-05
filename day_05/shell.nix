with import <nixpkgs> {};

mkShell {
  nativeBuildInputs = [libgcc pkg-config];
  buildInputs = [glibc libgcc];
}
