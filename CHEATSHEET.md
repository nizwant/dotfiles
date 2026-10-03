# Terminal cheat sheet

Run `cheat` to show this file.

## Shell keys

| Key              | What it does                                              |
|------------------|-----------------------------------------------------------|
| `Ctrl-R`         | Fuzzy-search history; Enter puts the command on the line  |
| `Ctrl-T`         | Fuzzy-pick files and insert their paths (Tab marks more)  |
| `Alt-C`          | Fuzzy-pick a subdirectory and cd into it                  |
| `Tab`            | Fuzzy completion menu; type to filter, `<` `>` groups     |
| `**<Tab>`        | Fuzzy path completion anywhere: `nvim src/**<Tab>`        |
| `Up` / `Down`    | History entries containing what you've typed              |
| `Ctrl-X Ctrl-E`  | Edit the command line in nvim; `:wq`, then Enter to run   |
| `Alt-.`          | Insert the last argument of the previous command          |

Alt keys in macOS Terminal need *Settings → Profiles → Keyboard →
Use Option as Meta key*. `# comments` are allowed on the command line.

## Moving around

| Command         | What it does                                              |
|-----------------|-----------------------------------------------------------|
| `cd <words>`    | Real path as usual, else jump to the best-ranked matching directory (`cd thes`) |
| `cdi`           | Pick from visited directories interactively               |
| `-` / `cd -`    | Previous directory                                        |
| `..` `...` `....` | Up one, two, three levels                               |

zoxide learns from every `cd`, so jumps get better as you use it.

## Files and search

| Command          | What it does                                             |
|------------------|----------------------------------------------------------|
| `fd <pattern>`   | Find files by name (skips .gitignore'd; `-H` hidden too) |
| `rg <pattern>`   | Search file contents (`-i` ignore case, `-l` names only) |
| `cat <file>`     | Syntax-highlighted cat; `\cat` is the plain one          |
| `bat <file>`     | Viewer with line numbers, git changes and paging         |
| `man <cmd>`      | Highlighted man pages                                    |
| `ll` / `la`      | Long listing / include dotfiles                          |
| `ports` / `myip` | Listening ports / public IP                              |
| `tldr <cmd>`     | Short, example-first help for a command                  |

## Git

`lg` opens lazygit:

| Key        | What it does                                                  |
|------------|---------------------------------------------------------------|
| `1`–`5`    | Panels: status, files, branches, commits, stash               |
| `space`    | Stage/unstage file; on a branch: check it out                 |
| `a`        | Stage everything                                              |
| `enter`    | Open a file to stage single hunks or lines                    |
| `c`        | Commit                                                        |
| `P` / `p`  | Push / pull                                                   |
| `n`        | New branch (in the branches panel)                            |
| `z`        | Undo                                                          |
| `?` / `q`  | All keys / quit                                               |

- Diffs (`gd`, `gds`, `git show`, `git log -p`) are highlighted by delta;
  `n` / `N` jump between files.
- `gco <Tab>` gives a fuzzy branch list, most recent first.
- The first `gp` on a new branch sets the upstream automatically.
- Merge conflicts also show the common ancestor (zdiff3).
- Aliases: `gs ga gaa gc gca gco gcb gp gpl gf gl gd gds gbr gbd gm gi gcl`

## tmux (prefix is `Ctrl-b`)

| Key              | What it does                                            |
|------------------|---------------------------------------------------------|
| `prefix "` / `%` | Split below / right, in the current directory           |
| `prefix c`       | New window, in the current directory                    |
| `prefix x` / `&` | Kill pane / window (no confirmation)                    |
| `prefix [`       | Copy mode: `v` select, `y` copy to clipboard, `q` quit  |
| mouse drag       | Copy to clipboard                                       |
| `prefix r`       | Reload tmux.conf                                        |
| `prefix I`       | Install plugins                                         |

## Conda and Python

| Command           | What it does                                           |
|-------------------|--------------------------------------------------------|
| `ca <env>`        | Activate an env (its name shows in the prompt)         |
| `conda deactivate`| Leave it                                               |
| `cenv`            | List envs                                              |
| `ccreate <name>`  | Create an env                                          |
| `pipr`            | `pip install -r requirements.txt`                      |
| `uv venv`         | Create a fast venv for a non-conda project             |
| `uv pip install`  | Install into it, much faster than pip                  |
| `uv run <script>` | Run with the project's dependencies                    |

Outside a conda env, `python` is mise's Python 3.13; an activated conda
env's `python` takes precedence.

## Tool versions (mise)

| Command                   | What it does                                    |
|---------------------------|-------------------------------------------------|
| `mise ls`                 | Installed tools and versions                    |
| `mise upgrade`            | Update every tool                               |
| `mise use -g <tool>@<v>`  | Add or pin a tool everywhere (edits dotfiles)   |
| `mise use node@20`        | Pin a version for the current project only      |
| `mise registry <name>`    | Check whether mise can install a tool           |

New tool? Try `mise use -g <tool>` first; if mise doesn't have it,
`brew install` it and add it to `~/dotfiles/Brewfile`. Projects with an
`.nvmrc` or `.python-version` get those versions automatically.
