{
  lib,
  pkgs,
  ...
}:
let
  sort = builtins.sort builtins.lessThan;
  raw = import ./default.nix lib;
  find-files = args: sort (raw args);

  tests = {

    "find files with 'alpha' extension" = {

      expr = find-files {
        extension = "alpha";
        base = ./data;
      };

      expected = sort [
        (./data + "/file-1.alpha")
        (./data + "/file-2.alpha")
        (./data + "/dir/file-3.alpha")
      ];
    };

    "find files with 'alpha' or 'beta' extension" = {

      expr = find-files {
        extensions = [
          "alpha"
          "beta"
        ];
        base = ./data;
      };

      expected = sort [
        (./data + "/file-1.alpha")
        (./data + "/file-1.beta")
        (./data + "/file-2.alpha")
        (./data + "/dir/file-3.alpha")
        (./data + "/dir/file-2.beta")
      ];
    };

    "find files with 'alpha' extension excluding a file" = {

      expr = find-files {
        extension = "alpha";
        base = ./data;
        exclude = ./data/file-1.alpha;
      };

      expected = sort [
        (./data + "/file-2.alpha")
        (./data + "/dir/file-3.alpha")
      ];
    };

    "find files with 'alpha' extension excluding two files" = {

      expr = find-files {
        extension = "alpha";
        base = ./data;
        exclude = [
          ./data/file-1.alpha
          ./data/file-2.alpha
        ];
      };

      expected = sort [
        (./data + "/dir/file-3.alpha")
      ];
    };

    "find and read files with 'alpha' extension" = {

      expr = find-files {
        extension = "alpha";
        base = ./data;
        transform = builtins.readFile;
      };

      expected = sort [
        "file-1.alpha\n"
        "file-2.alpha\n"
        "file-3.alpha\n"
      ];
    };

    "find files with 'alpha' extension, but include a 'gamma' file" = {

      expr = find-files {
        extension = "alpha";
        base = ./data;
        extra = [
          ./data/file-1.gamma
        ];
      };

      expected = sort [
        (./data + "/file-1.alpha")
        (./data + "/file-2.alpha")
        (./data + "/dir/file-3.alpha")
        (./data + "/file-1.gamma")
      ];
    };

    "find files with 'delta' extension" = {
      expected = [ ];
      expr = find-files {
        extension = "delta";
        base = ./data;
      };
    };
  };

  failures = lib.runTests (
    tests
    // {
      tests = builtins.attrNames tests;
    }
  );
in

assert lib.assertMsg (failures == [ ]) "find-files tests failed: ${builtins.toJSON failures}";

pkgs.runCommand "find-files-tests" { } ''
  echo 'tests = ${builtins.toJSON tests}' >> $out
  echo ' ' >> $out
  echo 'failures = ${builtins.toJSON failures}' >> $out
''
