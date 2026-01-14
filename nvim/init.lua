-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Set tab width to 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

require 'keymaps' -- add my keybinds

vim.api.nvim_set_keymap('n', '<leader>ph', ':split<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>pv', ':vsplit<CR>', { noremap = true, silent = true })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  --'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  { --syntax highlighting for php blade
    'jwalton512/vim-blade',
    ft = 'blade', -- Load only for Blade files
  },

  {
    'vim-scripts/DoxygenToolkit.vim',
    config = function()
      vim.g.DoxygenToolkit_authorName = 'Tomás Ibaceta'
      vim.g.DoxygenToolkit_licenseTag = 'All Rights Reserved'
    end,
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup {
        icons = {
          -- set icon mappings to true if you have a Nerd Font
          mappings = vim.g.have_nerd_font,
          -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
          -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
          keys = vim.g.have_nerd_font and {} or {
            Up = '<Up> ',
            Down = '<Down> ',
            Left = '<Left> ',
            Right = '<Right> ',
            C = '<C-…> ',
            M = '<M-…> ',
            D = '<D-…> ',
            S = '<S-…> ',
            CR = '<CR> ',
            Esc = '<Esc> ',
            ScrollWheelDown = '<ScrollWheelDown> ',
            ScrollWheelUp = '<ScrollWheelUp> ',
            NL = '<NL> ',
            BS = '<BS> ',
            Space = '<Space> ',
            Tab = '<Tab> ',
            F1 = '<F1>',
            F2 = '<F2>',
            F3 = '<F3>',
            F4 = '<F4>',
            F5 = '<F5>',
            F6 = '<F6>',
            F7 = '<F7>',
            F8 = '<F8>',
            F9 = '<F9>',
            F10 = '<F10>',
            F11 = '<F11>',
            F12 = '<F12>',
          },
        },
      }

      -- Document existing key chains
      require('which-key').add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      }
    end,
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        pickers = {
          lsp_document_symbols = {
            symbol_sort = false,
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })

      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sF', function()
        builtin.find_files {
          hidden = true,
          no_ignore = true,
          no_ignore_parent = true,
        }
      end, { desc = '[S]earch [F]iles (all)' })

      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })

      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sG', function()
        builtin.live_grep {
          additional_args = function()
            return { '--hidden', '--no-ignore', '--no-ignore-parent' }
          end,
        }
      end, { desc = '[S]earch by [G]rep (all files)' })

      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
      require('nvim-tree').setup {
        filters = {
          dotfiles = false, -- Set this to `false` to show hidden files
        },
      }
    end,
  },

  {
    'ThePrimeagen/harpoon',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('harpoon').setup {}
    end,
  },

  {
    'kylechui/nvim-surround',
    version = '*', -- For stability; remove this line for the latest version
    config = function()
      require('nvim-surround').setup {
        surrounds = {
          ['['] = { add = { '[', ']' } }, -- No spaces for square brackets
          ['('] = { add = { '(', ')' } }, -- No spaces for parentheses
          ['{'] = { add = { '{', '}' } }, -- No spaces for curly brackets
        },
      }
    end,
  },

  {
    'stevearc/aerial.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-lspconfig' },
    config = function()
      require('aerial').setup {
        layout = {
          default_direction = 'prefer_right', -- or "prefer_left"
          placement = 'window', -- ensures it's a regular split, not a float
        },
      }
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- This is where you add the new keybinding for function references
          map('<leader>gr', function()
            require('telescope.builtin').lsp_references {
              layout_strategy = 'vertical',
              layout_config = { width = 0.8 },
              show_line = true,
            }
          end, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        clangd = {
          cmd = { 'clangd', '--enable-config', '--completion-style=detailed', '--header-insertion=never', '--query-driver=/usr/bin/arm-none-eabi-gcc' },
        },
        gopls = {},

        -- tsserver = {},
        ts_ls = {},
        tailwindcss = {},
        eslint = {},

        -- HTML support (needed for HTML blocks inside JSX)
        --html = {
        --  filetypes = { 'html', 'htm', 'javascriptreact', 'typescriptreact' },
        --},

        intelephense = {
          filetypes = { 'php' },
        },

        html = {
          filetypes = { 'html', 'htm', 'blade' },
          init_options = {
            provideFormatter = true, -- Enable formatting
          },
        },

        -- Vue + Blade (if the project uses Vue components)
        volar = {
          filetypes = { 'vue', 'blade', 'javascript', 'typescript' },
        },

        -- Emmet for HTML-like syntax in React components
        emmet_ls = {
          filetypes = { 'html', 'css', 'javascriptreact', 'typescriptreact', 'blade' },
        },

        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = 'basic', -- Change to "basic" or "off"
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'workspace',
                venv = '.venv',
              },
            },
          },
        },
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = false, cpp = false }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        c = { 'clang_format' },
        cpp = { 'clang_format' },
        python = { 'black' },
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
              require('luasnip.loaders.from_vscode').lazy_load {
                -- paths = { '~/.config/nvim/snippets' }, -- Add your custom snippets directory here
                -- paths = { vim.fn.expand '~/.config/nvim/snippets' },
                paths = { vim.fn.expand '/home/zeta/.config/nvim/snippets' },
              }
              --require('luasnip').filetype_extend('all', { '_' })
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          --          ['<C-l>'] = cmp.mapping(function(fallback)
          --            if luasnip.expand_or_locally_jumpable() then
          --              luasnip.expand_or_jump()
          --            else
          --              fallback()
          --            end
          --          end, { 'i', 's' }),
          --
          --          ['<C-h>'] = cmp.mapping(function(fallback)
          --            if luasnip.locally_jumpable(-1) then
          --              luasnip.jump(-1)
          --            else
          --              fallback()
          --            end
          --          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          {
            name = 'lazydev',
            -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
            group_index = 0,
          },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  --  -- ---------- add pydoc generation with neogen ---------
  -- didn't work, who knows why
  --  {
  --    'danymat/neogen',
  --    dependencies = 'nvim-treesitter/nvim-treesitter',
  --    config = function()
  --      require('neogen').setup {
  --        enabled = true,
  --        snippet_engine = 'luasnip',
  --        languages = {
  --          python = {
  --            template = {
  --              annotation_convention = 'google',
  --            },
  --          },
  --        },
  --        default_template_type = 'google', -- Force default template type
  --      }
  --      vim.keymap.set('n', '<Leader>pp', ':Neogen<CR>', { noremap = true, silent = true })
  --    end,
  --  },

  {
    'heavenshell/vim-pydocstring',
    enabled = false,
    build = 'make install', -- Installs dependencies
    config = function()
      vim.g.pydocstring_doq_path = 'pydocstring' -- Ensure it's using the installed package
      vim.g.pydocstring_formatter = 'google' -- Set Google-style docstrings
      vim.g.pydocstring_doq_path = 'doq'
      vim.api.nvim_set_keymap('n', '<Leader>pp', ':Pydocstring<CR>', { noremap = true, silent = true })
    end,
  },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- My Keybinds

-- Switch from .c and .h
vim.api.nvim_set_keymap(
  'n',
  '<leader>gh',
  ':lua require("telescope.builtin").find_files({search_dirs = {vim.fn.expand("%:p:h")}, prompt_title = "Switch Between .c and .h", find_command = {"fd", "-e", "c", "-e", "h", vim.fn.expand("%:t:r")}})<CR>',
  { noremap = true, silent = true }
)

-- My own functions
--
-- Function to open CMakeLists.txt in the same directory as the current file
function open_cmake_lists()
  -- Get the full path of the current file
  local current_file = vim.api.nvim_buf_get_name(0)
  -- Get the directory of the current file
  local dir = vim.fn.fnamemodify(current_file, ':p:h')
  -- Construct the path to the CMakeLists.txt file
  local cmake_file = dir .. '/CMakeLists.txt'

  -- Check if the CMakeLists.txt file exists
  if vim.fn.filereadable(cmake_file) == 1 then
    -- Open the CMakeLists.txt file
    vim.cmd('edit ' .. cmake_file)
  else
    -- Print a message if the file does not exist
    print('CMakeLists.txt not found in ' .. dir)
  end
end

-- Map the function to <leader>gc
vim.api.nvim_set_keymap('n', '<leader>gc', '<cmd>lua open_cmake_lists()<CR>', { noremap = true, silent = true })

function ToggleSourceHeader()
  local filepath = vim.fn.expand '%:p'
  local extension = vim.fn.expand '%:e'
  local counterpart

  if extension == 'c' then
    counterpart = filepath:gsub('%.c$', '.h')
  elseif extension == 'cpp' then
    counterpart = filepath:gsub('%.cpp$', '.h')
  elseif extension == 'h' then
    counterpart = filepath:gsub('%.h$', '.c')
    if not vim.fn.filereadable(counterpart) then
      counterpart = filepath:gsub('%.h$', '.cpp')
    end
  else
    print 'Not a C/C++ file'
    return {
      'jwalton512/vim-blade',
      ft = 'blade',
    }
  end

  if vim.fn.filereadable(counterpart) == 1 then
    vim.cmd('edit ' .. counterpart)
  else
    print 'No corresponding file found'
  end
end

vim.api.nvim_set_keymap('n', '<leader>gh', [[:lua ToggleSourceHeader()<CR>]], { noremap = true, silent = true })

-- Get the parent folder of whatever is in my yanked register

function YankCorrectParentFolderFromYankedFilename()
  -- Get the yanked content (filename)
  local filename = vim.fn.getreg '"'
  print('Yanked content: ' .. filename)

  -- Resolve the full path using the current working directory
  local full_path = vim.fn.findfile(filename, vim.fn.getcwd() .. '/**')
  print('Resolved path: ' .. full_path)

  -- If the file was found, continue to find the parent folder
  if full_path and full_path ~= '' then
    -- Get the immediate parent directory name
    local foldername = vim.fn.fnamemodify(full_path, ':h:t')
    print('Parent folder name: ' .. foldername)

    -- Set the folder name into the clipboard
    vim.fn.setreg('"', foldername)

    -- Print a message to confirm
    print('Yanked folder: ' .. foldername)
  else
    print('File not found: ' .. filename)
  end
end

function YankParentFolderWithLimitedScope()
  -- Get the yanked content (filename)
  local filename = vim.fn.getreg '"'
  print('Yanked content: ' .. filename)

  -- Start searching from the directory of the current file
  local start_dir = vim.fn.expand '%:p:h'
  print('Starting directory: ' .. start_dir)

  local search_depth = 4 -- Number of parent directories to search up
  local current_dir = start_dir
  local full_path = nil

  for _ = 1, search_depth do
    -- Perform the search in the current directory
    full_path = vim.fn.findfile(filename, current_dir .. '/**')
    if full_path ~= '' then
      break
    end
    -- Move up one directory level
    current_dir = vim.fn.fnamemodify(current_dir, ':h')
    print('Moving to parent directory: ' .. current_dir)
  end

  if full_path and full_path ~= '' then
    -- Get the immediate parent directory name
    local foldername = vim.fn.fnamemodify(full_path, ':h:t')
    print('Parent folder name: ' .. foldername)

    -- Set the folder name into the clipboard
    vim.fn.setreg('"', foldername)

    -- Print a message to confirm
    print('Yanked folder: ' .. foldername)
  else
    print('File not found: ' .. filename)
  end
end

vim.api.nvim_set_keymap('n', '<leader>yf', ':lua YankParentFolderWithLimitedScope()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>yf', ':lua YankCorrectParentFolderFromYankedFilename()<CR>', { noremap = true, silent = true })

-- Harpoon Keymap

-- Add the current file to Harpoon
vim.api.nvim_set_keymap('n', '<leader>ha', ':lua require("harpoon.mark").add_file()<CR>', { noremap = true, silent = true })

-- Open Harpoon UI
vim.api.nvim_set_keymap('n', '<leader>hh', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true, silent = true })

-- Navigate to next and previous Harpoon marks
vim.api.nvim_set_keymap('n', '<leader>hn', ':lua require("harpoon.ui").nav_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>hp', ':lua require("harpoon.ui").nav_prev()<CR>', { noremap = true, silent = true })

-- Save the current file to a specific Harpoon slot
vim.api.nvim_set_keymap('n', '<leader>hs1', ':lua require("harpoon.mark").set_current_at(1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>hs2', ':lua require("harpoon.mark").set_current_at(2)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>hs3', ':lua require("harpoon.mark").set_current_at(3)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>hs4', ':lua require("harpoon.mark").set_current_at(4)<CR>', { noremap = true, silent = true })

-- Navigate to Harpoon marks
vim.api.nvim_set_keymap('n', '<leader>h1', ':lua require("harpoon.ui").nav_file(1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h2', ':lua require("harpoon.ui").nav_file(2)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h3', ':lua require("harpoon.ui").nav_file(3)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h4', ':lua require("harpoon.ui").nav_file(4)<CR>', { noremap = true, silent = true })

-- Toggle nvim-tree with <leader>e
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- For Normal mode "Alt+," to act as "f,"
vim.keymap.set({ 'n', 'i' }, '<A-,>', function()
  vim.cmd 'normal! f,'
end, { noremap = true, silent = true, desc = 'Move to next comma' })

-- For Normal mode "Shift+Alt+," to act as "F,"
vim.keymap.set({ 'n', 'i' }, '<A-;>', function()
  vim.cmd 'normal! F,'
end, { noremap = true, silent = true, desc = 'Move to previous comma' })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
vim.opt.modeline = false
--
-- my settings for tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

require('nvim-autopairs').setup {
  disable_filetype = { 'TelescopePrompt', 'vim' },
  fast_wrap = {
    map = '<M-e>', -- Alt+e is the default key to trigger fast wrap
    chars = { '{', '[', '(', '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
    offset = 0, -- Cursor position offset after wrapping
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl', -- Keys used for quick wrapping
    check_comma = true,
    highlight = 'Search',
    highlight_grey = 'Comment',
  },
}

vim.lsp.set_log_level 'debug'

-- ---------- Creating a Tiling Window with the function first line ---------
local api = vim.api

function ToggleFunctionSignature()
  -- If the window is already open, close it
  if _G.function_signature_win and api.nvim_win_is_valid(_G.function_signature_win) then
    api.nvim_win_close(_G.function_signature_win, true)
    _G.function_signature_win = nil
    --print 'Function signature window closed'
    return
  end

  -- Otherwise, show the function signature
  local ts_utils = require 'nvim-treesitter.ts_utils'
  local node = ts_utils.get_node_at_cursor()

  -- Check if we found a valid node
  if not node then
    --print 'No node found'
    return
  end

  -- Traverse upwards to find the function definition
  while node do
    if node:type() == 'function_definition' then
      -- Get the start of the function
      local start_row, _, _, _ = node:range()
      local func_signature = vim.api.nvim_buf_get_lines(0, start_row, start_row + 1, false)[1]

      -- Create a floating window to show the function signature
      local win_opts = {
        relative = 'editor',
        width = #func_signature + 2,
        height = 1,
        row = 1, -- Top of the editor
        col = 1, -- Left side of the editor
        style = 'minimal',
        border = 'single',
      }

      -- Create the buffer and window
      local buf = api.nvim_create_buf(false, true)
      api.nvim_buf_set_lines(buf, 0, -1, false, { func_signature })
      _G.function_signature_win = api.nvim_open_win(buf, false, win_opts)
      --print 'Function signature window opened'
      return
    end
    node = node:parent()
  end
end

-- Map the toggle function to a key, e.g., <leader>f
vim.api.nvim_set_keymap('n', '<leader>of', ':lua ToggleFunctionSignature()<CR>', { noremap = true, silent = true })

-- ---------- copy the relative path to the file i'm currently watching ---------

-- Function to copy the relative path of the current file to clipboard
vim.keymap.set('n', '<leader>yp', function()
  -- Get the relative path of the current file
  local relative_path = vim.fn.expand '%'
  if relative_path == '' then
    print 'No file is currently open!'
    return
  end

  -- Copy to the system clipboard
  vim.fn.setreg('+', relative_path)

  -- Print a message to confirm
  print('Copied to clipboard: ' .. relative_path)
end, { desc = 'Copy relative path to clipboard' })

-- ---------- toggle "view ignored files"---------
-- this is good to open .envs, for example.
vim.keymap.set('n', '<leader>tg', function()
  require('nvim-tree.api').tree.toggle_gitignore_filter()
  print 'Toggled .gitignore filter'
end, { desc = 'Toggle .gitignore filter in NvimTree' })

-- run black on current file
vim.api.nvim_set_keymap('n', '<Leader>fb', ':!black #<CR>', { noremap = true, silent = true })

-- next method (python nav)
--
--
--aerial sidebar

vim.keymap.set('n', '<leader>oo', '<cmd>AerialToggle!<CR>', { desc = 'Toggle Aerial outline' })

-- ---------- log level ---------- **/
vim.lsp.set_log_level 'WARN' --not too big or it will eat disk

-- -------- debug as ipython -----
vim.keymap.set('n', '<leader>dp', function()
  local file = vim.fn.expand '%:p' -- full path of the file
  local line = vim.fn.line '.' -- current line number
  local win_name = 'ipython_debug_' .. tostring(os.time()) -- unique name

  -- Step 1: Create a new named tmux window and switch to it
  local create_and_select = string.format([[tmux new-window -n %s "source .venv/bin/activate && bash -i"]], win_name)
  vim.fn.system(create_and_select)

  -- Step 2: Send keys to the new window (now current)
  local debug_cmd = string.format([[tmux send-keys -t %s 'ipython' C-m '%%run -d %s' C-m 'b %d' C-m 'c' C-m]], win_name, file, line)
  vim.fn.system(debug_cmd)
end, { desc = 'Open tmux window and debug with IPython' })

-- ---------- format clang-format ---------- --

vim.keymap.set('n', '<leader>fc', function()
  local filename = vim.api.nvim_buf_get_name(0)
  if filename:match '%.c$' or filename:match '%.h$' then
    vim.cmd 'write' -- Save file before formatting
    vim.cmd('!clang-format -i ' .. filename)
    vim.cmd 'edit' -- Reload buffer after formatting
  else
    print 'Not a .c or .h file — skipping clang-format'
  end
end, { noremap = true, silent = true, desc = 'Clang-format current file' })

-- -------- sorround script -------
return {
  'kylechui/nvim-surround',
  version = '*',
  config = function()
    require('nvim-surround').setup()
  end,
}
