{ pkgs, ... }:
let
  email = "linus@sq8.dev";
in
{
  home.packages = with pkgs; [
    git-credential-oauth
  ];

  # Github integration
  programs.gh.enable = true;

  programs.git = {
    enable = true;
    settings = {
    alias = {
      pu = "push";
      pl = "pull";
      plr = "pull --rebase";

      ra = "rebase --abort";

      s = "status";

      d = "diff";
      dc = "diff --cached";

      aa = "add .";

      cm = "commit -m"; # Commit with Message
      ca = "commit --amend --no-edit"; # Commit Amend
      ce = "commit --amend"; # Commit amend with Edit

      lg = "log --graph --all --oneline";
      lf = "log --graph --all --decorate --pretty=format:'%C(auto)%h%Creset %C(auto)%d%Creset %s
%C(dim white)%ar by %C(dim blue)%an %C(dim green)(%G? [%GT])%Creset'";
    };

      gpg.program = "${pkgs.gnupg}/bin/gpg";
      init.defaultBranch = "main";
      user.signingKey = "59BC 481E 817E 00C2 3930  D7AA 8087 49C2 CFE5 F9E8";
      user.name = "Linus Michelsson";
      user.email = "${email}";

      # Personal gitlab instance oauth
      credential."https://git.sq8.dev/" = {
        credentialStore = "cache";
        helper = "${pkgs.git-credential-oauth}/bin/git-credential-oauth";

        oauthClientId = "de944e488d3489f882b817af1c96319d2b177479c9ce2f7ff8e2df4b55469785";
        oauthScopes = "read_repository write_repository";
        oauthAuthURL = "https://gitlab.shitcloud.se/oauth/authorize";
        oauthTokenURL = "https://gitlab.shitcloud.se/oauth/token";
        oauthDeviceAuthURL = "https://gitlab.shitcloud.se/oauth/authorize_device";
      };
    };
    signing = {
      format = "openpgp";
      signByDefault = true;
    };
  };
}
