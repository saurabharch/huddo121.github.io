# Taken from http://stesie.github.io/2016/08/nixos-github-pages-env
with import (fetchTarball https://nixos.org/channels/nixos-18.03/nixexprs.tar.xz) { };
let jekyll_env = bundlerEnv rec {
    name = "jekyll_env";
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };
in
  stdenv.mkDerivation rec {
    name = "jekyll_env";
    buildInputs = [ jekyll_env ];

    shellHook = ''
      exec ${jekyll_env}/bin/jekyll serve --watch --drafts --future
    '';
  }
