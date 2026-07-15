{ config, pkgs, lib, ...}:

{
  home.username = "ethereal";
  home.homeDirectory = "/home/ethereal";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.shell.enableZshIntegration = true;

  home.activation = {
    disableZshNewuserInstall = lib.hm.dag.entryAfter ["writeBoundary"] ''
      touch /home/ethereal/.zshrc
    '';
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.fira-code
  ];

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      local wezterm = require('wezterm')

      local config = {}

      config.color_scheme = 'Tokyo Night'
      config.font = wezterm.font('FiraCode Nerd Font')
      config.window_background_opacity = 0.7

      config.keys = {
        {
          key = "'",
          mods = 'CTRL',
          action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
        },
        {
          key = '"',
          mods = 'CTRL|SHIFT',
          action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }
        },
        {
          key = 'LeftArrow',
          mods = 'CTRL',
          action = wezterm.action.ActivatePaneDirection 'Left'
        },
        {
          key = 'RightArrow',
          mods = 'CTRL',
          action = wezterm.action.ActivatePaneDirection 'Right'
        },
        {
          key = 'UpArrow',
          mods = 'CTRL',
          action = wezterm.action.ActivatePaneDirection 'Up'
        },
        {
          key = 'DownArrow',
          mods = 'CTRL',
          action = wezterm.action.ActivatePaneDirection 'Down'
        },
        {
          key = 'w',
          mods = 'CTRL',
          action = wezterm.action.CloseCurrentPane { confirm = true }
        },
      }

      return config
    '';
  };

  programs.zsh = {
    enable = true;
    dotDir = "/home/ethereal/.config/zsh";
    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
      ];
    };
    enableCompletion = true;
    autosuggestion.enable = true;
    oh-my-zsh = {
      enable = true;
      package = pkgs.oh-my-zsh;
      theme = "robbyrussell";
    };
    history.size = 10000;
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

  programs.firefox.enable = true;

  programs.obsidian = {
    enable = true;
  };
}

