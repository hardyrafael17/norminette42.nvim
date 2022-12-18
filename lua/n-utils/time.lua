-- 
--

local M = {}

local functions = require("n-utils.functions")

function M.getCreatedAndModifiedTimes(currentFile)
  local error = "Error getting created and updated information, make sure file exist and is saved and try again"
  local osCommand = "stat -x -t %Y/%m/%d\\ %H:%M:%S "
  local valuesTable = {}
  local fileHandle = assert(io.popen( osCommand .. currentFile, "r"))
  local index = 1
  repeat
    local line = fileHandle:read("*l")
    if line then
      if string.find(line, "Birth") then
        valuesTable.Created = string.sub(line, 9)
      elseif string.find(line, "Change") then
        valuesTable.Updated = string.sub(line, 9)
      end
    end
    index = index + 1
  until (functions.isEmpty(line))
  fileHandle:close()
  if not valuesTable.Created or not valuesTable.Updated then
    return false, error
  elseif string.len(valuesTable.Created) ~= 19 and string.len(valuesTable.Updated) ~= 19 then
    return false, error
  end
  return true, valuesTable.Created, valuesTable.Updated
end

return M
