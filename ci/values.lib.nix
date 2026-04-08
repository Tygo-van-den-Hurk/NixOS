{
  steps.checkout-repository = {
    name = "Checkout repository";
    uses = "actions/checkout@v4.3.0";
  };

  steps.install-nix = {
    name = "Install Nix using cachix";
    uses = "cachix/install-nix-action@v31.7.0";
  };

  steps.add-nix-cache = {
    name = "Add nix cache";
    uses = "nix-community/cache-nix-action@v7.0.2";
    with_ = {
      primary-key = "nix-\${{ matrix.os }}-\${{ hashFiles('**/*.nix', 'flake.lock') }}";
      restore-prefixes-first-match = "nix-\${{ matrix.os }}-";
      gc-max-store-size-linux = 1073741824;
      purge = true;
    };
  };

  steps.nix-build =
    { name, attr }:
    {
      inherit name;
      run = ''
        nix build '.#${attr}' --print-build-logs \
          --override-input tygo-van-den-hurk-secrets "path:$(pwd)/secrets"
      '';
    };
}
