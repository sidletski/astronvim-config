local bufferline = require "bufferline"

local function close_buffers_in_direction(direction)
        bufferline.close_in_direction(direction)
end

local function close_buffers_except_current()
        -- Sorry
        close_buffers_in_direction('left')
        close_buffers_in_direction('right')
end

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {

        -- Configure AstroNvim updates
        updater = {
                remote = "origin", -- remote to use
                channel = "nightly", -- "stable" or "nightly"
                version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
                branch = "main", -- branch name (NIGHTLY ONLY)
                commit = nil, -- commit hash (NIGHTLY ONLY)
                pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
                skip_prompts = false, -- skip prompts about breaking changes
                show_changelog = true, -- show the changelog after performing an update
                auto_reload = false, -- automatically reload and sync packer after a successful update
                auto_quit = false, -- automatically quit the current session after a successful update
                -- remotes = { -- easily add new remotes to track
                --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
                --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
                --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
                -- },
        },

        -- Set colorscheme to use
        colorscheme = "default_theme",

        -- Add highlight groups in any theme
        highlights = {
                init = function()
                        -- get highlights from highlight groups
                        local normal = astronvim.get_hlgroup "Normal"
                        local fg, bg = normal.fg, normal.bg
                        local bg_column = astronvim.get_hlgroup "ColorColumn".bg
                        local bg_alt = astronvim.get_hlgroup("Visual").bg
                        local string_fg = astronvim.get_hlgroup("String").fg
                        local error_fg = astronvim.get_hlgroup("Error").fg
                        local boolean_fg = astronvim.get_hlgroup("Boolean").fg
                        local win_bar_nc_bg = astronvim.get_hlgroup("WinBarNC").bg
                        local visual_bg = astronvim.get_hlgroup("Visual").bg

                        -- return a table of highlights for telescope based on colors gotten from highlight groups
                        return {
                                TelescopeBorder = { fg = bg_alt, bg = bg },
                                TelescopeNormal = { bg = bg },
                                TelescopePreviewBorder = { fg = bg, bg = bg },
                                TelescopePreviewNormal = { bg = bg },
                                TelescopePreviewTitle = { fg = bg, bg = string_fg },
                                TelescopePromptBorder = { fg = bg_alt, bg = bg_alt },
                                TelescopePromptNormal = { fg = fg, bg = bg_alt },
                                TelescopePromptPrefix = { fg = error_fg, bg = bg_alt },
                                TelescopePromptTitle = { fg = bg, bg = error_fg },
                                TelescopeResultsBorder = { fg = bg, bg = bg },
                                TelescopeResultsNormal = { bg = bg },
                                TelescopeResultsTitle = { fg = bg, bg = bg },

                                NotifyINFOBorder = { fg = bg_column, bg = bg },
                                NotifyINFOTitle = { fg = fg, bg = bg },
                                NotifyINFOBody = { fg = fg, bg = bg },

                                WhichKey = { fg = fg, bg = win_bar_nc_bg },
                                WhichKeyGroup = { fg = boolean_fg, bg = win_bar_nc_bg },
                                WhichKeySeparator = { fg = visual_bg, bg = win_bar_nc_bg },
                                WhichKeyDesc = { fg = boolean_fg, bg = win_bar_nc_bg },
                                WhichKeyFloat = { fg = fg, bg = win_bar_nc_bg },

                                MsgArea = { fg = fg, bg = win_bar_nc_bg },
                       }
                end,
        },

        -- set vim options here (vim.<first_key>.<second_key> =  value)
        options = {
                opt = {
                        -- set to true or false etc.
                        relativenumber = true, -- sets vim.opt.relativenumber
                        number = true, -- sets vim.opt.number
                        spell = false, -- sets vim.opt.spell
                        wrap = false, -- sets vim.opt.wrap
                        cmdheight = 1, -- prevent "Press ENTER or type command to continue" messages"
                },
                g = {
                        smoothie_update_interval = 20,
                        smoothie_speed_constant_factor = 90,
                        smoothie_speed_linear_factor = 10,

                        copilot_no_tab_map = true,
                        copilot_assume_mapped = true,
                        copilot_tab_fallback = "",

                        mapleader = " ", -- sets vim.g.mapleader
                        autoformat_enabled = false, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
                        cmp_enabled = true, -- enable completion at start
                        autopairs_enabled = true, -- enable autopairs at start
                        diagnostics_enabled = true, -- enable diagnostics at start
                        status_diagnostics_enabled = true, -- enable diagnostics in statusline
                        icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
                },
        },
        -- If you need more control, you can use the function()...end notation
        -- options = function(local_vim)
        --   local_vim.opt.relativenumber = true
        --   local_vim.g.mapleader = " "
        --   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
        --   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
        --
        --   return local_vim
        -- end,

        -- Set dashboard header
        header = {
                " █████   ████████     █████▙   ████████",
                " ██      ██    ██     ██   ██  ██    ██",
                " ██ ███  ██    ██     ██   ██  ██    ██",
                " ██  ██  ██    ██     ██   ██  ██    ██",
                " ██████  ████████     █████▛   ████████",
                "",
                "     ██████  ██   ██  ████  ▟█████",
                "       ██    ██   ██   ██   ███",
                "       ██    ███████   ██   ▜████▙",
                "       ██    ██   ██   ██      ███",
                "       ██    ██   ██  ████  █████▛"
        },

        -- Default theme configuration
        default_theme = {
                -- Modify the color palette for the default theme
                colors = {
                        fg = "#abb2bf",
                        bg = "#1e222a",
                },
                highlights = function(hl) -- or a function that returns a new table of colors to set
                        local C = require "default_theme.colors"

                        hl.Normal = { fg = C.fg, bg = C.bg }

                        -- New approach instead of diagnostic_style
                        hl.DiagnosticError.italic = true
                        hl.DiagnosticHint.italic = true
                        hl.DiagnosticInfo.italic = true
                        hl.DiagnosticWarn.italic = true

                        return hl
                end,
                -- enable or disable highlighting for extra plugins
                plugins = {
                        aerial = true,
                        beacon = false,
                        bufferline = true,
                        cmp = true,
                        dashboard = true,
                        highlighturl = true,
                        hop = false,
                        indent_blankline = true,
                        lightspeed = false,
                        ["neo-tree"] = true,
                        notify = true,
                        ["nvim-tree"] = false,
                        ["nvim-web-devicons"] = true,
                        rainbow = true,
                        symbols_outline = false,
                        telescope = true,
                        treesitter = true,
                        vimwiki = false,
                        ["which-key"] = true,
                },
        },

        -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
        diagnostics = {
                virtual_text = true,
                underline = true,
        },

        -- Extend LSP configuration
        lsp = {
                -- enable servers that you already have installed without mason
                servers = {
                        -- "pyright"
                },
                formatting = {
                        -- control auto formatting on save
                        format_on_save = {
                                enabled = false, -- enable or disable format on save globally
                                allow_filetypes = { -- enable format on save for specified filetypes only
                                        -- "go",
                                },
                                ignore_filetypes = { -- disable format on save for specified filetypes
                                        -- "python",
                                },
                        },
                        disabled = { -- disable formatting capabilities for the listed language servers
                                -- "sumneko_lua",
                        },
                        timeout_ms = 1000, -- default format timeout
                        filter = function(client)
                                return true
                        end
                },
                -- easily add or disable built in mappings added during LSP attaching
                mappings = {
                        n = {
                                ["<leader>ld"] = { "<cmd>Telescope diagnostics theme=ivy layout_config={height=0.5}<cr>",
                                        desc = "Search diagnostics" }

                        },
                },
                -- add to the global LSP on_attach function
                -- on_attach = function(client, bufnr)
                -- end,

                -- override the mason server-registration function
                -- server_registration = function(server, opts)
                --   require("lspconfig")[server].setup(opts)
                -- end,

                -- Add overrides for LSP server settings, the keys are the name of the server
                ["server-settings"] = {
                        -- example for addings schemas to yamlls
                        -- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
                        --   settings = {
                        --     yaml = {
                        --       schemas = {
                        --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
                        --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                        --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
                        --       },
                        --     },
                        --   },
                        -- },
                },
        },

        -- Mapping data with "desc" stored directly by vim.keymap.set().
        --
        -- Please use this mappings table to set keyboard mapping since this is the
        -- lower level configuration and more robust one. (which-key will
        -- automatically pick-up stored data by this setting.)
        mappings = {
                -- first key is the mode
                n = {
                        -- second key is the lefthand side of the map
                        -- mappings seen under group name "Buffer"
                        ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
                        ["<leader>bp"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
                        ["<leader>bc"] = { function() close_buffers_except_current() end,
                                desc = "Close all except opened one" },
                        ["<leader>bl"] = { function() close_buffers_in_direction('right') end,
                                desc = "Close all to the right" },
                        ["<leader>bh"] = { function() close_buffers_in_direction('left') end,
                                desc = "Close all to the left" },
                        ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
                        ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
                        -- utils
                        ["<leader><leader>"] = { ":let @/ = \"\"<cr>", desc = "Clear search" },
                        ["<C-a>"] = { "ggVG<cr>", desc = "Select all" },
                        -- lsp
                        ["gh"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Hover information" },
                },
                i = {
                        ["<C-l>"] = { "copilot#Accept('')", silent = true, expr = true, script = true },
                        ["<C-s>"] = { "<esc>:w<cr>:call feedkeys('a','n')<cr>" },
                },
                v = {
                        ["<C-s>"] = { "<esc>:w<cr>gv" },
                        ["<C-p>"] = { "\"_dP", desc = "Paste without yanking" }
                },
                t = {
                        -- setting a mapping to false will disable it
                        -- ["<esc>"] = false,
                },
        },

        -- Configure plugins
        plugins = {
                init = {
                        { "tpope/vim-surround" },
                        { "github/copilot.vim" },
                        { "psliwka/vim-smoothie" },
                        { "justinmk/vim-sneak" },
                },
                -- All other entries override the require("<key>").setup({...}) call for default plugins
                ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
                        config.sources = {
                                -- Set a formatter
                                -- null_ls.builtins.formatting.stylua,
                                -- null_ls.builtins.formatting.prettier,
                        }

                        return config -- return final config table
                end,
                treesitter = { -- overrides `require("treesitter").setup(...)`
                        -- ensure_installed = { "lua" },
                },
                -- use mason-lspconfig to configure LSP installations
                ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
                        -- ensure_installed = { "sumneko_lua" },
                },
                -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
                ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
                        -- ensure_installed = { "prettier", "stylua" },
                },
                ["neo-tree"] = {
                        filesystem = {
                                hijack_netrw_behavior = "open_default",
                        },
                        window = {
                                mappings = {
                                        custom_only = false,
                                        ["l"] = "open",
                                        ["h"] = "close_node",
                                },
                        },
                        default_component_configs = {
                               git_status = {
                                       symbols = {
                                               modified = '',
                                               untracked = '*',
                                       }
                               }
                        },
                        event_handlers = {}
                },
                ["gitsigns"] = {
                        current_line_blame = true,
                        current_line_blame_opts = {
                                virt_text = true,
                                virt_text_pos = 'eol',
                                delay = 0,
                                ignore_whitespace = false,
                        },
                },
                ["notify"] = {
                        on_open = function(win)
                                if vim.api.nvim_win_is_valid(win) then
                                        vim.api.nvim_win_set_config(win, { border = "single"})
                                end
                        end,
                        render = "simple"
                },
                ["which-key"] = {
                        icons = {
                                separator = "",
                        },
                        window = {
                                border = "none"
                        }
                }
        },

        -- LuaSnip Options
        luasnip = {
                -- Add paths for including more VS Code style snippets in luasnip
                vscode_snippet_paths = {},
                -- Extend filetypes
                filetype_extend = {
                        -- javascript = { "javascriptreact" },
                },
        },

        -- CMP Source Priorities
        -- modify here the priorities of default cmp sources
        -- higher value == higher priority
        -- The value can also be set to a boolean for disabling default sources:
        -- false == disabled
        -- true == 1000
        cmp = {
                source_priority = {
                        nvim_lsp = 1000,
                        luasnip = 750,
                        buffer = 500,
                        path = 250,
                },
        },

        -- Modify which-key registration (Use this with mappings table in the above.)
        ["which-key"] = {
                -- Add bindings which show up as group name
                register = {
                        -- first key is the mode, n == normal mode
                        n = {
                                -- second key is the prefix, <leader> prefixes
                                ["<leader>"] = {
                                        -- third key is the key to bring up next level and its displayed
                                        -- group name in which-key top level menu
                                        ["b"] = { name = "Buffer" },
                                },
                        },
                },
        },

        -- This function is run last and is a good place to configuring
        -- augroups/autocommands and custom filetypes also this just pure lua so
        -- anything that doesn't fit in the normal config locations above can go here
        polish = function()
                -- Set up custom filetypes
                -- vim.filetype.add {
                --   extension = {
                --     foo = "fooscript",
                --   },
                --   filename = {
                --     ["Foofile"] = "fooscript",
                --   },
                --   pattern = {
                --     ["~/%.config/foo/.*"] = "fooscript",
                --   },
                -- }
        end,
}

vim.cmd [[
        augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=100})
        augroup END
]]

vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
        command = 'silent! EslintFixAll',
})

return config
