#!/usr/bin/env python3

"""
Converts the Sway config into a Nix attribute set.

Why?
If keybindings were provided manually, they would have to also be updated manually.
This would add more maintenance overhead.

Why Python?
It's a lot simpler and more readable to use Python over Nix for something like this.
"""

from collections import defaultdict
import sys

CONFIG = sys.argv[1]


def escape(s: str) -> str:
    """Basic function to escape some of the Nix expressions"""
    return s.replace("\\", "\\\\").replace('"', '\\"').replace("${", "''${")


try:
    with open(CONFIG) as f:
        lines: list[str] = f.readlines()
except:
    print("{}")
    sys.exit()

keybindings: dict[str, str] = {}
modes: defaultdict[str, dict[str, str]] = defaultdict(dict)
current_mode: str | None = None

for line in lines:
    stripped: str = line.strip()

    if stripped == "}" and current_mode is not None:
        # Exit mode section:
        # }
        current_mode = None

    elif stripped.startswith("mode"):
        # Enter mode section:
        # mode "mode" {

        # Remove mode prefix
        nomode: str = "mode".join(stripped.split("mode")[1:]).strip()

        if nomode.startswith('"'):
            # Get name from in between the quotes
            # (not implementing escaping since it isn't necessary)
            current_mode = nomode.split('"')[1]
        elif nomode.startswith("'"):
            # Same as above but with single quotes
            current_mode = nomode.split("'")[1]
        else:
            # Get name until "{"
            # (not implementing one line mode definitions since those don't appear in def config)
            current_mode = nomode.split("{")[0].strip()

    elif stripped.startswith("bindsym"):
        # Parse bindsym line:
        # bindsym [--args] keycombo command

        # Remove bindsym
        nobindsym: str = "bindsym".join(stripped.split("bindsym")[1:]).strip()

        # Then iterate through each word
        key_list: list[str] = []
        value_list: list[str] = []

        bind_added: bool = False

        for word in nobindsym.split(" "):
            if word.startswith("--") and not bind_added:
                # Add args
                key_list.append(word)
            elif not bind_added:
                # Add keycombo
                key_list.append(word)
                bind_added = True
            else:
                # Add command (rest of the words)
                value_list.append(word)

        key: str = (
            escape(" ".join(key_list))
            .replace("$mod", "${cfg.config.modifier}")
            .replace("$term", "${cfg.config.terminal}")
            .replace("$menu", "${cfg.config.menu}")
            .replace("$left", "${cfg.config.left}")
            .replace("$right", "${cfg.config.right}")
            .replace("$up", "${cfg.config.up}")
            .replace("$down", "${cfg.config.down}")
        )
        value: str = escape(" ".join(value_list))

        if current_mode is None:
            keybindings.update({key: value})
        else:
            # Here defaultdict will create the current_mode key automatically
            # so we don't have to check if it exists
            modes[current_mode].update({key: value})

print("{ cfg }:")
print("{")

print("  keybindings = {")

for keycombo, command in keybindings.items():
    print(f'    "{keycombo}" = "{command}";')

print("  };")

print("  modes = {")

for mode, binds in modes.items():
    print(f'    "{mode}" = ' + "{")

    for keycombo, command in binds.items():
        print(f'      "{keycombo}" = "{command}";')

    print("    };")

print("};")

print("}")
