local M = {}

M.setup = function(opts)
  vim.api.nvim_create_user_command('Norminette42', 'lua Norminette42()', {})

  opts.runOnSave = opts.runOnSave or false
  opts.email42 = opts.email42 or nil -- Todo
  opts.username42 = opts.username42 or nil -- Todo

  GlobalNorminetteFunctions = require("n-utils.functions")

  vim.api.nvim_create_user_command('Header42', 'lua Norminette42Header()', {})

  local myluafunc = function ()
    return GlobalNorminetteFunctions.norminette42(opts.maxErrorsToShow)
  end

-- Check on buffer enter
  vim.api.nvim_create_autocmd({"BufEnter"}, {
    pattern = { "*.c", "*.h" },
    callback = myluafunc
  })

-- Check on save
  if opts.runOnSave then
    vim.api.nvim_create_autocmd({"BufWritePost"}, {
    pattern = { "*.c", "*.h" },
    callback = myluafunc
  })
  end

  function Norminette42Header()
    local ok, header = pcall(require, "header")
    if not ok then
      print("failed to load 42Header module")
      return false
    end
    header.Header()
  end

end

return M
