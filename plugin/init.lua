
vim.diagnostic.config({ virtual_text = true })
local function isEmpty(line)
  return line == nil
end


-- Call norminette in the current file
local fileHandle
-- local pwd = vim.fn.getcwd()
local bufferHandle = vim.api.nvim_get_current_buf()
local currentBufferName = vim.api.nvim_buf_get_name(bufferHandle)

function Norm()
  -- Print Info
  local returnTable = {}
  fileHandle = assert(io.popen("norminette " .. currentBufferName, "r"))
  local index = 1
  repeat
    local line = fileHandle:read("*l")
    returnTable[index] = line -- Maybe need to check for empty lines to avod errors
    print(line)
    index = index + 1
  until (isEmpty(line))
  fileHandle:close()

  print(vim.inspect(returnTable))
  return returnTable
  -- fileHandle = assert(io.popen("norminette", "r"))
end


--[[
open_float({opts}, {...})                        *vim.diagnostic.open_float()*
vim.diagnostic.set()
                |vim.lsp.util.open_floating_preview()| in addition to the

A diagnostic is a Lua table with the following keys. Required keys are
indicated with (*):

    bufnr: Buffer number
    lnum(*): The starting line of the diagnostic
    end_lnum: The final line of the diagnostic
    col(*): The starting column of the diagnostic
    end_col: The final column of the diagnostic
    severity: The severity of the diagnostic |vim.diagnostic.severity|
    message(*): The diagnostic text
    source: The source of the diagnostic
    code: The diagnostic code
    user_data: Arbitrary data plugins or users can add

]]
