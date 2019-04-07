# From the desk of Michael Hudson

This site is available at [http://MichaelHudson.net.au](http://MichaelHudson.net.au) and [http://IAmMichaelHudson.com](http://IAmMichaelHudson.com)

This repository holds my personal Jekyll blog, for hosting on GitHub pages.

This blog makes use of the Centrarium theme by Ben Centra, and includes a number of my own modifications to the
theme, including;
  * Adding Reddit as a social share option
  * Adding previous/next post links
  * Adding comment counts to the blog index
  * Adding a lightbox include
  * Adding a quote include
  * Updated Disqus functionality to work across multiple domains
  * Disabling of google analytics when not in production

For more information visit the [About This Site](http://huddo121.github.io/about-this-site/) page.

## Working With This Repo

If you're using [Nix](https://nixos.org/nix/), then running `nix-shell` in the project directory should be enough to get the project up and running.
To update the dependencies the following steps should be followed.

```
> nix-shell -p bundler
nix-shell> bundle update
nix-shell> exit
> $(nix-build '<nixpkgs>' -A bundix)/bin/bundix
> nix-shell
```
