local M = {}

M.setup = function(opts)
  opts.active = opts.active or true
  if not opts.active then
    return
  end

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

  -- Insert or replace current header if it exist
  function Norminette42Header()
    local ok, header = pcall(require, "header")
    if not ok then
      return false
    end
    header.Header()
  end

end

return M
