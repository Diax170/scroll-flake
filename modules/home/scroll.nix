{ self }: # scroll
{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    concatStringsSep
    filterAttrs
    hasPrefix
    mapAttrsToList
    mkIf
    mkOption
    optional
    types
    boolToString
    ;

  cfg = config.wayland.windowManager.scroll;

  commonOptions = import ./lib/options.nix {
    inherit
      self # scroll
      config
      lib
      cfg
      pkgs
      ;
    moduleName = "scroll";
    capitalModuleName = "Scroll";
  };

  generators = import ./lib/generators/generators.nix {
    inherit
      cfg
      pkgs
      ;
    moduleName = "scroll";
  };

  configModule = types.submodule {
    options = {
      inherit (commonOptions)
        fonts
        window
        floating
        focus
        assigns
        workspaceLayout
        workspaceAutoBackAndForth
        modifier
        keycodebindings
        colors
        bars
        startup
        gaps
        menu
        terminal
        defaultWorkspace
        workspaceOutputAssign
        # scroll
        animations
        jump
        snap
        ;

      left = mkOption {
        type = types.str;
        default = "left";
        description = "Home row direction key for moving left.";
      };

      down = mkOption {
        type = types.str;
        default = "down";
        description = "Home row direction key for moving down.";
      };

      up = mkOption {
        type = types.str;
        default = "up";
        description = "Home row direction key for moving up.";
      };

      right = mkOption {
        type = types.str;
        default = "right";
        description = "Home row direction key for moving right.";
      };

      keybindings = mkOption {
        type = types.attrsOf (types.nullOr types.str);
        # https://github.com/dawsers/scroll/blob/master/config.in#L129
        default = lib.mapAttrs (_n: lib.mkOptionDefault) generators.keybindings.keybindings;
        defaultText = "Default scroll keybindings.";
        description = ''
          An attribute set that assigns a key press to an action using a key symbol.
          See <https://i3wm.org/docs/userguide.html#keybindings>.

          Consider to use `lib.mkOptionDefault` function to extend or override
          default keybindings instead of specifying all of them from scratch.
        '';
        example = lib.literalExpression ''
          let
            modifier = config.wayland.windowManager.scroll.config.modifier;
          in lib.mkOptionDefault {
            "''${modifier}+Return" = "exec ''${cfg.config.terminal}";
            "''${modifier}+Shift+q" = "kill";
            "''${modifier}+d" = "exec ''${cfg.config.menu}";
          }
        '';
      };

      bindswitches = mkOption {
        type = types.attrsOf bindswitchOption;
        default = { };
        defaultText = "No bindswitches by default";
        description = ''
          Binds <switch> to execute the scroll command command on state changes. Supported switches are lid (laptop
          lid) and tablet (tablet mode) switches. Valid values for state are on, off and toggle. These switches are
          on when the device lid is shut and when tablet mode is active respectively. toggle is also supported to run
          a command both when the switch is toggled on or off.
          See {manpage}`scroll(5)`.
        '';
        example = lib.literalExpression ''
          let
            laptop = "eDP-1";
          in
          {
            "lid:on" = {
              reload = true;
              locked = true;
              action = "output ''${laptop} disable";
            };
            "lid:off" = {
              reload = true;
              locked = true;
              action = "output ''${laptop} enable";
            };
          }
        '';
      };

      bindkeysToCode = mkOption {
        type = types.bool;
        default = false;
        example = true;
        description = ''
          Whether to make use of {option}`--to-code` in keybindings.
        '';
      };

      input = mkOption {
        type = types.attrsOf (types.attrsOf types.anything); # modded
        default = { };
        example = {
          "*" = {
            xkb_variant = "dvorak";
          };
        };
        description = ''
          An attribute set that defines input modules. See
          {manpage}`scroll-input(5)`
          for options.
        '';
      };

      output = mkOption {
        type = types.attrsOf (types.attrsOf types.anything); # modded
        default = { };
        example = {
          "HDMI-A-2" = {
            bg = "~/path/to/background.png fill";
          };
        };
        description = ''
          An attribute set that defines output modules. See
          {manpage}`scroll-output(5)`
          for options.
        '';
      };

      seat = mkOption {
        type = types.attrsOf (types.attrsOf types.anything); # modded
        default = { };
        example = {
          "*" = {
            hide_cursor = "when-typing enable";
          };
        };
        description = ''
          An attribute set that defines seat modules. See
          {manpage}`scroll-input(5)`
          for options.
        '';
      };

      modes = mkOption {
        type = types.attrsOf (types.attrsOf types.str);
        default = generators.keybindings.modes;
        description = ''
          An attribute set that defines binding modes and keybindings
          inside them

          Only basic keybinding is supported (bindsym keycomb action),
          for more advanced setup use 'scroll.extraConfig'.
        '';
      };
    };
  };

  wrapperOptions = types.submodule {
    options =
      let
        mkWrapperFeature =
          default: description:
          mkOption {
            type = types.bool;
            inherit default;
            example = !default;
            description = "Whether to make use of the ${description}";
          };
      in
      {
        base = mkWrapperFeature true ''
          base wrapper to execute extra session commands and prepend a
          dbus-run-session to the scroll command.
        '';
        gtk = mkWrapperFeature false ''
          wrapGAppsHook wrapper to execute scroll with required environment
          variables for GTK applications.
        '';
      };
  };

  bindswitchOption = types.submodule {
    options = {
      action = mkOption {
        type = types.str;
        description = "The scroll command to execute on state changes";
      };

      locked = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Unless the flag --locked is set, the command
          will not be run when a screen locking program
          is active. If there is a matching binding with
          and without --locked, the one with will be preferred
          when locked and the one without will be
          preferred when unlocked.
        '';
      };

      reload = mkOption {
        type = types.bool;
        default = false;
        description = ''
          If the --reload flag is given, the binding will
          also be executed when the config is reloaded.
          toggle bindings will not be executed on reload.
          The --locked flag will operate as normal so if
          the config is reloaded while locked and
          --locked is not given, the binding will not be
          executed.
        '';
      };
    };
  };

  commonFunctions = import ./lib/functions.nix {
    inherit config cfg lib;
    moduleName = "scroll";
  };

  inherit (commonFunctions)
    keybindingsStr
    keycodebindingsStr
    modeStr
    assignStr
    barStr
    gapsStr
    floatingCriteriaStr
    windowCommandsStr
    colorSetStr
    windowBorderString
    fontConfigStr
    keybindingDefaultWorkspace
    keybindingsRest
    workspaceOutputStr
    animationSetStr
    listToStr
    ;

  startupEntryStr =
    {
      command,
      always,
      ...
    }:
    ''
      ${if always then "exec_always" else "exec"} ${command}
    '';

  bindswitchesStr =
    bindswitches:
    concatStringsSep "\n" (
      mapAttrsToList (
        event:
        {
          locked,
          reload,
          action,
        }:
        let
          args = (lib.optionalString locked "--locked ") + (lib.optionalString reload "--reload ");
        in
        "bindswitch ${args} ${event} ${action}"
      ) bindswitches
    );

  # Modded to allow non-string values
  # TODO: convert bool to yes/no
  moduleStr = moduleType: name: attrs: ''
    ${moduleType} "${name}" {
    ${concatStringsSep "\n" (
      lib.mapAttrsToList (
        name: value: "  ${name} ${
          if builtins.isList value then
            listToStr value
          else if builtins.isBool value then
            lib.hm.booleans.yesNo value
          else 
            toString value
        }"
      ) attrs
    )}
    }
  '';
  inputStr = moduleStr "input";
  outputStr = moduleStr "output"; # TODO: also convert lists to string
  seatStr = moduleStr "seat";

  variables = concatStringsSep " " cfg.systemd.variables;
  extraCommands = concatStringsSep " && " cfg.systemd.extraCommands;
  systemdActivation =
    {
      broker = ''exec "systemctl --user import-environment ${variables}; ${extraCommands}"'';
      dbus = ''exec "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd ${variables}; ${extraCommands}"'';
    }
    .${cfg.systemd.dbusImplementation};

  configFile = pkgs.writeTextFile {
    name = "scroll.conf";

    # Scroll always does some init, see https://github.com/swaywm/sway/issues/4691
    checkPhase = lib.optionalString cfg.checkConfig ''
      export DBUS_SESSION_BUS_ADDRESS=/dev/null
      export XDG_RUNTIME_DIR=$(mktemp -d)
      ${pkgs.xvfb-run}/bin/xvfb-run ${cfg.package}/bin/scroll --config "$target" --validate || {
        echo "Checking the scroll config file failed. Normally, this happens because there are errors in the config file."
        echo "But the check can also fail if the scroll config file has dependencies on configuration that is not available in the Nix build sandbox (e.g. custom keyboard layouts defined in the NixOS configuration; background images in the user's home directory)."
        echo "In that case, it may be necessary to set 'wayland.windowManager.scroll.checkConfig = false;'."
        exit 1
      }
    '';

    text = concatStringsSep "\n" (
      (optional (cfg.extraConfigEarly != "") cfg.extraConfigEarly)
      ++ (
        if cfg.config != null then
          with cfg.config;
          (
            [
              (fontConfigStr fonts)
              "floating_modifier ${floating.modifier}"
              (windowBorderString window floating)
              "hide_edge_borders ${window.hideEdgeBorders}"
              "focus_wrapping ${focus.wrapping}"
              "focus_follows_mouse ${focus.followMouse}"
              "focus_on_window_activation ${focus.newWindow}"
              "mouse_warping ${
                if builtins.isString (focus.mouseWarping) then
                  focus.mouseWarping
                else if focus.mouseWarping then
                  "output"
                else
                  "none"
              }"
              "workspace_layout ${workspaceLayout}"
              "workspace_auto_back_and_forth ${lib.hm.booleans.yesNo workspaceAutoBackAndForth}"
              "client.focused ${colorSetStr colors.focused}"
              "client.focused_inactive ${colorSetStr colors.focusedInactive}"
              "client.unfocused ${colorSetStr colors.unfocused}"
              "client.urgent ${colorSetStr colors.urgent}"
              "client.placeholder ${colorSetStr colors.placeholder}"
              "client.background ${colors.background}"
              "client.pinned ${colorSetStr colors.pinned}"
              "client.pinned_focused ${colorSetStr colors.pinnedFocused}"
              "client.sticky ${colorSetStr colors.sticky}"
              "client.sticky_focused ${colorSetStr colors.stickyFocused}"
              (keybindingsStr {
                keybindings = keybindingDefaultWorkspace;
                bindsymArgs = lib.optionalString (cfg.config.bindkeysToCode) "--to-code";
              })
              (keybindingsStr {
                keybindings = keybindingsRest;
                bindsymArgs = lib.optionalString (cfg.config.bindkeysToCode) "--to-code";
              })
              (keycodebindingsStr keycodebindings)

              # Scroll
              "animations enabled ${lib.hm.booleans.yesNo animations.enable}"
              "animations style ${animations.style}"

              "jump_labels_background '${jump.labels.background}'"
              "jump_labels_color '${jump.labels.color}'"
              "jump_labels_keys '${jump.keys}' ${if (jump.keysAlt == [ ]) then "" else listToStr jump.keysAlt}"
              "jump_labels_scale ${toString jump.labels.scale}"
              "jump_labels_swallow ${boolToString jump.labels.swallow}"

              # TODO: consider adding an enable option for snap
              "snap_window_gap ${toString snap.gap.window}"
              "snap_workspace_gap ${toString snap.gap.workspace}"
              "snap_respect_gaps_inner ${boolToString snap.respectGaps.inner}"
              "snap_respect_gaps_outer ${boolToString snap.respectGaps.outer}"
              "snap_border_overlap ${boolToString snap.borderOverlap}"

              # TODO: consider adding this to windowCommandsStr
              "titlebar_border_radius ${toString window.titlebarBorderRadius}"

              (
                with window;
                concatStringsSep " " [
                  "default_decoration"
                  "border_radius ${toString borderRadius}"
                  "shadow ${boolToString shadow.enable}"
                  "shadow_dynamic ${boolToString shadow.dynamic}"
                  "shadow_size ${toString shadow.size}"
                  "shadow_blur ${toString shadow.blur}"
                  "shadow_offset ${toString (builtins.elemAt shadow.offset 0)} ${toString (builtins.elemAt shadow.offset 1)}"
                  "shadow_color ${shadow.color}"
                  "dim ${boolToString dim.enable}"
                  "dim_color ${dim.color}"
                ]
              )
            ]
            ++ optional (builtins.attrNames bindswitches != [ ]) (bindswitchesStr bindswitches)
            ++ mapAttrsToList inputStr (filterAttrs (n: _v: n == "*") input)
            ++ mapAttrsToList inputStr (filterAttrs (n: _v: hasPrefix "type:" n) input)
            ++ mapAttrsToList inputStr (filterAttrs (n: _v: n != "*" && !(hasPrefix "type:" n)) input)
            ++ mapAttrsToList outputStr output # outputs
            ++ mapAttrsToList seatStr seat # seats
            ++ mapAttrsToList (modeStr cfg.config.bindkeysToCode) modes # modes
            ++ mapAttrsToList assignStr assigns # assigns
            ++ map barStr bars # bars
            ++ optional (gaps != null) gapsStr # gaps
            ++ map floatingCriteriaStr floating.criteria # floating
            ++ map windowCommandsStr window.commands # window commands
            ++ map startupEntryStr startup # startup
            ++ map workspaceOutputStr workspaceOutputAssign # custom mapping
            # Scroll
            # TODO: find a cleaner approach
            ++ map (x: "animations ${x} ${animationSetStr animations.${lib.toCamelCase x}}") [
              "default"
              "window_open"
              "window_move"
              "window_size"
              "workspace_switch"
              "window_fullscreen"
              "jump"
              "layer_shell"
              "fade_in"
              "fade_out"
              "window_move_float"
              "overview"
            ]
          )
        else
          [ ]
      )
      ++ (optional cfg.systemd.enable systemdActivation)
      ++ (optional (!cfg.xwayland) "xwayland disable")
      ++ [ cfg.extraConfig ]
    );
  };
in
{
  meta.maintainers = [ ];

  imports =
    let
      modulePath = [
        "wayland"
        "windowManager"
        "scroll"
      ];
    in
    [
      (lib.mkRenamedOptionModule (modulePath ++ [ "systemdIntegration" ]) (
        modulePath
        ++ [
          "systemd"
          "enable"
        ]
      ))
    ];

  options.wayland.windowManager.scroll = {
    enable = lib.mkEnableOption "scroll wayland compositor";

    package = mkOption {
      type = with types; nullOr package;
      default = self.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
        inherit (cfg) extraOptions extraSessionCommands;
        withBaseWrapper = cfg.wrapperFeatures.base;
        withGtkWrapper = cfg.wrapperFeatures.gtk;
      };
      # defaultText = lib.literalExpression "\${pkgs.sway}";
      description = ''
        scroll package to use. Will override the options
        'wrapperFeatures', 'extraSessionCommands', and 'extraOptions'.
        Set to `null` to not add any scroll package to your
        path. This should be done if you want to use the NixOS scroll
        module to install scroll. Beware setting to `null` will also disable
        reloading scroll when new config is activated.
      '';
    };

    systemd = {
      enable = mkOption {
        type = types.bool;
        default = pkgs.stdenv.hostPlatform.isLinux;
        example = false;
        description = ''
          Whether to enable {file}`scroll-session.target` on
          scroll startup. This links to
          {file}`graphical-session.target`.
          Some important environment variables will be imported to systemd
          and dbus user environment before reaching the target, including
          * {env}`DISPLAY`
          * {env}`WAYLAND_DISPLAY`
          * {env}`I3SOCK`
          * {env}`SWAYSOCK`
          * {env}`SCROLLSOCK`
          * {env}`XDG_CURRENT_DESKTOP`
          * {env}`XDG_SESSION_TYPE`
          * {env}`NIXOS_OZONE_WL`
          * {env}`XCURSOR_THEME`
          * {env}`XCURSOR_SIZE`
          You can extend this list using the `systemd.variables` option.
        '';
      };

      variables = mkOption {
        type = types.listOf types.str;
        default = [
          "DISPLAY"
          "WAYLAND_DISPLAY"
          "I3SOCK"
          "SWAYSOCK"
          "SCROLLSOCK"
          "XDG_CURRENT_DESKTOP"
          "XDG_SESSION_TYPE"
          "NIXOS_OZONE_WL"
          "XCURSOR_THEME"
          "XCURSOR_SIZE"
        ];
        example = [ "--all" ];
        description = ''
          Environment variables imported into the systemd and D-Bus user environment.
        '';
      };

      dbusImplementation = mkOption {
        type = types.enum [
          "dbus"
          "broker"
        ];
        default = "dbus";
        example = "broker";
        description = ''
          The D-Bus implementation used on the system.
          This affects which tool is used to import environment variables when starting the scroll session.
          On NixOS, this should match the value of the option [`services.dbus.implementation` (NixOS)](https://nixos.org/manual/nixos/stable/options#opt-services.dbus.implementation).
          When set to `dbus`, `dbus-update-activation-environment --systemd <variables>` is run.
          Otherwise, when set to `broker`, `systemctl --user import-environment <variables>` is run.
          See <https://github.com/swaywm/sway/wiki#systemd-and-dbus-activation-environments> for more documentation.
        '';
      };

      extraCommands = mkOption {
        type = types.listOf types.str;
        default = [
          "systemctl --user reset-failed"
          "systemctl --user start scroll-session.target"
          "scroll -mt subscribe '[]' || true"
          "systemctl --user stop scroll-session.target"
        ];
        description = ''
          Extra commands to run after D-Bus activation.
        '';
      };

      xdgAutostart = lib.mkEnableOption ''
        autostart of applications using
        {manpage}`systemd-xdg-autostart-generator(8)`
      '';
    };

    xwayland = mkOption {
      type = types.bool;
      default = true;
      description = ''
        Enable xwayland, which is needed for the default configuration of scroll.
      '';
    };

    wrapperFeatures = mkOption {
      type = wrapperOptions;
      default = { };
      example = {
        gtk = true;
      };
      description = ''
        Attribute set of features to enable in the wrapper.
      '';
    };

    extraSessionCommands = mkOption {
      type = types.lines;
      default = "";
      example = ''
        export SDL_VIDEODRIVER=wayland
        # needs qt5.qtwayland in systemPackages
        export QT_QPA_PLATFORM=wayland
        export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        # Fix for some Java AWT applications (e.g. Android Studio),
        # use this if they aren't displayed properly:
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';
      description = ''
        Shell commands executed just before scroll is started.
      '';
    };

    extraOptions = mkOption {
      type = types.listOf types.str;
      default = [ ];
      example = [
        "--verbose"
        "--debug"
      ];
      description = ''
        Command line arguments passed to launch scroll. Please DO NOT report
        issues if you use an unsupported GPU (proprietary drivers).
      '';
    };

    config = mkOption {
      type = types.nullOr configModule;
      default = { };
      description = "scroll configuration options.";
    };

    checkConfig = mkOption {
      type = types.bool;
      default = cfg.package != null;
      defaultText = lib.literalExpression "wayland.windowManager.scroll.package != null";
      description = "If enabled, validates the generated config file.";
    };

    extraConfig = mkOption {
      type = types.lines;
      default = "";
      description = "Extra configuration lines to add to ~/.config/scroll/config.";
    };

    extraConfigEarly = mkOption {
      type = types.lines;
      default = "";
      description = "Like extraConfig, except lines are added to ~/.config/scroll/config before all other configuration.";
    };
  };

  config = mkIf cfg.enable (
    lib.mkMerge [
      {
        assertions = [
          (lib.hm.assertions.assertPlatform "wayland.windowManager.scroll" pkgs lib.platforms.linux)
          {
            assertion = cfg.checkConfig -> cfg.package != null;
            message = "programs.scroll.checkConfig requires non-null programs.scroll.package";
          }
        ];

        home.packages = optional (cfg.package != null) cfg.package ++ optional cfg.xwayland pkgs.xwayland;

        xdg.configFile."scroll/config" = {
          source = configFile;
          onChange = lib.optionalString (cfg.package != null) ''
            scrollSocket="''${XDG_RUNTIME_DIR:-/run/user/$UID}/scroll-ipc.$UID.$(${pkgs.procps}/bin/pgrep --uid $UID -x scroll || true).sock"
            if [ -S "$scrollSocket" ]; then
              ${cfg.package}/bin/scrollmsg -s $scrollSocket reload
            fi
          '';
        };

        # TODO: rename to scroll-session
        systemd.user.targets.scroll-session = mkIf cfg.systemd.enable {
          Unit = {
            Description = "scroll compositor session";
            Documentation = [ "man:systemd.special(7)" ];
            BindsTo = [ "graphical-session.target" ];
            Wants = [
              "graphical-session-pre.target"
            ]
            ++ optional cfg.systemd.xdgAutostart "xdg-desktop-autostart.target";
            After = [ "graphical-session-pre.target" ];
            Before = optional cfg.systemd.xdgAutostart "xdg-desktop-autostart.target";
          };
        };
      }

      (mkIf (cfg.config != null) {
        warnings =
          (optional (lib.isList cfg.config.fonts) "Specifying scroll.config.fonts as a list is deprecated. Use the attrset version instead.")
          ++ lib.flatten (
            map (
              b:
              optional (lib.isList b.fonts) "Specifying scroll.config.bars[].fonts as a list is deprecated. Use the attrset version instead."
            ) cfg.config.bars
          )
          ++ [
            (mkIf cfg.config.focus.forceWrapping "scroll.config.focus.forceWrapping is deprecated, use focus.wrapping instead.")
          ];
      })
    ]
  );
}
