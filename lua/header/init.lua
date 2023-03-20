local M = {}

function M.isLengthValid(string, section)
  if string.len(string) <= 79 then
    return true
  else
    return false, section .. " is too long and won't fit in the header"
  end
end

function M.Header()

  local header42 = {
  "/* ************************************************************************** */",
  "/*                                                                            */",
  "/*                                                        :::      ::::::::   */",
  "/*   key_update_game.c                                  :+:      :+:    :+:   */",
  "/*                                                    +:+ +:+         +:+     */",
  "/*   By: hjimenez <hjimenez@student.42.fr>          +#+  +:+       +#+        */",
  "/*                                                +#+#+#+#+#+   +#+           */",
  "/*   Created: 2022/11/24 03:00:11 by hjimenez          #+#    #+#             */",
  "/*   Updated: 2022/11/24 03:02:51 by hjimenez         ###   ########.fr       */",
  "/*                                                                            */",
  "/* ************************************************************************** */",
}

  local bufferHandle = vim.api.nvim_get_current_buf()
  -- Create line four
  local currentFileName = vim.fn.expand("%")
  currentFileName = currentFileName:match( "([^/]+)$" )
  if not currentFileName then
    return false, "Error parsing file name"
  end
  local line_4_1 = "/*   "
  local line_4_2 = currentFileName
  local line_4_3 = ""
  local line_4_4 = ":+:      :+:    :+:   */"

  local ok, error = M.isLengthValid(line_4_1 .. line_4_2 .. line_4_3 .. line_4_4, "file name")
  if not ok then
    return false, error
  end
  repeat
   line_4_3 = line_4_3 .. " "
   local total_length = string.len(line_4_1) + string.len(line_4_2) + string.len(line_4_3)
   total_length = total_length + string.len(line_4_4)
  until (total_length == 80)

  -- Create line six
  local fileHandle = assert(io.popen("git config user.email", "r"))
  local gitUserEmail = fileHandle:read("*l")
  fileHandle:close()
  local line_6_2
  local local_part
  local domain_part

  ok, local_part, domain_part = require("n-utils.email").getEmailComponents(gitUserEmail)
  if ok then
    local full_email = " <" .. local_part .. '@' .. domain_part .. ">"
    line_6_2 =  local_part .. full_email
  else
    error = "Error parsing email, make sure you have your git user.email configured and that it is short haha"
    print(error)
    return false, error
  end
  local line_6_1 = "/*   By: "
  local line_6_3 = ""
  local line_6_4 = "+#+  +:+       +#+        */"

  ok, error = M.isLengthValid(line_6_1 .. line_6_2 .. line_6_3 .. line_6_4, "email")
  if not ok then
    return false, error
  end

  repeat
   line_6_3 = line_6_3 .. " "
   local total_length = string.len(line_6_1) + string.len(line_6_2) + string.len(line_6_3)
   total_length = total_length + string.len(line_6_4)
  until (total_length == 80)

  local currentBufferName = vim.api.nvim_buf_get_name(bufferHandle)
  local status, createdOrError, updated = require("n-utils.time").getCreatedAndModifiedTimes(currentBufferName)
  if not status then
	  print(createdOrError)
	  print"returning"
    return createdOrError
  end

  -- Create line 8
  local line_8_1 = "/*   Created: "
  local line_8_2 = createdOrError .. " by " .. local_part
  local line_8_3 = ""
  local line_8_4 = "#+#    #+#             */"

  repeat
    local total_length
    line_8_3 = line_8_3 .. " "
    total_length = string.len(line_8_1) + string.len(line_8_2) + string.len(line_8_3) + string.len(line_8_4)
  until ( total_length == 80)

  local line_9_1 = "/*   Updated: "
  local line_9_2 = updated .. " by " .. local_part
  local line_9_3 = ""
  local line_9_4 = "###   ########.fr       */"

  repeat
    local total_length
    line_9_3 = line_9_3 .. " "
    total_length = string.len(line_9_1) + string.len(line_9_2) + string.len(line_9_3) + string.len(line_9_4)
  until ( total_length == 80)

  -- Append lines to header
  header42[4] = line_4_1 .. line_4_2 .. line_4_3 .. line_4_4
  header42[6] = line_6_1 .. line_6_2 .. line_6_3 .. line_6_4
  header42[8] = line_8_1 .. line_8_2 .. line_8_3 .. line_8_4
  header42[9] = line_9_1 .. line_9_2 .. line_9_3 .. line_9_4

  -- Check if we have a current header
  local headerCommentCount = 0
  local is42Header = false
  local headerLines = vim.api.nvim_buf_get_lines(bufferHandle, 0, 11, false)

  for _, line in ipairs(headerLines) do
    if string.find(line, "/* ") then
      headerCommentCount = headerCommentCount + 1
    end
  end
  if headerCommentCount == 11 then
    is42Header = true
  end

  -- If we have a header, then delete it
  if is42Header then
      vim.api.nvim_buf_set_lines(bufferHandle, 0, 11, false, {})
  end

  -- Insert header
  for index, _ in ipairs(header42) do
    vim.api.nvim_buf_set_lines(bufferHandle, index - 1, index -1, false, {header42[index]})
  end

end
return M
