{ hostname, ...}:
let
  inherit (import ../../hosts/${hostname}//env.nix) gitEmail gitUsername;
in
{
  programs.git = {
    enable = true;
    userEmail = "${gitEmail}";
    userName = "${gitUsername}";
  };
}
