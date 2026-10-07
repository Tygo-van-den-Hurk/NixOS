{
  lib,
  pkgs,
  ...
}:

let
  replace-words = import ./default.nix;

  tests = {

    "replace nothing" = {
      expr = replace-words { } "value";
      expected = "value";
    };

    "replace all 'a's with 'b's" = {
      expected = "bbc123";
      expr = replace-words { "a" = "b"; } "abc123";
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
