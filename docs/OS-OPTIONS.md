## programs\.scroll\.enable

Whether to enable scroll, a fork of Sway (an i3-compatible Wayland compositor) with a scrolling
tiling layout\.
\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```



## programs\.scroll\.package



The scroll package to use\.



*Type:*
package



*Default:*

```nix
<derivation sway-1.12>
```



*Example:*

```nix
<derivation sway-1.12>
```



## programs\.scroll\.extraOptions



Command line arguments passed to launch scroll\.



*Type:*
list of string



*Default:*

```nix
[ ]
```



*Example:*

```nix
[
  "--verbose"
  "--debug"
]
```



## programs\.scroll\.extraPackages



Extra packages to be installed system wide\. See
[https://github\.com/swaywm/sway/wiki/Useful-add-ons-for-sway](https://github\.com/swaywm/sway/wiki/Useful-add-ons-for-sway) and
[https://github\.com/swaywm/sway/wiki/i3-Migration-Guide\#common-x11-apps-used-on-i3-with-wayland-alternatives](https://github\.com/swaywm/sway/wiki/i3-Migration-Guide\#common-x11-apps-used-on-i3-with-wayland-alternatives)
for a list of useful software\.



*Type:*
list of package



*Default:*

```nix
with pkgs; [ brightnessctl kitty grim pulseaudio swayidle swaylock wmenu xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-wlr slurp ];

```



*Example:*

```nix
with pkgs; [ i3status i3status-rust termite rofi light ]

```



## programs\.scroll\.extraSessionCommands



Shell commands executed just before scroll is started\. See
[https://github\.com/swaywm/sway/wiki/Running-programs-natively-under-wayland](https://github\.com/swaywm/sway/wiki/Running-programs-natively-under-wayland),
[https://github\.com/swaywm/wlroots/blob/master/docs/env_vars\.md](https://github\.com/swaywm/wlroots/blob/master/docs/env_vars\.md)
and [https://github\.com/dawsers/scroll\#environment-variables](https://github\.com/dawsers/scroll\#environment-variables)
for some useful environment variables\.



*Type:*
strings concatenated with “\\n”



*Default:*

```nix
""
```



*Example:*

```nix
''
  # Sway/Scroll needs its environment variables here
  # Set GTK theme
  export GTK_THEME=Adwaita-dark
  # Tell QT, GDK and others to use the Wayland backend by default, X11 if not available
  export QT_QPA_PLATFORM="wayland;xcb"
  export GDK_BACKEND="wayland,x11"
  export SDL_VIDEODRIVER=wayland
  export CLUTTER_BACKEND=wayland
  
  # XDG desktop variables to set scroll as the desktop
  export XDG_CURRENT_DESKTOP=scroll
  export XDG_SESSION_TYPE=wayland
  export XDG_SESSION_DESKTOP=scroll
  
  # Configure Electron to use Wayland instead of X11
  export ELECTRON_OZONE_PLATFORM_HINT=wayland
  
  export QT_WAYLAND_DISABLE_WINDOWDECORATION=1 # Disables window decorations on Qt applications
  export QT_QPA_PLATFORMTHEME=qt6ct
  # This is to (temporarily) fix font rendering on QWebEngineView 6
  # (qutebrowser, goldendict etc.)
  # https://bugreports.qt.io/browse/QTBUG-113574
  export QT_SCALE_FACTOR_ROUNDING_POLICY=RoundPreferFloor
  
  # If you use a Nvidia card
  # NVIDIA environment variables
  export LIBVA_DRIVER_NAME=nvidia
  export GBM_BACKEND=nvidia-drm
  export __GLX_VENDOR_LIBRARY_NAME=nvidia
  
  export XCURSOR_THEME=Adwaita
  export XCURSOR_SIZE=24
''
```



## programs\.scroll\.wrapperFeatures\.base



Whether to enable the base wrapper to execute extra session commands and prepend a
dbus-run-session to the scroll command\.



*Type:*
boolean



*Default:*

```nix
true
```



*Example:*

```nix
true
```



## programs\.scroll\.wrapperFeatures\.gtk



Whether to enable the wrapGAppsHook wrapper to execute scroll with required environment
variables for GTK applications\.



*Type:*
boolean



*Default:*

```nix
false
```



*Example:*

```nix
true
```



## programs\.scroll\.xwayland\.enable



Whether to enable XWayland\.



*Type:*
boolean



*Default:*

```nix
true
```



*Example:*

```nix
true
```


