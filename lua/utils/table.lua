local M = {}

M.concat_table = function(t1, t2)
  for i = 1, #t2, 1 do
    t1[#t1 + 1] = t2[i]
  end
  return t1
end

M.join_tables = function(tbl1, tbl2)
  local new_tbl = {}
  for k, v in pairs(tbl1) do
    new_tbl[k] = v
  end
  for _, v in pairs(tbl2) do
    table.insert(new_tbl, v)
  end

  return new_tbl
end

local function tprint(tbl, indent)
  if not indent then
    indent = 0
  end
  local toprint = string.rep(" ", indent) .. "{\n"
  indent = indent + 2
  for k, v in pairs(tbl) do
    toprint = toprint .. string.rep(" ", indent)
    if type(k) == "number" then
      toprint = toprint .. "[" .. k .. "] = "
    elseif type(k) == "string" then
      toprint = toprint .. k .. "= "
    end
    if type(v) == "number" then
      toprint = toprint .. v .. ",\n"
    elseif type(v) == "string" then
      toprint = toprint .. '"' .. v .. '",\n'
    elseif type(v) == "table" then
      toprint = toprint .. tprint(v, indent + 2) .. ",\n"
    else
      toprint = toprint .. '"' .. tostring(v) .. '",\n'
    end
  end
  toprint = toprint .. string.rep(" ", indent - 2) .. "}"
  return toprint
end

M.print_table = function(node)
  local cache, stack, output = {}, {}, {}
  local depth = 1
  local output_str = "{\n"

  while true do
    local size = 0
    ---@diagnostic disable-next-line: unused-local
    for k, v in pairs(node) do -- luacheck: ignore
      size = size + 1
    end

    local cur_index = 1
    for k, v in pairs(node) do
      if (cache[node] == nil) or (cur_index >= cache[node]) then
        if string.find(output_str, "}", output_str:len()) then
          output_str = output_str .. ",\n"
        elseif not (string.find(output_str, "\n", output_str:len())) then
          output_str = output_str .. "\n"
        end

        -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
        table.insert(output, output_str)
        output_str = ""

        local key
        if type(k) == "number" or type(k) == "boolean" then
          key = "[" .. tostring(k) .. "]"
        else
          key = "['" .. tostring(k) .. "']"
        end

        if type(v) == "number" or type(v) == "boolean" then
          -- output_str = output_str .. string.rep("\t", depth) .. key .. " = " .. tostring(v)
          output_str = output_str .. string.rep("  ", depth) .. key .. " = " .. tostring(v)
        elseif type(v) == "table" then
          -- output_str = output_str .. string.rep("\t", depth) .. key .. " = {\n"
          output_str = output_str .. string.rep("  ", depth) .. key .. " = {\n"
          table.insert(stack, node)
          table.insert(stack, v)
          cache[node] = cur_index + 1
          break
        else
          -- output_str = output_str .. string.rep("\t", depth) .. key .. " = '" .. tostring(v) .. "'"
          output_str = output_str .. string.rep("  ", depth) .. key .. " = '" .. tostring(v) .. "'"
        end

        if cur_index == size then
          -- output_str = output_str .. "\n" .. string.rep("\t", depth - 1) .. "}"
          output_str = output_str .. "\n" .. string.rep("  ", depth - 1) .. "}"
        else
          output_str = output_str .. ","
        end
      else
        -- close the table
        if cur_index == size then
          -- output_str = output_str .. "\n" .. string.rep("\t", depth - 1) .. "}"
          output_str = output_str .. "\n" .. string.rep("  ", depth - 1) .. "}"
        end
      end

      cur_index = cur_index + 1
    end

    if size == 0 then
      -- output_str = output_str .. "\n" .. string.rep("\t", depth - 1) .. "}"
      output_str = output_str .. "\n" .. string.rep("  ", depth - 1) .. "}"
    end

    if #stack > 0 then
      node = stack[#stack]
      stack[#stack] = nil
      depth = cache[node] == nil and depth + 1 or depth - 1
    else
      break
    end
  end

  -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
  table.insert(output, output_str)
  output_str = table.concat(output)

  print(output_str)
end

return M
