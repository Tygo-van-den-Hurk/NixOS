# See https://github.com/cachix/git-hooks.nix/blob/fa466640195d38ec97cf0493d6d6882bc4d14969/modules/hooks.nix
{
  src = ./..;
  hooks = {

    # Run health checks on your flake-powered Nix projects.
    flake-checker = {
      enable = true;
      stages = [
        "pre-push"
        "manual"
      ];
    };

    # Check if the flake passes all it's checks. (takes a long time)
    nix-flake-check = {
      enable = true;
      name = "Nix Flake Check";
      entry = "nix flake check";
      pass_filenames = false;
      stages = [
        "pre-push"
        "manual"
      ];
    };

    # Ensure that all (non-binary) files with a shebang are executable.
    check-shebang-scripts-are-executable = {
      enable = true;
      stages = [
        "pre-commit"
        "pre-push"
        "manual"
      ];
    };

    # Detect the presence of private keys.
    detect-private-keys = {
      enable = true;
      stages = [
        "pre-commit"
        "pre-push"
        "manual"
      ];
    };

    # Checks for broken symlinks in the repository.
    check-symlinks = {
      enable = true;
      stages = [
        "pre-commit"
        "pre-push"
        "manual"
      ];
    };

    # Linting for your git commit messages"
    gitlint = {
      enable = true;
      stages = [
        "commit-msg"
      ];
    };

    # disallows commits to certain branches.
    no-commit-to-branch = {
      enable = true;
      settings.branch = [ "main" ];
      stages = [
        "pre-commit"
        "pre-push"
        "manual"
      ];
    };

    # Prevents committing binaries.
    check-added-large-files = {
      enable = true;
      stages = [
        "pre-commit"
        "pre-push"
        "manual"
      ];
    };

    # Forces executable files to have a shebang.
    check-executables-have-shebangs = {
      enable = true;
      stages = [
        "pre-commit"
        "pre-push"
        "manual"
      ];
    };

    # Checks for spelling errors in both the files and commit messages.
    typos = {
      enable = true;
      stages = [
        "pre-commit"
        "commit-msg"
        "pre-push"
        "manual"
      ];
      settings = {
        no-unicode = true;
        hidden = true;
        ignored-words = [
          "Tygo"
          "tygo"
          "Hurk"
          "hurk"
        ];
      };
    };

    # Checks markdown files for broken links, and bad syntax.
    mdformat = {
      enable = true;
      stages = [
        "pre-commit"
        "commit-msg"
        "pre-push"
        "manual"
      ];
    };

    #! Requires an internet connection while in sandbox, thus does not work.
    # # Checks for broken links in Markdown files.
    # lychee = {
    #   enable = true;
    #   stages = [
    #     "pre-commit"
    #     "pre-push"
    #     "manual"
    #   ];
    # };

    #! Does not work properly, especially because formatters fight.
    # # Verify that the files are in harmony with the `.editorconfig`.
    # editorconfig-checker = {
    #   enable = true;
    #   stages = [
    #     "pre-commit"
    #     "pre-push"
    #     "manual"
    #   ];
    # };
  };
}
