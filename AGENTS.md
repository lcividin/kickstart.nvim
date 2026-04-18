# AGENTS.md — Neovim Config

Personal Neovim configuration based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), extended with custom plugins.

## Architecture

```
init.lua                          ← MAIN entry point (customised)
lua/
  kickstart/plugins/              ← Optional kickstart example plugins (loaded from init.lua)
    autopairs.lua, debug.lua, gitsigns.lua, indent_line.lua, lint.lua, neo-tree.lua
  custom/
    init.lua                      ← UPSTREAM kickstart reference (NOT loaded, NOT the entry point)
    plugins/                      ← Personal plugins, one file per plugin
      init.lua                    ← Placeholder returning {} — do not add plugins here
      crush_ai.lua, lazygit.lua, nvim-dap.lua, opencode-ai.lua, render-markdown.lua,
      snack-nvim.lua, speedtyper-nvim.lua, toogleterm.lua, vim-tmux-navigator.lua, vimtidal.lua
```

**Plugin manager:** `lazy.nvim` (auto-installed on first run).

## Adding / Modifying Plugins

- New plugins go in `lua/custom/plugins/` as individual `.lua` files, each returning a lazy.nvim spec table.
- `lua/custom/plugins/init.lua` returns `{}` and must stay that way — lazy.nvim `{ import = 'custom.plugins' }` auto-imports all sibling files.
- Kickstart optional plugins (`lua/kickstart/plugins/`) are loaded explicitly in `init.lua`. Keep personal changes out of those files to avoid upstream merge pain.

## Formatting

Lua code is formatted with **stylua**. Settings in `.stylua.toml`:

| Setting | Value |
|---|---|
| column_width | 160 |
| indent_type | Spaces (2) |
| quote_style | AutoPreferSingle |
| call_parentheses | None |
| collapse_simple_statement | Always |

Format on save is enabled via `conform.nvim` (runs `stylua` for Lua files). CI checks formatting on PRs via `.github/workflows/stylua.yml`.

To format manually in Neovim: `<leader>f`

## LSP / Diagnostics

- **lua-language-server** and **stylua** installed via Mason.
- **harper-ls** (grammar/spell checker) active for `markdown`, `text`, `tex`, `gitcommit`, `mail`.
- Spell checking also enabled as a native Vim option for `text`, `markdown`, `tex` (`spelllang = en_au,en_us`).
- `textwidth = 80`, `colorcolumn = 80`.

> **False-positive LSP errors:** All project-level diagnostics shown in this repo are YAML LSP errors being incorrectly applied to `.lua` files. They are entirely spurious — ignore them. There are no real Lua errors.

## Active vs Inactive Configs

| File | Status |
|---|---|
| `init.lua` (root) | **Active** — the customised main config |
| `lua/custom/init.lua` | **Inactive** — upstream kickstart reference, kept for merging; not loaded by Neovim |
| `lua/kickstart/plugins/debug.lua` | **Inactive** — commented out in `init.lua`; replaced by `lua/custom/plugins/nvim-dap.lua` |

## Merge Conflicts

At the time of writing, `git status` shows `UU init.lua` and `UU lua/custom/plugins/init.lua`, meaning there are **unresolved merge conflicts** in both files. Resolve them before making further changes.

## Key Plugin Notes

### snacks.nvim (`lua/custom/plugins/snack-nvim.lua`)
Loaded eagerly (`lazy = false`, `priority = 1000`). Provides its own picker, file explorer, dashboard, notifier, indent guides, scroll animation, zen mode, and more. **Before adding a new plugin for any of these features, check if snacks already covers it.**

Notable snacks keymaps defined there (not in `init.lua`):
- `<leader><space>` smart find files, `<leader>,` buffers, `<leader>/` grep
- `<leader>e` file explorer, `<leader>gg` lazygit
- `<leader>z`/`<leader>Z` zen mode, `<leader>.` scratch buffer
- `<c-/>` terminal, `<leader>n` notifications

### vim-tmux-navigator
Overrides `<C-h/j/k/l>` for seamless tmux pane navigation. The kickstart default `<C-w><C-hjkl>` bindings are no longer the primary split nav.

### nvim-dap (`lua/custom/plugins/nvim-dap.lua`)
Full debug setup with Go (`nvim-dap-go`) and optional Elixir support. Masks variables named `secret` or `api` in virtual text. Keymaps use `<space>b`, `<space>gb`, `<space>?`, and `F1`–`F5`, `F13`.

### Telescope vs Snacks Picker
Both are enabled. Telescope is configured in `init.lua` with `<leader>s*` keymaps. Snacks picker also provides `<leader><space>`, `<leader>,`, `<leader>/` etc. There is intentional overlap — they coexist.

## Leader Keys

- `<leader>` = `<Space>`
- `<localleader>` = `<Space>`

## Nerd Font

`vim.g.have_nerd_font = true` in the active `init.lua`. Icons are enabled throughout.

## No Build or Test Commands

This is a Neovim configuration, not a compiled project. To "test" changes:
1. Open Neovim — lazy.nvim will install/update plugins on startup.
2. Run `:checkhealth` for diagnostics.
3. Run `:Lazy` to manage plugins.
4. Run `:Mason` to manage LSP servers and tools.
