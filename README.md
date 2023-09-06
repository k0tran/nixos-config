# NixOS & Hyprland

My configuration of NixOS & Hyprland  
`hardware-configuration.nix` is ommited

## NixOS

Main configuration is in `configuration.nix`

When installing please review line by line all config entries

Also you might like to configure:
- Firefox (with a gui)
- Helix `echo "theme = 'dark_plus'" > ~/.config/helix/config.toml`
- Telegram
- Discord
- rustup (toolchain) and rust-analyzer (`rustup component add rust-analyzer-x86_64-unknown-linux-gnu`)

## Git & github

Configure git
```shell
git config --global user.email ""
git config --global user.name "Your Name"
```

And github:
```shell
ssh-keygen -t ed25519 -C "your_email@example.com"
cat ~/.ssh/your_ssh_key_name.pub # output add to your github account
```

## Hyprland & themes

Hyprland:
```shell
cp hyprland.conf ~/.config/hypr/.
```

[Pywal](https://github.com/dylanaraps/pywal) is used for generating colors from images (used by waybar and kitty).

To generate color schemes run:
```shell
wal -i path/to/image

# Kitty
cp ~/.cache/wal/kitty-colors.conf ~/.config/kitty
echo 'include ~/.config/kitty/colors-kitty.conf' > ~/.config/kitty/kitty.conf

# Waybar
cp -r waybar ~/.config/.
cp ~/.cache/wal/colors-waybar.css ~/config/waybar/.
```

**Note**: right now after Meta+S or Meta+L Hyprland may lag out wallpapers (or waybar). Wallpaper can be set again with `swww -i`. You can also press Meta+M to reload Hyprland or reboot.

## Shadowsocks and outline

[shadowsocks-rust](https://github.com/shadowsocks/shadowsocks-rust) is already included in this build

### ss:// links

1. Put your key into a file
2. Generate config: `ssurl -d $(cat keyfile) > config.json`
3. Use config to start local server: `sslocal -c config.json -b 127.0.0.1:8388` (port can be changed) OR use docker

Then you can use it as proxy:
- in firefox through extensions (for example foxyproxy)
- in shell through `proxychains4` (change port in `configuration.nix` if required)

### ssconf:// links

1. Put your `ssconf` link into `outline.sh` (`KEY` variable)
2. Replace `ssconf` with `https`
3. run `./outline.sh`

Generated config can be found at `~/.config/shadowsocks-rust/config.json`

## Cleanup

```shell
sudo nix-collect-garbage -d

# rebuild and check for one configuration
cat /boot/grub/grub.cfg
# this also should give only one configuration:
sudo nix-env -p /nix/var/nix/profiles/system --list-generations
```
