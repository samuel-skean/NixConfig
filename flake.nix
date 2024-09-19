# This is where I got the basics from: https://jvns.ca/blog/2023/11/11/notes-on-nix-flakes/.
# Scroll down till the word "buildEnv" to find the example this was based on.
{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
  outputs = { self, nixpkgs }:
    # This particular way of doing things comes from figsoda's answer
    # [here](https://discourse.nixos.org/t/allow-unfree-in-flakes/29904). I feel
    # like I understand it pretty well except Julia Evans's original example
    # included specifically mentioned `legacyPackages` and I'm not sure how to
    # keep that, or, for that matter, what it really means.
    let pkgs = import nixpkgs {
        system = "aarch64-darwin";
        config.allowUnfree = true;
    };
    in {
    defaultPackage.aarch64-darwin = pkgs.buildEnv {
      name = "skean-stuff";
      paths = with pkgs; [
        python312
        python312Packages.pip # invoked with `pip3.12` on my mac
        bash
        bat
        jq
        jaq
        cmake
        inkscape
        yt-dlp
        python312Packages.flake8
        neovim
        vscode
        rustup
        _7zz
        ffmpeg
        gawk

        # PDF tools:
        poppler_utils
        pdftk
        texliveMedium
        exiftool
        imagemagick

        mdbook
        ruby # For CocoaPods, for Flutter
        git-lfs
        tree
        coursier # Installs Scala and Scala-related tools.
      ];
      pathsToLink = [ "/share/man" "/share/doc" "/bin" "/lib" ];
      extraOutputsToInstall = [ "man" "doc" ];
    };
  };
}
