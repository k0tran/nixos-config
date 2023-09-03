# My configuration for NixOS & Hyprland

- NixOs confing in `configuration.nix`
- Hyprland config in hypr directory (copy it to ~/.config)
- Waybar config in waybar directory (copy it to ~/.config)
- Kitty colorcheme can be configured via pywal:
  + `wal -i path/to/image`
  + `cp ~/.cache/wal/kitty-colors.conf ~/.config/kitty/.`
  + `echo 'include ~/.config/kitty/colors-kitty.conf' > ~/.config/kitty/kitty.conf`
  + same can be done for waybar (copy `colors-waybar.css`)
- Helix: `echo "theme = 'dark_plus'" > ~/.config/helix/config.toml`
- Firefox configure
- telegram and discrod configure
- git creds (and ssh key)
  + `git config --global user.email ""`
  + `git config --global user.name "Your Name"`
  + Ssh keygen: `ssh-keygen -t ed25519 -C "your_email@example.com"`
  + Then add `key123.pub` to your account (github site)
- Also shadowsocks-rust is included in this build
  + If you want to use it together with outline then there is `ss.py`:
  + `python ss.py /path/to/keyfile`
  + key file is just `ssconf` link

## Cleanup

1. Delete everything in home directory (configs, cache and invisible files)
2. Setup configs using this repo
3. Run following commands:
```shell
sudo nix-collect-garbage -d

# rebuild and check for one configuration
cat /boot/grub/grub.cfg
# this also should give only one configuration:
sudo nix-env -p /nix/var/nix/profiles/system --list-generations
```
