return {
    "williamboman/mason-lspconfig.nvim", 
    lazy = false,
    dependencies = {
        "neovim/nvim-lspconfig",
        "folke/tokyonight.nvim",
        "williamboman/mason.nvim", 
--|        "folke/lsp-colors.nvim",
        "mfussenegger/nvim-lint",
    },
    config = function()
        local servers = {
            ansiblels = {},
            bashls = {},
            cssls = {},
            dockerls = {},
            docker_compose_language_service = {},
            html = {},
            jsonls = {},
            tsserver = {},
            --jqls = {},
            lua_ls = {},
            intelephense = {},
            --pyright = {},
            --pylyzer = {},
            --pylsp = {},
            --ruff_lsp = {},
            --sqlls = {},
            taplo = {},
            svelte = {},
            typst_lsp = {
                Typst = {
                    exportPdf = "onSave",
                }
            }
        }
        require("mason").setup({
            ui = {
                border = "none",
                icons = {
                    package_installed = "◍",
                    package_pending = "◍",
                    package_uninstalled = "◍",
                },
            },
            log_level = vim.log.levels.INFO,
            max_concurrent_installers = 4,
        })
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require("cmp_nvim_lsp").default_capabilities()

        local mason_lspconfig = require("mason-lspconfig")
        mason_lspconfig.setup({
            ensure_installed = vim.tbl_keys(servers),
        })
        local handlers = {
            ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        }

      require("tokyonight").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  light_style = "day", -- The theme is used when the background is set to light
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors) end,
})

        mason_lspconfig.setup_handlers {
            function(server_name)
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                    bundle_path = (servers[server_name] or {}).bundle_path,
                    root_dir = function()
                        return vim.loop.cwd()
                    end,
                    handlers = handlers
                }
            end,
        }
        require('lint').linters_by_ft = {
            python = { 'golangcilint', 'flake8', 'ruff' },
            typescript = { 'eslint' },
        }
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end
}

