------------------------------------------------------------------------------
-- 將選取的文字區域轉換成帶有 <p> 和 </p> 標籤的 HTML 內容
------------------------------------------------------------------------------
-- 將 convert_to_html 函數的定義添加到 init.lua
function _G.convert_to_html()
    -- 獲取選取的文字區域
    local line_start, line_end = unpack(vim.api.nvim_buf_get_mark(0, "<")), unpack(vim.api.nvim_buf_get_mark(0, ">"))

    -- 將選取的文字區域讀入到一個表格中
    local lines = vim.api.nvim_buf_get_lines(0, line_start - 1, line_end, false)

    -- 初始化變數，存放轉換後的 HTML 內容
    local html_lines = {}

    -- 在開始之前添加 <p> 標籤
    table.insert(html_lines, "<p>")

    -- 迭代選取的每一行文字
    for i, line in ipairs(lines) do
        -- 判斷是否為空行
        if line == "" then
            -- 如果上一行不為空，則添加 </p> 標籤
            if i > 1 and lines[i - 1] ~= "" then
                table.insert(html_lines, "</p>")
                -- 在 </p> 標籤後添加空白行
                table.insert(html_lines, "")
            end
            -- 如果下一行不為空，則添加 <p> 標籤
            if i < #lines and lines[i + 1] ~= "" then table.insert(html_lines, "<p>") end
        else
            -- 將非空行添加到 html_lines 中
            table.insert(html_lines, line)
        end
    end

    -- 在結束時添加 </p> 標籤
    table.insert(html_lines, "</p>")
    table.insert(html_lines, "")

    -- 將轉換後的 HTML 內容替換原來的文字區域
    vim.api.nvim_buf_set_lines(0, line_start - 1, line_end, false, html_lines)
end

-- 將 reorder_ordered_list 函數的定義添加到 init.lua
function _G.reorder_ordered_list()
    -- 獲取選取的文字區域
    local line_start, line_end = unpack(vim.api.nvim_buf_get_mark(0, "<")), unpack(vim.api.nvim_buf_get_mark(0, ">"))

    -- 將選取的文字區域讀入到一個表格中
    local lines = vim.api.nvim_buf_get_lines(0, line_start - 1, line_end, false)

    -- 初始化變數，存放重新排序後的有序列表項目
    local reordered_lines = {}

    -- 初始化列表項目編號
    local item_number = 1

    -- 迭代選取的每一行文字
    for _, line in ipairs(lines) do
        -- 使用正則表達式匹配有序列表項目
        if string.match(line, "^%s*%d+%..+") then
            -- 替換列表項目編號
            local new_line = string.gsub(line, "^%s*%d+%.", tostring(item_number) .. ".")
            table.insert(reordered_lines, new_line)

            -- 更新列表項目編號
            item_number = item_number + 1
        else
            -- 將未匹配的行保持原樣添加到 reordered_lines 中
            table.insert(reordered_lines, line)
        end
    end

    -- 將重新排序後的有序列表項目替換原來的文字區域
    vim.api.nvim_buf_set_lines(0, line_start - 1, line_end, false, reordered_lines)
end

-- 在 init.lua 中定義命令：執行 reorder_ordered_list 函數
vim.cmd("command! Reorder :lua _G.reorder_ordered_list()")
-- 在 init.lua 中定義命令：執行 convert_to_html 函數
vim.cmd("command! ConvertToHTML :lua _G.convert_to_html()")
