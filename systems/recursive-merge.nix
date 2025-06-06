## Merges lists, or sets recursively. Overrides a value in a set if it's newer.
#! I did not write this function and cannot garantee it's correctness.
{lib, ...}:
with lib; let
  recursiveMerge = attrList: let
    f = attrPath:
      zipAttrsWith (
        n: values:
          if tail values == []
          then head values
          else if all isList values
          then unique (concatLists values)
          else if all isAttrs values
          then f (attrPath ++ [n]) values
          else last values
      );
  in
    f [] attrList;
in
  recursiveMerge
#
#| Example 1:
#
#   recursiveMerge [
#     { a = "x"; c = "m"; list = [1]; }
#     { a = "y"; b = "z"; list = [2]; }
#   ]
#
#` returns
#
#    { a = "y"; b = "z"; c="m"; list = [1 2]; }
#
#
#| Example 2:
#
#   recursiveMerge [
#     {
#       a.a = [1];
#       a.b = 1;
#       a.c = [1 1];
#       boot.loader.grub.enable = true;
#       boot.loader.grub.device = "/dev/hda";
#     }
#     {
#       a.a = [2];
#       a.b = 2;
#       a.c = [1 2];
#       boot.loader.grub.device = "";
#     }
#   ]
#
#` returns
#
#    {
#     a = {
#       a = [ 1 2 ];
#       b = 2;
#       c = [ 1 2 ];
#     };
#     boot = {
#       loader = {
#         grub = {
#           device = "";
#           enable = true;
#         };
#       };
#     };
#   }
#

