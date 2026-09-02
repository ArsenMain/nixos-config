# https://discourse.nixos.org/t/a-cool-function-to-import-nix-modules-automatically/62757
# Courtesy of waffle8946 x3
{ lib, ... }:
let
  inherit (builtins) filter map toString;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.strings) hasSuffix;
in
{
  imports = filter (hasSuffix ".nix") (
    map toString (filter (p: p != ./default.nix) (listFilesRecursive ./modules/.))
  );
}
