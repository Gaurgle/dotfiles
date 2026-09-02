# CLAUDE.md - dotfiles

## What this is

The shared configuration for Andreas's two macOS machines, cloned at
`~/.dotfiles` on each. GNU `stow` symlinks the subdirectories (`zsh/`, `nvim/`,
`git/`, ...) into `$HOME`, and `.dotcore` declares which packages a machine
should have. `dotsync` pulls, installs what is missing, and re-stows.

There is no build and no test suite. The unit of work is a config file plus, if
it needs a package, a line in `.dotcore`.

<!-- house-rules:start v1 -->
## House rules

These mirror the global config at `~/claude-config`, which is machine-local and
therefore invisible to cloud and mobile sessions. They apply here regardless of
where the session runs.

- **Never use em-dashes or en-dashes** in any output: chat, files, or code. Use
  a hyphen, a colon, parentheses, or rewrite the sentence.
- **Conventional Commits** (`feat:`, `fix:`, `refactor:`, `docs:`, `test:`,
  `cleanup:`), first line under 72 characters. Body is for the why, not the what.
- **No `Co-Authored-By` lines.** Ever.
- **Present the full `git commit -m "..."` command for review; do not commit.**
  The human commits and pushes.
- **Never edit, delete or disable a test to make code pass.** Fix the code. If a
  test looks wrong, stop and say so rather than changing it.
- **Ask before** adding or removing dependencies, changing schema or API
  contracts, touching CI config, or deleting files.
<!-- house-rules:end -->

## Where things are written down

| Path | What it holds |
|---|---|
| `README.md` | The tour: what is installed, keybindings, the app-by-app reference |
| `.dotcore` | The package manifest, and the only authoritative list |
| `keyboards/` | Physical keyboards, VIA definitions, keymaps, Karabiner rules |
| `keyboards/<board>/` | One directory per board, with its VIA JSON beside its notes |

`README.md` is written for a human reading top to bottom. `.dotcore` is written
for the parser. Where a package list appears in both, `.dotcore` wins and the
README is the stale one.

## Working conventions

- **Ship policy: commit and push straight to `main`.** No feature branch, no PR.
  Single committer, and `dotsync` pulls from `main`, so a long-lived branch just
  means one machine is out of date.
- **Always `git fetch` and rebase before pushing.** The other machine commits
  here too, and its work arrives without warning. A non-fast-forward rejection
  on push is the normal case, not a problem.
- Adding a tool: append it to the right `.dotcore` section with a short inline
  comment, then commit. Both machines pick it up on the next `dotup`.

## Commands

```
dotsync    # pull, install missing packages from .dotcore, stow core configs
dotup      # dotsync && exec zsh (full sync plus shell reload)
dotdrift   # diagnostic only: what is installed but not in .dotcore, and vice versa
```

`dotdrift` changes nothing. Run it on each machine and diff the two outputs to
see where they have drifted apart.

## Domain invariants - do not violate

- **The repo path `~/.dotfiles` is hardcoded in the `dotsync` function.** Moving
  or renaming the clone breaks sync on that machine with no useful error.
- **`.dotcore` only ever adds.** `dotsync` installs what is missing and never
  removes, so deleting a line does not uninstall anything. Removing a tool is a
  manual `brew uninstall` on each machine.
- **`.dotcore` sections are split by whether they prompt.** `[brew]`, `[tap]`,
  `[brew-tap]`, `[cask]`, `[cargo]` and `[stow]` install unattended.
  `[brew-langs]`, `[cask-langs]` and `[brew-db]` prompt per machine, and the
  answer is remembered in `~/.dotup-prefs`. That file lives in `$HOME`, not in
  the repo, and is deliberately not synced. Naming is `<kind>-<topic>` where
  `<kind>` is `brew` or `cask`.
- **Inline `#` comments in `.dotcore` are stripped by the parser.** Keep them
  short and do not put anything load-bearing in them.
- **Karabiner detaches its own stow symlink.** Karabiner-Elements rewrites
  `~/.config/karabiner/karabiner.json` atomically on every GUI edit, which
  replaces the symlink with a plain file and silently orphans the repo copy.
  Copy the live file in before committing rather than trusting the link:

  ```bash
  cp ~/.config/karabiner/karabiner.json ~/.dotfiles/karabiner/.config/karabiner/karabiner.json
  ```

- **Keyboard hardware and keymaps live in `keyboards/`, never in the root
  README.** They were split across both and a loose file in `~/Downloads`, which
  is how the ISO Nordic layout and the VIA V2/V3 split went unrecorded. The root
  README links to `keyboards/` and states no hardware detail of its own.
- **macOS on Apple Silicon only.** One ARM Homebrew at `/opt/homebrew`. Never
  suggest `arch -x86_64`, `/usr/local` paths, or an Intel Homebrew.
- **Secrets never enter this repo.** App and development secrets go through the
  `doppler` CLI (`doppler run -- <cmd>`), not `.env` files and not hardcoded
  values. Personal logins live in Proton Pass, a GUI app with no CLI, so do not
  suggest `pass` or any other CLI password manager.
