{
  programs.git = {
    enable = true;
    settings.user = {
      name = "najika12";
      email = "iqromaulanahadi@gmail.com";
    };
    settings = {
      init.defaultBranch = "main";
      url."ssh://git@github.com/".insteadOf = "https://github.com/";
    };
  };
}
