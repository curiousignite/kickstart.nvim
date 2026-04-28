return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    {
      'kristijanhusak/vim-dadbod-completion',
      ft = { 'sql', 'mysql', 'plsql' },
      lazy = true,
    },
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_save_location = vim.fn.stdpath('config') .. '/db_ui'
  end,
  config = function()
    vim.keymap.set('n', '<leader>du', '<cmd>DBUI<CR>', { desc = 'Open DB UI' })
    vim.keymap.set('n', '<leader>dt', '<cmd>DBUIToggle<CR>', { desc = 'Toggle DB UI' })
    vim.keymap.set('n', '<leader>df', '<cmd>DBUIFindBuffer<CR>', { desc = 'Find DB UI Buffer' })
    vim.keymap.set('n', '<leader>dr', '<cmd>DBUIRenameBuffer<CR>', { desc = 'Rename DB UI Buffer' })
    vim.keymap.set('n', '<leader>dl', '<cmd>DBUILastQueryInfo<CR>', { desc = 'Last Query Info' })

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('DadbodSqlCompletion', { clear = true }),
      pattern = { 'sql', 'mysql', 'plsql' },
      callback = function()
        local ok, cmp = pcall(require, 'cmp')
        if not ok then
          return
        end

        cmp.setup.buffer({
          sources = cmp.config.sources({
            { name = 'vim-dadbod-completion' },
          }, {
            { name = 'buffer' },
          }),
        })
      end,
    })
  end,
}
