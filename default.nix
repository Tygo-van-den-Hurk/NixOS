(import
  (
    let
      lock = builtins.fromJSON (builtins.readFile ./flake.lock);
      node = lock.nodes.flake-compat.locked;

      sha256 = node.narHash;
      inherit (node) owner;
      inherit (node) repo;
      inherit (node) rev;
      inherit (node) type;

      url =
        if type == "github" then
          "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz"
        else
          throw "Unknown URL type: ${type}";
    in
    fetchTarball {
      inherit url;
      inherit sha256;
    }
  )
  {
    src = ./.;
  }
).defaultNix
