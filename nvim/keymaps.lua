vim.api.nvim_set_keymap('n', '<leader>+', ':resize +2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>-', ':resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>>', ':vertical resize +2<CR>', { noremap = true, silent = true })

-- Normal mode mappings
vim.api.nvim_set_keymap('n', '<C-Left>', 'b', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Right>', 'e', { noremap = true, silent = true })

-- Insert mode mappings
vim.api.nvim_set_keymap('i', '<C-Left>', '<C-o>b', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-Right>', '<C-o>e<C-o>l', { noremap = true, silent = true })
-- Add more keymaps here...
--
-- Un-indent the current line or selected lines in normal and visual mode
vim.api.nvim_set_keymap('n', '<S-Tab>', '<<', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<S-Tab>', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', '<C-D>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>lf', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })

-- require('which-key').add {
--   {
--     '<leader>lf',
--     function()
--       vim.diagnostic.open_float()
--     end,
--     '[L]sp [F]loat diagnostic',
--   },
-- }
