# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
  };

  networking.hostName = "epsilon"; # Hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time = {
    timeZone = "Europe/Moscow";
    hardwareClockInLocalTime = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Enable programs
  programs = {
    # Desktop
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    waybar.enable = true;

    # Proxychains use local port
    proxychains = {
      enable = true;
      package = pkgs.proxychains-ng;
      proxies = {
        ss8388 = {
          enable = true;
          type = "socks5";
          host = "127.0.0.1";
          port = 8388;
        };
      };
    };
  };

  # Env variables
  environment.sessionVariables = {
    # Hint electron apps to use Wayland
    NIXOS_OZONE_WL = "1";
    
    # Tell Firfox to use Wayland
    MOZ_ENABLE_WAYLAND = "1";

    # Xdg
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";

    # SDL Wayland
    SDL_VIDEODRIVER = "wayland";

    # Hyprland renderer
    WLR_RENDERER = "vulkan";

    # Portals
    GTK_USE_PORTAL = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";

    # Use helix as default sudo editor
    EDITOR = "hx";
    SUDO_EDITOR = "hx";
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Hardware opengl
  hardware.opengl = {
    enable = true;
    # Acceleration
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Desktop interactions (links, screenrec, etc.)
  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal
        xdg-desktop-portal-gtk
      ];
    };
  };

  # Services
  services = {
    # Windowing server
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "";
      libinput.enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };

    # App-to-app messaging system
    dbus.enable = true;

    # Create thumbnails for files
    tumbler.enable = true;

    # FS abstraction over net/local
    gvfs.enable = true;

    # Fn keys
    actkbd.enable = true;    

    # Brightness fn keys
    illum.enable = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.k0tran = {
    isNormalUser = true;
    description = "k0tran";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable python2
  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.6"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Desktop up bar
    waybar
 
    # Wallpapers
    swww
    # All color schemes can be found at .cache/wal
    pywal
    # Required for wal
    imagemagick
    
    # Terminal
    kitty
    
    # App runner
    wofi
    
    # Network widget
    networkmanagerapplet
    
    # Notifications
    dunst
    libnotify
    
    # Acceleration
    libva-utils
    
    # Disk automount
    udiskie

    # xrandr for hyprland
    wlr-randr

    # Clipboard support
    wl-clipboard

    # Hyprland portals
    xdg-desktop-portal-hyprland
    hyprland-share-picker

    # Hyprland Wayland protocol extensions
    hyprland-protocols

    # Color picker
    hyprpicker

    # Wayland idle
    swayidle

    # Screenshot tool
    grim
    slurp

    # xdg stuff
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk

    # Media player
    mpv

    # File manager
    qt5.qtwayland
    libsForQt5.dolphin

    # Icons
    papirus-icon-theme

    # Browser
    firefox-wayland

    # Messaging
    telegram-desktop
    discord

    # Text editors
    helix    
    vscodium

    # Dev tools
    git
    docker
    clang
    python3Full
    python2
    rustup
    zig
    zls
    gef # advanced gdb

    # System tools
    killall
    file
    wget

    # Shadowsocks
    shadowsocks-rust
    # You could also install extensions for firefox like foxyproxy
  ];

  virtualisation.docker.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
