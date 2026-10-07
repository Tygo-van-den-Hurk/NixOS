set:
let
  attr_names = builtins.attrNames set;
in

string:
let
  folder = acc: key: builtins.replaceStrings [ "${key}" ] [ set.${key} ] acc;
in

builtins.foldl' folder string attr_names
