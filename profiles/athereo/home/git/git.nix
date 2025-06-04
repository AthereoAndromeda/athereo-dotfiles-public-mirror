{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "Athereo";
    userEmail = "athereoandromeda@gmail.com";

    lfs.enable = true;

    aliases = {
      st = "status";
      sw = "switch";
      logl = "log --oneline --graph --color --all --decorate";
      br = "branch";
      ch = "checkout";
    };

    extraConfig = {
      init.defaultBranch = "main";

      credential = {
        helper = "${
          pkgs.git.override {withLibsecret = true;}
        }/bin/git-credential-libsecret";
      };
    };
  };
}
