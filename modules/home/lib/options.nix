{
  self,
  config,
  lib,
  moduleName,
  cfg,
  pkgs,
  capitalModuleName ? moduleName,
}:
let
  inherit (lib) literalExpression mkOption types;

  isI3 = moduleName == "i3";
  isSway = !isI3; # Sway opts are also supported in scroll
  isScroll = moduleName == "scroll";

  inherit (config.home) stateVersion;

  fontOptions = types.submodule {
    options = {
      names = mkOption {
        type = types.listOf types.str;
        default = [ "monospace" ];
        defaultText = literalExpression ''[ "monospace" ]'';
        description = ''
          List of font names list used for window titles. Only FreeType fonts are supported.
          The order here is important (e.g. icons font should go before the one used for text).
        '';
        example = [
          "FontAwesome"
          "Terminus"
        ];
      };

      style = mkOption {
        type = types.str;
        default = "";
        description = ''
          The font style to use for window titles.
        '';
        example = "Bold Semi-Condensed";
      };

      size = mkOption {
        # Modded to allow integers
        type = types.either types.number types.str;
        default = 8.0;
        description = ''
          The font size to use for window titles.
        '';
        example = 11.5;
      };
    };
  };

  startupModule = types.submodule {
    options = {
      command = mkOption {
        type = types.str;
        description = "Command that will be executed on startup.";
      };

      always = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to run command on each ${moduleName} restart.";
      };
    }
    // lib.optionalAttrs isI3 {
      notification = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Whether to enable startup-notification support for the command.
          See {option}`--no-startup-id` option description in the i3 user guide.
        '';
      };

      workspace = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = ''
          Launch application on a particular workspace. DEPRECATED:
          Use [](#opt-xsession.windowManager.i3.config.assigns)
          instead. See <https://github.com/nix-community/home-manager/issues/265>.
        '';
      };
    };

  };

  barModule = types.submodule {
    options =
      let
        versionAtLeast2009 = lib.versionAtLeast stateVersion "20.09";
        mkNullableOption =
          { type, default, ... }@args:
          mkOption (
            args
            // {
              type = types.nullOr type;
              default = if versionAtLeast2009 then null else default;
              defaultText = literalExpression ''
                null for state version ≥ 20.09, as example otherwise
              '';
            }
          );
      in
      {
        fonts = mkOption {
          type = with types; either (listOf str) fontOptions;
          default = { };
          example = {
            names = [
              "DejaVu Sans Mono"
              "FontAwesome5Free"
            ];
            style = "Bold Semi-Condensed";
            size = 11.0;
          };
          description = "Font configuration for this bar.";
        };

        extraConfig = mkOption {
          type = types.lines;
          default = "";
          description = "Extra configuration lines for this bar.";
        };

        id = mkOption {
          type = types.nullOr types.str;
          default = null;
          description = ''
            Specifies the bar ID for the configured bar instance.
            If this option is missing, the ID is set to bar-x, where x corresponds
            to the position of the embedding bar block in the config file.
          '';
        };

        mode = mkNullableOption {
          type = types.enum [
            "dock"
            "hide"
            "invisible"
          ];
          default = "dock";
          description = "Bar visibility mode.";
        };

        hiddenState = mkNullableOption {
          type = types.enum [
            "hide"
            "show"
          ];
          default = "hide";
          description = "The default bar mode when 'bar.mode' == 'hide'.";
        };

        position = mkNullableOption {
          type = types.enum [
            "top"
            "bottom"
          ];
          default = "bottom";
          description = "The edge of the screen ${moduleName}bar should show up.";
        };

        workspaceButtons = mkNullableOption {
          type = types.bool;
          default = true;
          description = "Whether workspace buttons should be shown or not.";
        };

        workspaceNumbers = mkNullableOption {
          type = types.bool;
          default = true;
          description = "Whether workspace numbers should be displayed within the workspace buttons.";
        };

        command = mkOption {
          type = types.str;
          default =
            let
              # If the user uses the "system" Sway (i.e. cfg.package == null) then the bar has
              # to come from a different package
              pkg =
                if isSway && isNull cfg.package then
                  if isScroll then self.packages.${pkgs.stdenv.hostPlatform.system}.scroll-stable else pkgs.sway
                else
                  cfg.package;
            in
            "${pkg}/bin/${moduleName}bar";
          defaultText = literalExpression "i3bar";
          description = "Command that will be used to start a bar.";
          example = if isI3 then "\${pkgs.i3}/bin/i3bar -t" else "\${pkgs.waybar}/bin/waybar";
        };

        statusCommand = mkNullableOption {
          type = types.str;
          default = "${pkgs.i3status}/bin/i3status";
          defaultText = literalExpression "\${pkgs.i3status}/bin/i3status";
          description = "Command that will be used to get status lines.";
        };

        colors = mkOption {
          type = types.submodule {
            options = {
              background = mkNullableOption {
                type = types.str;
                default = "#000000";
                description = "Background color of the bar.";
              };

              statusline = mkNullableOption {
                type = types.str;
                default = "#ffffff";
                description = "Text color to be used for the statusline.";
              };

              separator = mkNullableOption {
                type = types.str;
                default = "#666666";
                description = "Text color to be used for the separator.";
              };

              focusedBackground = mkOption {
                type = types.nullOr types.str;
                default = null;
                description = "Background color of the bar on the currently focused monitor output.";
                example = "#000000";
              };

              focusedStatusline = mkOption {
                type = types.nullOr types.str;
                default = null;
                description = "Text color to be used for the statusline on the currently focused monitor output.";
                example = "#ffffff";
              };

              focusedSeparator = mkOption {
                type = types.nullOr types.str;
                default = null;
                description = "Text color to be used for the separator on the currently focused monitor output.";
                example = "#666666";
              };

              focusedWorkspace = mkNullableOption {
                type = barColorSetModule;
                default = {
                  border = "#4c7899";
                  background = "#285577";
                  text = "#ffffff";
                };
                description = ''
                  Border, background and text color for a workspace button when the workspace has focus.
                '';
              };

              activeWorkspace = mkNullableOption {
                type = barColorSetModule;
                default = {
                  border = "#333333";
                  background = "#5f676a";
                  text = "#ffffff";
                };
                description = ''
                  Border, background and text color for a workspace button when the workspace is active.
                '';
              };

              inactiveWorkspace = mkNullableOption {
                type = barColorSetModule;
                default = {
                  border = "#333333";
                  background = "#222222";
                  text = "#888888";
                };
                description = ''
                  Border, background and text color for a workspace button when the workspace does not
                  have focus and is not active.
                '';
              };

              urgentWorkspace = mkNullableOption {
                type = barColorSetModule;
                default = {
                  border = "#2f343a";
                  background = "#900000";
                  text = "#ffffff";
                };
                description = ''
                  Border, background and text color for a workspace button when the workspace contains
                  a window with the urgency hint set.
                '';
              };

              bindingMode = mkNullableOption {
                type = barColorSetModule;
                default = {
                  border = "#2f343a";
                  background = "#900000";
                  text = "#ffffff";
                };
                description = "Border, background and text color for the binding mode indicator";
              };
            };
          };
          default = { };
          description = ''
            Bar color settings. All color classes can be specified using submodules
            with 'border', 'background', 'text', fields and RGB color hex-codes as values.
            See default values for the reference.
            Note that 'background', 'status', and 'separator' parameters take a single RGB value.

            See <https://i3wm.org/docs/userguide.html#_colors>.
          '';
        };

        trayOutput = mkNullableOption {
          type = types.str;
          # Sway/Wayland doesn't have the concept of a primary output. The default for sway is to show it on all outputs
          default = if isI3 then "primary" else "*";
          description = "Where to output tray.";
        };

        trayPadding = mkNullableOption {
          type = types.int;
          default = null;
          description = ''
            Sets the pixel padding of the system tray.
            This padding will surround the tray on all sides and between each item.
          '';
        };
      };
  };

  barColorSetModule = types.submodule {
    options = {
      border = mkOption {
        type = types.str;
        visible = false;
      };

      background = mkOption {
        type = types.str;
        visible = false;
      };

      text = mkOption {
        type = types.str;
        visible = false;
      };
    };
  };

  colorSetModule = types.submodule {
    options = {
      border = mkOption {
        type = types.str;
        visible = false;
      };

      childBorder = mkOption {
        type = types.str;
        visible = false;
      };

      background = mkOption {
        type = types.str;
        visible = false;
      };

      text = mkOption {
        type = types.str;
        visible = false;
      };

      indicator = mkOption {
        type = types.str;
        visible = false;
      };
    };
  };

  windowCommandModule = types.submodule {
    options = {
      command = mkOption {
        type = types.str;
        description = "${capitalModuleName}wm command to execute.";
        example = "border pixel 1";
      };

      criteria = mkOption {
        type = criteriaModule;
        description = ''
          Criteria of the windows on which command should be executed.

          A value of `true` is equivalent to using an empty
          criteria (which is different from an empty string criteria).
        '';
        example = literalExpression ''
          {
            title = "x200: ~/work";
            floating = true;
          };
        '';
      };
    };
  };

  criteriaModule = types.attrsOf (types.either types.str types.bool);

  curveOrder = with types; either ints.unsigned (enum [ "simple" ]);

  animationModule = types.submodule {
    options = {
      # TODO: consider making this nullable
      enable = lib.mkEnableOption { };

      duration = mkOption {
        type = with lib.types; nullOr ints.unsigned;
        default = null;
        description = ''
          Duration of the animation in milliseconds.
        '';
      };

      # TODO: make dedicated types for animation curves
      # TODO: consider making var and off nullable directly not just via suboptions
      var = {
        order = mkOption {
          type = types.nullOr curveOrder;
          default = null;
          description = ''
            Defines the order of the Bezier curve. See {manpage}`scroll(5)` for more details.
          '';
        };

        controlPoints = mkOption {
          type = with types; nullOr (listOf number);
          default = null;
          description = ''
            Defines the animation control points. See {manpage}`scroll(5)` for more details.
          '';
        };
      };

      off = {
        scale = mkOption {
          type = with types; nullOr number;
          default = null;
          description = ''
            Defines the scale of the animation curve for the variable
            that doesn't change the operation/command.
            See {manpage}`scroll(5)` for more details.
          '';
        };

        order = mkOption {
          type = types.nullOr curveOrder;
          default = null;
          description = ''
            Defines the scale of the animation curve for the variable
            that doesn't change the operation/command.
            See {manpage}`scroll(5)` for more details.
          '';
        };

        controlPoints = mkOption {
          type = with types; nullOr (listOf number);
          default = null;
          description = ''
            Defines the scale of the animation curve for the variable
            that doesn't change the operation/command.
            See {manpage}`scroll(5)` for more details.
          '';
        };
      };
    };
  };

  # Type used as a position [ x y ]
  xy = with types; addCheck (listOf int) (xs: builtins.length xs == 2);
in
{
  fonts = mkOption {
    type = with types; either (listOf str) fontOptions;
    default = { };
    example = {
      names = [
        "DejaVu Sans Mono"
        "FontAwesome5Free"
      ];
      style = "Bold Semi-Condensed";
      size = 11.0;
    };
    description = "Font configuration for window titles, nagbar...";
  };

  window = mkOption {
    type = types.submodule {
      options = {
        titlebar = mkOption {
          type = types.bool;
          default =
            if lib.versionOlder stateVersion "23.05" then (isI3 && (cfg.config.gaps == null)) else true;
          defaultText =
            if isI3 then
              ''
                true for state version ≥ 23.05
                config.gaps == null for state version < 23.05
              ''
            else
              ''
                true for state version ≥ 23.05
                false for state version < 23.05
              '';
          description = "Whether to show window titlebars.";
        };

        border = mkOption {
          type = types.int;
          default = 2;
          description = "Window border width.";
        };

        hideEdgeBorders = mkOption {
          type =
            let
              i3Options = [
                "none"
                "vertical"
                "horizontal"
                "both"
                "smart"
              ];
              swayOptions = i3Options ++ [ "smart_no_gaps" ];
            in
            if isI3 then
              types.enum i3Options
            else
              types.enum (swayOptions ++ (map (e: "--i3 ${e}") swayOptions));
          default = "none";
          description = "Hide window borders adjacent to the screen edges.";
        };

        commands = mkOption {
          type = types.listOf windowCommandModule;
          default = [ ];
          description = ''
            List of commands that should be executed on specific windows.
            See {option}`for_window` ${moduleName}wm option documentation.
          '';
          example = [
            {
              command = "border pixel 1";
              criteria = {
                class = "XTerm";
              };
            }
          ];
        };
      }
      // lib.optionalAttrs isScroll {
        titlebarBorderRadius = mkOption {
          type = types.ints.unsigned;
          default = 0;
          description = "Border radius of the window titlebar in pixels.";
        };

        borderRadius = mkOption {
          type = types.ints.unsigned;
          default = 0;
          description = "Default window border radius.";
        };

        shadow = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable window shadows";
          };

          dynamic = mkOption {
            type = types.bool;
            default = false;
            description = ''
              Enable dynamic shadows.
              Dynamic shadows change the position of a shadow based on the
              location of the window.
            '';
          };

          size = mkOption {
            type = types.ints.unsigned;
            default = 40;
            description = "Set shadow size in pixels.";
          };

          blur = mkOption {
            type = types.ints.unsigned;
            default = 30;
            description = ''
              Value of the shadow blur in pixels,
              where 0 means sharp.
            '';
          };

          offset = mkOption {
            type = xy;
            default = [ 40 40 ];
            description = "Offset from the shadow from the window.";
          };

          color = mkOption {
            type = types.str;
            default = "#00000040";
            description = "Color of the shadow.";
          };
        };

        dim = {
          enable = mkOption {
            type = types.bool;
            default = false;
            description = "Enable dimming of unfocused windows.";
          };

          color = mkOption {
            type = types.str;
            default = "#00000040";
            description = "Color to use when dimming inactive windows.";
          };
        };
      };
    };
    default = { };
    description = "Window titlebar and border settings.";
  };

  floating = mkOption {
    type = types.submodule {
      options = {
        titlebar = mkOption {
          type = types.bool;
          default =
            if lib.versionOlder stateVersion "23.05" then (isI3 && (cfg.config.gaps == null)) else true;
          defaultText =
            if isI3 then
              ''
                true for state version ≥ 23.05
                config.gaps == null for state version < 23.05
              ''
            else
              ''
                true for state version ≥ 23.05
                false for state version < 23.05
              '';
          description = "Whether to show floating window titlebars.";
        };

        border = mkOption {
          type = types.int;
          default = 2;
          description = "Floating windows border width.";
        };

        modifier = mkOption {
          type = types.str;
          default = cfg.config.modifier;
          defaultText = "${moduleName}.config.modifier";
          description = "Modifier key or keys that can be used to drag floating windows.";
          example = "Mod4";
        };

        criteria = mkOption {
          type = types.listOf criteriaModule;
          default = [ ];
          description = "List of criteria for windows that should be opened in a floating mode.";
          example = [
            { "title" = "Steam - Update News"; }
            { "class" = "Pavucontrol"; }
          ];
        };
      };
    };
    default = { };
    description = "Floating window settings.";
  };

  focus = mkOption {
    type = types.submodule {
      options = {
        newWindow = mkOption {
          type = types.enum [
            "smart"
            "urgent"
            "focus"
            "none"
          ];
          default = "smart";
          description = ''
            This option modifies focus behavior on new window activation.

            See <https://i3wm.org/docs/userguide.html#focus_on_window_activation>
          '';
          example = "none";
        };

        followMouse = mkOption {
          type =
            if isSway then
              types.either (types.enum [
                "yes"
                "no"
                "always"
              ]) types.bool
            else
              types.bool;
          default = if isSway then "yes" else true;
          description = "Whether focus should follow the mouse.";
          apply = val: if (isSway && lib.isBool val) then (lib.hm.booleans.yesNo val) else val;
        };

        wrapping = mkOption {
          type = types.enum [
            "yes"
            "no"
            "force"
            "workspace"
          ];
          default =
            rec {
              i3 = if cfg.config.focus.forceWrapping then "force" else "yes";
              # the sway module's logic was inverted and incorrect,
              # so preserve it for backwards compatibility purposes
              sway = if cfg.config.focus.forceWrapping then "yes" else "no";
              scroll = sway;
            }
            .${moduleName};
          defaultText =
            literalExpression
              rec {
                i3 = ''if focus.forceWrapping then "force" else "yes"'';
                sway = ''if focus.forceWrapping then "yes" else "no"'';
                scroll = sway;
              }
              .${moduleName};
          description = ''
            Whether the window focus commands automatically wrap around the edge of containers.

            See <https://i3wm.org/docs/userguide.html#_focus_wrapping>
          '';
        };

        forceWrapping = mkOption {
          type = types.bool;
          default = false;
          description = ''
            Whether to force focus wrapping in tabbed or stacked containers.

            This option is deprecated, use {option}`focus.wrapping` instead.
          '';
        };

        mouseWarping = mkOption {
          type =
            if isSway then
              types.oneOf [
                types.bool
                (types.enum [
                  "container"
                  "output"
                ])
              ]
            else
              types.bool;
          default = true;
          description = ''
            Whether mouse cursor should be warped to the center of the window when switching focus
            to a window on a different output.
          '';
        };
      };
    };
    default = { };
    description = "Focus related settings.";
  };

  assigns = mkOption {
    type = types.attrsOf (types.listOf criteriaModule);
    default = { };
    description = ''
      An attribute set that assigns applications to workspaces based
      on criteria.
    '';
    example = {
      "1: web" = [ { class = "^Firefox$"; } ];
      "0: extra" = [
        {
          class = "^Firefox$";
          window_role = "About";
        }
      ];
    };
  };

  modifier = mkOption {
    type = types.either (types.enum [
      "Shift"
      "Control"
      "Mod1"
      "Mod2"
      "Mod3"
      "Mod4"
      "Mod5"
    ]) types.str;
    default = "Mod1";
    description = "Modifier key that is used for all default keybindings.";
    example = "Mod4";
  };

  workspaceLayout = mkOption {
    type = types.enum [
      "default"
      "stacking"
      "tabbed"
    ];
    default = "default";
    example = "tabbed";
    description = ''
      The mode in which new containers on workspace level will
      start.
    '';
  };

  workspaceAutoBackAndForth = mkOption {
    type = types.bool;
    default = false;
    example = true;
    description = ''
      Assume you are on workspace "1: www" and switch to "2: IM" using
      mod+2 because somebody sent you a message. You don’t need to remember
      where you came from now, you can just press $mod+2 again to switch
      back to "1: www".
    '';
  };

  keycodebindings = mkOption {
    type = types.attrsOf (types.nullOr types.str);
    default = { };
    description = ''
      An attribute set that assigns keypress to an action using key code.
      See <https://i3wm.org/docs/userguide.html#keybindings>.
    '';
    example = {
      "214" = "exec /bin/script.sh";
    };
  };

  colors = mkOption {
    type = types.submodule {
      options = {
        background = mkOption {
          type = types.str;
          default = "#ffffff";
          description = ''
            Background color of the window. Only applications which do not cover
            the whole area expose the color.
          '';
        };

        focused = mkOption {
          type = colorSetModule;
          default = {
            border = "#4c7899";
            background = "#285577";
            text = "#ffffff";
            indicator = "#2e9ef4";
            childBorder = "#285577";
          };
          description = "A window which currently has the focus.";
        };

        focusedInactive = mkOption {
          type = colorSetModule;
          default = {
            border = "#333333";
            background = "#5f676a";
            text = "#ffffff";
            indicator = "#484e50";
            childBorder = "#5f676a";
          };
          description = ''
            A window which is the focused one of its container,
            but it does not have the focus at the moment.
          '';
        };

        unfocused = mkOption {
          type = colorSetModule;
          default = {
            border = "#333333";
            background = "#222222";
            text = "#888888";
            indicator = "#292d2e";
            childBorder = "#222222";
          };
          description = "A window which is not focused.";
        };

        urgent = mkOption {
          type = colorSetModule;
          default = {
            border = "#2f343a";
            background = "#900000";
            text = "#ffffff";
            indicator = "#900000";
            childBorder = "#900000";
          };
          description = "A window which has its urgency hint activated.";
        };

        placeholder = mkOption {
          type = colorSetModule;
          default = {
            border = "#000000";
            background = "#0c0c0c";
            text = "#ffffff";
            indicator = "#000000";
            childBorder = "#0c0c0c";
          };
          description = ''
            Background and text color are used to draw placeholder window
            contents (when restoring layouts). Border and indicator are ignored.
          '';
        };
      }
      // lib.optionalAttrs isScroll {
        pinned = mkOption {
          type = colorSetModule;
          default = {
            border = "#beeeef";
            background = "#000000";
            text = "#ffffff";
            indicator = "#efeebe";
            childBorder = "#beeeef";
          };
          description = "A pinned column/row.";
        };

        pinnedFocused = mkOption {
          type = colorSetModule;
          default = {
            border = "#6e8eef";
            background = "#000000";
            text = "#ffffff";
            indicator = "#efeebe";
            childBorder = "#6e8eef";
          };
          description = "A pinned column/row that is currently focused.";
        };

        sticky = mkOption {
          type = colorSetModule;
          default = {
            border = "#beeeef";
            background = "#000000";
            text = "#ffffff";
            indicator = "#efeebe";
            childBorder = "#beeeef";
          };
          description = "A sticky view/container.";
        };

        stickyFocused = mkOption {
          type = colorSetModule;
          default = {
            border = "#6e8eef";
            background = "#000000";
            text = "#ffffff";
            indicator = "#efeebe";
            childBorder = "#6e8eef";
          };
          description = "A sticky view/container that is currently focused.";
        };
      };
    };
    default = { };
    description = ''
      Color settings. All color classes can be specified using submodules
      with 'border', 'background', 'text', 'indicator' and 'childBorder' fields
      and RGB color hex-codes as values. See default values for the reference.
      Note that '${moduleName}.config.colors.background' parameter takes a single RGB value.

      See <https://i3wm.org/docs/userguide.html#_changing_colors>.
    '';
  };

  bars = mkOption {
    type = types.listOf barModule;
    default =
      if lib.versionAtLeast stateVersion "20.09" then
        [
          {
            mode = "dock";
            hiddenState = "hide";
            position = "bottom";
            workspaceButtons = true;
            workspaceNumbers = true;
            statusCommand = "${pkgs.i3status}/bin/i3status";
            fonts = {
              names = [ "monospace" ];
              size = 8.0;
            };
            trayOutput = "primary";
            colors = {
              background = "#000000";
              statusline = "#ffffff";
              separator = "#666666";
              focusedWorkspace = {
                border = "#4c7899";
                background = "#285577";
                text = "#ffffff";
              };
              activeWorkspace = {
                border = "#333333";
                background = "#5f676a";
                text = "#ffffff";
              };
              inactiveWorkspace = {
                border = "#333333";
                background = "#222222";
                text = "#888888";
              };
              urgentWorkspace = {
                border = "#2f343a";
                background = "#900000";
                text = "#ffffff";
              };
              bindingMode = {
                border = "#2f343a";
                background = "#900000";
                text = "#ffffff";
              };
            };
          }
        ]
      else
        [ { } ];
    defaultText = literalExpression "see code";
    description = ''
      ${capitalModuleName} bars settings blocks. Set to empty list to remove bars completely.
    '';
  };

  startup = mkOption {
    type = types.listOf startupModule;
    default = [ ];
    description = ''
      Commands that should be executed at startup.

      See <https://i3wm.org/docs/userguide.html#_automatically_starting_applications_on_i3_startup>.
    '';
    example =
      if isI3 then
        literalExpression ''
          [
          { command = "systemctl --user restart polybar"; always = true; notification = false; }
          { command = "dropbox start"; notification = false; }
          { command = "firefox"; }
          ];
        ''
      else
        literalExpression ''
          [
          { command = "systemctl --user restart waybar"; always = true; }
          { command = "dropbox start"; }
          { command = "firefox"; }
          ]
        '';
  };

  gaps = mkOption {
    type = types.nullOr (
      types.submodule {
        options = {
          inner = mkOption {
            type = types.nullOr types.int;
            default = null;
            description = "Inner gaps value.";
            example = 12;
          };

          outer = mkOption {
            type = types.nullOr types.int;
            default = null;
            description = "Outer gaps value.";
            example = 5;
          };

          horizontal = mkOption {
            type = types.nullOr types.int;
            default = null;
            description = "Horizontal gaps value.";
            example = 5;
          };

          vertical = mkOption {
            type = types.nullOr types.int;
            default = null;
            description = "Vertical gaps value.";
            example = 5;
          };

          top = mkOption {
            type = types.nullOr types.int;
            default = null;
            description = "Top gaps value.";
            example = 5;
          };

          left = mkOption {
            type = types.nullOr types.int;
            default = null;
            description = "Left gaps value.";
            example = 5;
          };

          bottom = mkOption {
            type = types.nullOr types.int;
            default = null;
            description = "Bottom gaps value.";
            example = 5;
          };

          right = mkOption {
            type = types.nullOr types.int;
            default = null;
            description = "Right gaps value.";
            example = 5;
          };

          smartGaps = mkOption {
            type = types.either types.bool (
              types.enum [
                "on"
                "off"
                "inverse_outer"
              ]
            );
            apply =
              value:
              if value == true then
                "on"
              else if value == false then
                "off"
              else
                value;
            default = "off";
            description = ''
              This option controls whether to disable all gaps (outer and inner)
              on workspace with a single container.
            '';
            example = "on";
          };

          smartBorders = mkOption {
            type = types.enum [
              "on"
              "off"
              "no_gaps"
            ];
            default = "off";
            description = ''
              This option controls whether to disable container borders on
              workspace with a single container.
            '';
          };
        };
      }
    );
    default = null;
    description = ''
      Gaps related settings.
    '';
  };

  terminal = mkOption {
    type = types.str;
    default =
      if isI3 then
        "i3-sensible-terminal"
      else if isScroll then
        "${pkgs.kitty}/bin/kitty"
      else
        "${pkgs.foot}/bin/foot";
    defaultText = literalExpression (
      if isI3 then
        ''"i3-sensible-terminal"''
      else if isScroll then
        "\${pkgs.kitty}/bin/kitty"
      else
        "\${pkgs.foot}/bin/foot"
    );
    description = "Default terminal to run.";
    example = "alacritty";
  };

  menu = mkOption {
    type = types.str;
    default =
      if isSway then
        "${pkgs.dmenu}/bin/dmenu_path | ${pkgs.dmenu}/bin/dmenu | ${pkgs.findutils}/bin/xargs ${moduleName}msg exec --"
      else
        "${pkgs.dmenu}/bin/dmenu_run";
    defaultText = literalExpression (
      if isSway then
        "\${pkgs.dmenu}/bin/dmenu_path | \${pkgs.dmenu}/bin/dmenu | \${pkgs.findutils}/bin/xargs ${moduleName}msg exec --"
      else
        "\${pkgs.dmenu}/bin/dmenu_run"
    );
    description = "Default launcher to use.";
    example = "bemenu-run";
  };

  defaultWorkspace = mkOption {
    type = types.nullOr types.str;
    default = null;
    description = ''
      The default workspace to show when ${if isSway then "sway" else "i3"} is launched.
      This must to correspond to the value of the keybinding of the default workspace.
    '';
    example = "workspace number 9";
  };

  workspaceOutputAssign = mkOption {
    type =
      let
        workspaceOutputOpts = types.submodule {
          options = {
            workspace = mkOption {
              # modded to allow int
              type = with types; oneOf [ int str ];
              default = "";
              example = "Web";
              description = ''
                Name of the workspace to assign.
              '';
            };

            output = mkOption {
              type = with types; either str (listOf str);
              default = "";
              apply = lib.lists.toList;
              example = "eDP";
              description = ''
                Name(s) of the output(s) from {command}`
                  ${if isSway then "${moduleName}msg" else "i3-msg"} -t get_outputs
                `.
              '';
            };
          };
        };
      in
      types.listOf workspaceOutputOpts;
    default = [ ];
    description = "Assign workspaces to outputs.";
  };

  # TODO: add Sway gestures option

  # NOTE: All options below are Scroll-specific

  animations = mkOption {
    type = types.submodule {
      # Options copied from default config
      # https://github.com/dawsers/scroll/blob/master/config.in#L112
      options = {
        enable = mkOption {
          type = lib.types.bool;
          default = true;
        };

        style = mkOption {
          type = lib.types.enum [
            "clip"
            "scale"
          ];
          default = "scale";
        };

        default = mkOption {
          type = animationModule;
          default = {
            enable = true;
            duration = 300;
            var = {
              order = 3;
              controlPoints = [
                0.215
                0.61
                0.355
                1
              ];
            };
          };
        };

        windowOpen = mkOption {
          type = animationModule;
          default = {
            enable = true;
            duration = 300;
            var = {
              order = 3;
              controlPoints = [
                0
                0
                1
                1
              ];
            };
          };
        };

        windowMove = mkOption {
          type = animationModule;
          default = {
            enable = true;
            duration = 300;
            var = {
              order = 3;
              controlPoints = [
                0.215
                0.61
                0.355
                1
              ];
            };
            off = {
              scale = 0.05;
              order = 6;
              controlPoints = [
                0
                0.06
                0.04
                0
                1
                0
                0.4
                (-0.6)
                1
                (-0.6)
              ];
            };
          };
        };

        windowSize = mkOption {
          type = animationModule;
          default = {
            enable = true;
            duration = 300;
            var = {
              order = 3;
              controlPoints = [ (-0.35) 0 0 0.5 ];
            };
          };
        };

        workspaceSwitch = mkOption {
          type = animationModule;
          default = {
            enable = true;
            duration = 500;
            var = {
              order = "simple";
              controlPoints = [ 0.215 0.61 0.355 1 ];
            };
          };
        };

        windowFullscreen = mkOption {
          type = animationModule;
          default = {
            enable = true;
            duration = 500;
            var = {
              order = "simple";
              controlPoints = [ 0.3 0.5 0.4 1 ];
            };
          };
        };

        jump = mkOption {
          type = animationModule;
          default = {
            enable = true;
            duration = 500;
            var = {
              order = "simple";
              controlPoints = [ 0.215 0.61 0.355 1 ];
            };
          };
        };

        layerShell = mkOption {
          type = animationModule;
          default = {
            enable = true;
            duration = 300;
            var = {
              order = "simple";
              controlPoints = [ 0 0 1 1 ];
            };
          };
        };

        fadeIn = mkOption {
          type = animationModule;
          default = {
            enable = true;
            duration = 300;
            var = {
              order = "simple";
              controlPoints = [ 0.32 0 0.67 0 ];
            };
          };
        };

        fadeOut = mkOption {
          type = animationModule;
          default = {
            enable = true;
            duration = 300;
            var = {
              order = "simple";
              controlPoints = [ 0.33 1 0.68 1 ];
            };
          };
        };

        windowMoveFloat = mkOption {
          type = animationModule;
          default = {
            # TODO: supply default values
            enable = true;
            duration = 300;
          };
        };

        overview = mkOption {
          type = animationModule;
          default = {
            # TODO: supply default values
            enable = true;
            duration = 300;
          };
        };
      };
    };
    default = { };
    description = ''
      Configure Scroll animations. See {manpage}`scroll(5)` for more details.
    '';
  };

  jump = mkOption {
    type = types.submodule {
      options = {
        keys = mkOption {
          type = types.str;
          default = "1234";
          description = ''
            Keys to use for jump mode. They will also be used as window labels.
          '';
        };

        keysAlt = mkOption {
          type = with types; listOf str;
          default = [ ];
          example = [
            "ampersand"
            "eacute"
            "quotedbl"
            "apostrophe"
          ];
          description = ''
            Alternative keys that correspond to the regular keys but are not
            used as labels.
            Example for an AZERTY keyboard:
              ```
              keys = "1234";
              keysAlt = [ "ampersand" "eacute" "quotedbl" "apostrophe" ];
              ```
            This makes pressing ampersand have the same effect as pressing 1,
            eacute same as 2 and so on.
            Windows are still labeled with 1, 2, 3 and 4 and keys 1234 still
            work the same.
          '';
        };

        labels = {
          background = mkOption {
            type = types.str;
            default = "#00000000";
            description = "Background color of the jump labels.";
          };

          color = mkOption {
            type = types.str;
            default = "#159E3080";
            description = "Color of the jump labels.";
          };

          scale = mkOption {
            type = types.number;
            default = 0.5;
            description = "Scale of the labels within the windows.";
          };

          swallow = mkOption {
            type = types.bool;
            default = false;
            description = ''
              Makes pressing a key in jump mode update the labels, showing only
              showing only the characters still available to press.
            '';
          };
        };
      };
    };
  };

  # TODO: document
  snap = mkOption {
    type = types.submodule {
      options = {
        gap = {
          window = mkOption {
            type = types.ints.unsigned;
            default = 0;
            description = ''
              Maximum distance between window borders to snap them.
            '';
          };

          workspace = mkOption {
            type = types.ints.unsigned;
            default = 0;
            description = ''
              Maximum distance between workspace and window borders to snap them
            '';
          };
        };

        respectGaps = {
          inner = mkOption {
            type = types.bool;
            default = false;
            description = "Whether snapping should respect `gaps inner`";
          };

          outer = mkOption {
            type = types.bool;
            default = false;
            description = "Whether snapping should respect `gaps outer`";
          };
        };

        borderOverlap = mkOption {
          type = types.bool;
          default = false;
          description = "Whether window borders should overlap when snapping.";
        };
      };
    };
  };

  # TODO: consider adding more Scroll options such as layout widths/heights
}
