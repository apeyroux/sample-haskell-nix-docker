with import <nixpkgs> {};

let
  helloHaskell = import ./default.nix;
in {
  helloHaskellAppImage = dockerTools.buildImage {
    name = "hello-haskell";
    contents = [
      helloHaskell
    ];
    config = {
      Version = "1.0";
      EntryPoint = ["sample-haskell-nix-docker"];
    };
  };
}
