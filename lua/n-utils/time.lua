-- 
--

local M = {}

local functions = require("n-utils.functions")

function M.getCreatedAndModifiedTimes(currentFile)
  local error = "Error getting created and updated information, make sure file exist and is saved and try again"

  local awk = [[ | awk '{print substr($1,1,4)"/"substr($1,6,2)"/"substr($1,9,2)" "substr($2,1,8)}']]
  local stat = "stat -c %"

  local valuesTable = {}
  local fileHandle = assert(io.popen( stat.."w " .. currentFile .. awk, "r"))
  local fileHandle1= assert(io.popen( stat.."x " .. currentFile .. awk, "r"))
  local index = 1
  repeat
    local line = fileHandle:read("*l")
    if line then
      if string.len(line) == 19 then
        valuesTable.Created = line
      end
    end
    index = index + 1
  until (functions.isEmpty(line))

  repeat
    local line = fileHandle1:read("*l")
    if line then
      if string.len(line) == 19 then
        valuesTable.Updated = line
      end
    end
    index = index + 1
  until (functions.isEmpty(line))
  fileHandle1:close()

  if not valuesTable.Created or not valuesTable.Updated then
    return false, error
  elseif string.len(valuesTable.Created) ~= 19 and string.len(valuesTable.Updated) ~= 19 then
    return false, error
  end
  return true, valuesTable.Created, valuesTable.Updated
end

return M
