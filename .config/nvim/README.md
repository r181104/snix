# Neovim Productivity Setup

Modern Neovim configuration with powerful editing capabilities and IDE-like features.

## ✨ Key Features
- **File Management**: `Oil.nvim` explorer (`<leader>e`)
- **Fuzzy Search**: FZF-Lua (`<leader>ff`/`<leader>fg`)
- **Git Integration**: LazyGit (`<leader>git`) + Gitsigns
- **UI Enhancements**: 
  - Catppuccin theme with transparent background
  - Lualine status bar
  - Color highlighter (`<leader>tc`)
- **LSP Support**: Lua, Svelte, Typst, Python, Emmet
- **Navigation**: Tmux/Vim pane switching (`Ctrl+h/j/k/l`)

## ⌨️ Key Bindings
### Core Workflow
| Key          | Action                     |
|--------------|----------------------------|
| `<leader>e`  | File explorer (Oil)        |
| `<leader>ff` | Find files                 |
| `<leader>fg` | Live grep                  |
| `<leader>fb` | Find buffers               |
| `<leader>git`| Open LazyGit               |
| `<leader>gb` | Show git blame             |
| `;`          | Bookmark position          |

### Enhanced LSP Bindings
| Key          | Action                     |
|--------------|----------------------------|
| `gd`         | Go to definition           |
| `gD`         | Go to declaration          |
| `gi`         | Go to implementation       |
| `gr`         | Find references            |
| `K`          | Show documentation         |
| `<leader>rf` | Rename symbol              |
| `<leader>ca` | Code actions               |
| `<leader>ws` | Workspace symbols          |
| `<leader>dl` | Show line diagnostics      |
| `<leader>da` | Show all diagnostics       |
| `<leader>fmt`| Format document            |

### Editor Essentials
| Key          | Action                     |
|--------------|----------------------------|
| `<leader>w`  | Save file                  |
| `<leader>q`  | Quit                       |
| `<leader>so` | Reload config              |
| `<leader>y`  | Yank to system clipboard   |
| `<leader>d`  | Cut to system clipboard    |

## ⚙️ LSP Usage Guide
1. Open supported file type (`.lua`, `.svelte`, `.typ`, `.py`, `.html`)
2. Use LSP keybinds for code navigation/editing
3. Essential commands:
   - `:LspInfo` - Show active LSP servers
   - `:LspRestart` - Restart language server
   - `:Mason` - Manage LSP installations

## 🚀 Getting Started
1. Place this config in `~/.config/nvim/`
2. Install plugins with `:Lazy` (if using lazy.nvim) or `:PackerSync`
3. Install LSP servers via Mason:
