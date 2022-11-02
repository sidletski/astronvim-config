# AstroNvim

Configuration to make your [AstroNvim](https://github.com/AstroNvim/AstroNvim) perfect

## Plugins list

- [vim-suround](https://github.com/tpope/vim-surround)
- [vim-smoothie](https://github.com/psliwka/vim-smoothie)
- [copilot](https://github.com/github/copilot.vim)

## Custom mappings

- `C-s` save files in all modes
- `C-a` select the contents of the entire file
- `C-l` accept copilot's suggestion instead of the `Tab` key
- `<leader>bc` close all tabs except opened one
- `<leader><leader>` clear search
... and many others!

## How to install the config

Clone this repository to the `user` folder of your AstroNvim configuration dir:

```bash
  git clone https://github.com/sidletski/astronvim-config ~/.config/nvim/lua/user
```

After that, initialize nvim in the headless mode to install new plugins:
```bash
  nvim  --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
```
