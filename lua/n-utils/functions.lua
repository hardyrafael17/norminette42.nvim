local M = {}

local isEnable = true

function M.isEmpty(s)
  return s == nil or s == ""
end

function M.trimString(s)
   if s == nil then
    return "nil"
  end
   return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function M.getErrors(index, maxErrorsToShow, error_message)
    if maxErrorsToShow == nil or index < (maxErrorsToShow + 2) then -- Plus 2 because indexing begins at 1, and the
      return error_message                                          -- first index is ommited, name of file
    else
      return nil
    end
  end

function M.parseError(errorList, bufferHandle, maxErrorsToShow)
  local diagnosticTable = {}
  for index, value in ipairs(errorList) do
    if index ~= 1 then
      local errorCode = M.trimString((string.sub(value, 8, 28))) or "Error getting error-code"
      local errorLine = tonumber(string.sub(value, 35, 38), 10) or 1
      local errorColumn  = tonumber(string.sub(value, 45, 48), 10) or 1
      local errorMessage = M.trimString((string.sub(value, 52))) or "Error getting error-message"
      table.insert(diagnosticTable, {
        bufnr = bufferHandle,
        message = M.getErrors(index, maxErrorsToShow, errorMessage),
        lnum = errorLine - 1,
        end_lnum = errorLine - 1,
        col = errorColumn - 1,
        end_col = errorColumn,
        severity = vim.diagnostic.severity.ERROR,
        source = "norminette",
        code = errorCode,
        user_data = {}
      })
    end
  end
  return diagnosticTable
end

function M.NorminetteDisable()
	isEnable = false
	vim.diagnostic.reset()
end

function M.NorminetteEnable(maxErrorsToShow)
	isEnable = true
	M.norminette42(maxErrorsToShow)
end

function M.norminette42(maxErrorsToShow)
	if not isEnable then
		return 
	end
  local bufferHandle = vim.api.nvim_get_current_buf()
  local currentBufferName = vim.api.nvim_buf_get_name(bufferHandle)
  local nameSpaceId = vim.api.nvim_create_namespace("42norme")
  local returnTable = {}
  local fileHandle = assert(io.popen("norminette " .. currentBufferName, "r"))
  local index = 1
  repeat
    local line = fileHandle:read("*l")
    returnTable[index] = line -- Maybe need to check for empty lines to avod errors
    index = index + 1
  until (M.isEmpty(line))
  fileHandle:close()
  local diagnostics = M.parseError(returnTable, bufferHandle, maxErrorsToShow)
  vim.diagnostic.set(nameSpaceId, bufferHandle, diagnostics, {virtual_text = true})
  vim.diagnostic.show(nameSpaceId, bufferHandle)
end

return M
