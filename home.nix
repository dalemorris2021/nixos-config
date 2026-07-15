{ config, pkgs, ...}:

{
  home.username = "ethereal";
  home.homeDirectory = "/home/ethereal";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      local wezterm = require('wezterm')

      local config = {}

      config.color_scheme = 'Tokyo Night'
      config.font = wezterm.font('Fira Code')
      config.window_background_opacity = 0.7

      return config
    '';
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = tokyonight-nvim;
        type = "lua";
        config = ''
          vim.cmd.colorscheme('tokyonight')
        '';
      }
    ];
    initLua = ''
      -- Set leader key
      vim.g.mapleader = ' '
      vim.g.maplocalleader = ' '

      -- Line numbers
      vim.opt.number = true
      vim.opt.relativenumber = true

      -- Tab width and replace with spaces
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true
    '';
    sideloadInitLua = true;
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

  programs.fastfetch = {
    enable = true;
  };

  programs.obsidian = {
    enable = true;
  };
}

