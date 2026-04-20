{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      url."ssh://git@github.com/".insteadOf = "https://github.com/";
      user = {
        name = "najika12";
        email = "iqromaulanahadi@gmail.com";
      };
    };
  };
}
