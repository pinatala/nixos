let
  user = "luna";

  stripHash = str:
    if builtins.substring 0 1 str == "#"
    then builtins.substring 1 (builtins.stringLength str - 1) str
    else str;

  userNoHash = builtins.mapAttrs (_: v: stripHash v) user;
in {
  flake = {
    inherit user userNoHash;
  };
}
