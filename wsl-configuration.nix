# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# http://github.com/nix-community/NixOS-WSL

{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz;
in
{
  imports =
    [
      #include NixOS-WSL modules
      <nixos-wsl/modules>
      (import "${home-manager}/nixos")
    ];

  wsl.enable = true;
  wsl.defaultUser = "ethereal";

  networking.hostName = "owl"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "America/Indiana/Indianapolis";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."ethereal" = {
    isNormalUser = true;
    description = "Ethereal";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      # Simple packages for this user
    ];

    # Packages with config for this user
    shell = pkgs.zsh;
    useDefaultShell = false;
  };
  
  home-manager.users."ethereal" = {pkgs, ...}: {
    home.packages = with pkgs; [
      # Simple packages for this user (home manager)
      kdePackages.kate
      fira-code
    ];

    # Packages with config for this user (home manager)
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };

    programs.git = {
      enable = true;
      settings = {
        user = {
	  name = "Dale Morris";
          email = "dalemorris2021@gmail.com";
	};
        init.defaultBranch = "main";
      };
    };

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "26.05"; # Please read the comment before changing.
  };

  # System wide packages with config
  programs.firefox.enable = true;
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
