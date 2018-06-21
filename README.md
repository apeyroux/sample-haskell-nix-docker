# Haskell, Nix and Docker !

```bash
├── ChangeLog.md
├── default.nix
├── docker.nix
├── LICENSE
├── Main.hs
├── sample-haskell-nix-docker.cabal
└── Setup.hs
```

## default.nix

```nix
(import <nixpkgs> {}).haskellPackages.developPackage { root = ./.; }
```

## docker.nix

```nix
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
```

## Use Docker and Nix

```bash
nix-build docker.nix -o hello-haskell.docker
cat hello-haskell.docker | docker load
docker run -it --rm hello-haskell:latest
Hello, Haskell!
```
