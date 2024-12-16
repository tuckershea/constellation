# Hardedning to CIS Independent 2.0. Specification
{
  config,
  pkgs,
  ...
}:
{
  # Unfulfilled requirements:
  # - 1.1.2-1.1.15

  boot.specialFileSystems."/dev/shm" = {
    fsType = "tmpfs";
    options = [
      # CIS Independent 1.1.16
      "nosuid"
      # CIS Indeoendent 1.1.17
      "noexec"
      "nodev"
    ];
  };

  # CIS Independent 1.1.22
  services.autofs.enable

  boot.kernelPackages = pkgs.linuxPackages_hardened;

  nix.settings.allowed-users = [ "@users" ];

  environment.memoryAllocator.provider = "scudo";
  environment.variables.SCUDO_OPTIONS = "ZeroContents=1";

  security.lockKernelModules = true;

  security.protectKernelImage = true;

  security.allowSimultaneousMultithreading = false;

  security.forcePageTableIsolation = true;

  # This is required by podman to run containers in rootless mode.
  security.unprivilegedUsernsClone = config.virtualisation.containers.enable;

  security.virtualisation.flushL1DataCache = "always";

  security.apparmor.enable = true;
  security.apparmor.killUnconfinedConfinables = true;

  boot.kernelParams = [
    # Don't merge slabs
    "slab_nomerge"

    # Overwrite free'd pages
    "page_poison=1"

    # Enable page allocator randomization
    "page_alloc.shuffle=1"

    # Disable debugfs
    "debugfs=off"
  ];

  boot.blacklistedKernelModules = [
    # Obscure network protocols
    "ax25"
    "netrom"
    "rose"

    # Old or rare or insufficiently audited filesystems
    "adfs"
    "affs"
    "bfs"
    "befs"
    # CIS Independent 1.1.1.1
    "cramfs"
    "efs"
    "erofs"
    "exofs"
    # CIS Independent 1.1.1.2
    "freevxfs"
    "f2fs"
    # CIS Independent 1.1.1.4
    "hfs"
    # CIS Independent 1.1.1.5
    "hfsplus"
    "hpfs"
    "jfs"
    # CIS Independent 1.1.1.3
    "jffs2"
    "minix"
    "nilfs2"
    "ntfs"
    "omfs"
    "qnx4"
    "qnx6"
    "sysv"
    # CIS Independent 1.1.1.6
    "squashfs"
    # CIS Independent 1.1.1.7
    "udf"
    "ufs"
    # CIS Independent 1.1.1.8
    # Hesitant to disable in case it makes
    # my system non-bootable
    # "vfat"
    # CIS Independent 1.1.23
    "usb-storage"
  ];

  # Hide kptrs even for processes with CAP_SYSLOG
  boot.kernel.sysctl."kernel.kptr_restrict" = 2;

  # Disable bpf() JIT (to eliminate spray attacks)
  boot.kernel.sysctl."net.core.bpf_jit_enable" = false;

  # Disable ftrace debugging
  boot.kernel.sysctl."kernel.ftrace_enabled" = false;

  # Enable strict reverse path filtering (that is, do not attempt to route
  # packets that "obviously" do not belong to the iface's network; dropped
  # packets are logged as martians).
  boot.kernel.sysctl."net.ipv4.conf.all.log_martians" = true;
  boot.kernel.sysctl."net.ipv4.conf.all.rp_filter" = "1";
  boot.kernel.sysctl."net.ipv4.conf.default.log_martians" = true;
  boot.kernel.sysctl."net.ipv4.conf.default.rp_filter" = "1";

  # Ignore broadcast ICMP (mitigate SMURF)
  boot.kernel.sysctl."net.ipv4.icmp_echo_ignore_broadcasts" = true;

  # Ignore incoming ICMP redirects (note: default is needed to ensure that the
  # setting is applied to interfaces added after the sysctls are set)
  boot.kernel.sysctl."net.ipv4.conf.all.accept_redirects" = false;
  boot.kernel.sysctl."net.ipv4.conf.all.secure_redirects" = false;
  boot.kernel.sysctl."net.ipv4.conf.default.accept_redirects" = false;
  boot.kernel.sysctl."net.ipv4.conf.default.secure_redirects" = false;
  boot.kernel.sysctl."net.ipv6.conf.all.accept_redirects" = false;
  boot.kernel.sysctl."net.ipv6.conf.default.accept_redirects" = false;

  # Ignore outgoing ICMP redirects (this is ipv4 only)
  boot.kernel.sysctl."net.ipv4.conf.all.send_redirects" = false;
  boot.kernel.sysctl."net.ipv4.conf.default.send_redirects" = false;

  # https://github.com/NixOS/nixpkgs/issues/11790
  boot.kernel.sysctl = {
    # CIS 3.2.9.a - Disable IPv6 Router Advertisements
    "net.ipv6.conf.all.accept_ra" = 0;
    "net.ipv6.conf.default.accept_ra" = 0;
  };

  services.openssh = {
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
    # CIS 5.2.4 - Ensure SSH Protocol is set to 2
    # CIS 5.2 SSH Server Configuration
    extraConfig = ''
      Protocol 2
      MaxAuthTries 4
      PermitEmptyPasswords no
      PermitUserEnvironment no
      MaxSessions 4
      LoginGraceTime 60
    '';
  };
}
