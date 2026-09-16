# Omakub

Turn a fresh Ubuntu installation into a fully-configured, beautiful, and modern web development system by running a single command. That's the one-line pitch for Omakub. No need to write bespoke configs for every essential tool just to get started or to be up on all the latest command-line tools. Omakub is an opinionated take on what Linux can be at its best.

Watch the introduction video and read more at [omakub.org](https://omakub.org).

## About this fork

The [upstream repository](https://github.com/omacom/omakub) is archived. This fork keeps Omakub installing on Ubuntu 26.04 LTS and still supports Ubuntu 24.04. CI checks both releases on every push.

## Install

On a fresh Ubuntu 24.04 or 26.04 desktop, run:

```bash
wget -qO- https://raw.githubusercontent.com/riorizki/omakub/master/boot.sh | bash
```

Set `OMAKUB_REF` to install a branch or tag, and `OMAKUB_REPO` to install from another fork:

```bash
wget -qO- https://raw.githubusercontent.com/riorizki/omakub/master/boot.sh | OMAKUB_REF=ubuntu-26.04-compat bash
```

The installer saves its output to `~/.local/state/omakub/install-<timestamp>.log`. When a step fails, it prints that path and asks whether to retry.

Omakub configures bash. If your login shell is zsh, add these lines to `~/.zshrc` so the `omakub` command works. The aliases and prompt in `defaults/bash` still only apply to bash.

```bash
export OMAKUB_PATH="$HOME/.local/share/omakub"
export PATH="$OMAKUB_PATH/bin:$PATH"
```

## Changes from upstream

- Ubuntu 26.04 fixes:
  - PHP 8.5 installs without the `php-opcache` package, which no longer exists.
  - The Space Bar and Alphabetical App Grid extensions have new schema file names, and the installer copies those.
  - The VS Code apt source matches the one Microsoft and the `code` package write, so apt no longer reports conflicting `Signed-By` values.
  - Obsidian comes from the newest release that has a `.deb`.
  - Alacritty is the default for `xdg-terminal-exec`, fzf completion loads again, and every theme maps to a Yaru variant and GNOME accent color that exist.
- Chrome web apps set `StartupWMClass`, so GNOME on Wayland shows them under their own icons instead of Chrome's.
- Omakub installs Brave Origin by default.
- 1Password and its CLI come from the 1Password apt repository.
- Ghostty is an optional terminal on Ubuntu 26.04.
- Omakub no longer installs Basecamp and HEY by default. Pick them from `omakub`, Install, Web Apps.
- Choosing PHP installs `php-cli`, which leaves Apache out.

## Contributing to the documentation

Please help us improve Omakub's documentation on the [basecamp/omakub-site repository](https://github.com/basecamp/omakub-site).

## License

Omakub is released under the [MIT License](https://opensource.org/licenses/MIT).

## Extras

While omakub is purposed to be an opinionated take, the open source community offers alternative customization, add-ons, extras, that you can use to adjust, replace or enrich your experience.

[⇒ Browse the omakub extensions.](EXTENSIONS.md)
