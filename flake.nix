# This is where I got the basics from: https://jvns.ca/blog/2023/11/11/notes-on-nix-flakes/.
# Scroll down till the word "buildEnv" to find the example this was based on.
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
  outputs = { self, nixpkgs }: {
    defaultPackage.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.buildEnv {
      name = "skean-stuff";
      paths = with nixpkgs.legacyPackages.aarch64-darwin; [
        python312
        bash
        bat
        jq
        jaq
        cmake
        inkscape
        yt-dlp
        python312Packages.flake8
      ];
      pathsToLink = [ "/share/man" "/share/doc" "/bin" "/lib" ];
      extraOutputsToInstall = [ "man" "doc" ];
    };
  };
}
