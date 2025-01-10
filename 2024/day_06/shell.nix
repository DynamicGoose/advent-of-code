with import <nixpkgs> {};

mkShell {
  buildInputs = [scala metals scala-cli zulu11];
}
