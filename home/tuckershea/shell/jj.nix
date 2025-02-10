{
  pkgs,
  ...
}:
{
  home.file.".jjconfig.toml".text = ''
    [user]
    name = "Tucker Shea"
    email = "tucker@tuckershea.com"

    [signing]
    backend = "ssh"
    backends.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
    key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMh3wNTGjXPzrHWZI1ZZfoRg3w6osDeB1VUYSaRd5Dk9 norepercussions@github"

    [git]
    sign-on-push = true
    push-bookmark-prefix = "norepercussions/push-"
    private-commits = "description(glob:'wip:*') | description(glob:'private:*')"
    subprocess = true
    executable-path = "${pkgs.git}/bin/git"
  '';
}

