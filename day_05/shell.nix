with import <nixpkgs> {};
clangStdenv.mkDerivation {
  name = "clang-nix-shell";
  nativeBuildInputs = [clang-tools];
  buildInputs = [ /* add libraries here */ ];
}
