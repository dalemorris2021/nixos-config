# nixos-config

My personal NixOS configuration with home manager.

# wsl-configuration.nix

This is the configuration for my system in a WSL environment. After copying the config to a new system, run the following command in the windows terminal to register the default user with NixOS.

```powershell
wsl -d NixOS -u root --user <username> exit
```

When switching between a normal system and WSL, make sure to copy the changes made in the initial config to the new config. When switching from a normal system to WSL, be sure to retain settings related to WSL and omit settings related to the boot system, desktop environment, etc. that are handled by Windows. When doing the opposite be sure to make similar considerations.
