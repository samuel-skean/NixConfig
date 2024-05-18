{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
  outputs = { self, nixpkgs }: {
    defaultPackage.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.buildEnv {
      name = "skean-stuff";
      paths = with nixpkgs.legacyPackages.aarch64-darwin; [
        python3
        gcc
      ];
      pathsToLink = [ "/share/man" "/share/doc" "/bin" "/lib" ];
      extraOutputsToInstall = [ "man" "doc" ];
    };
  };
}
