{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      rebuildBoot = "sudo nixos-rebuild boot --flake .#rabbit";
      rebuildSwitch = "sudo nixos-rebuild switch --flake .#rabbit";
      rebuildTest = "sudo nixos-rebuild test --flake .#rabbit";
    };

    history.size = 10000;
    history.ignoreAllDups = true;
    history.path = "$HOME/.zsh_history";
    history.ignorePatterns = ["rm *" "pkill *" "cp *"];
  };
}
