<!-- markdownlint-disable MD013 MD024 MD041 MD043 MD033 -->
# 設計規格

## 為 Ordered Lists 重編序號

Markdown 文檔，原有 Ordered Lists 項目如下：

1. First item
2. Second item
3. Third item
4. Fourth item

但在插入新行後，原有的編號順序會被打亂：

<!-- markdownlint-disable MD029 -->
1. First item
2. Lorem ipsum dolor sit amet consectetur
2. Second item
3. Third item
4. Fourth item
<!-- markdownlint-enable MD029 -->

### 【操作情境】

如下操作，可重調 Ordered Lists 編號。

1. 按 `V` 鍵；
2. 移動游標；
3. 按 `V` 鍵；（自此完成了，使用 V-LINE 選擇一個區段的文字）
4. 按 `:` 鍵，要求在 Command Line 輸入 Neovim 指令；
5. 輸入 `Reorder` ，按 Enter 鍵。

### 【設計細節】

1. Code 註譯使用繁體中文字；

2. 若需使用 Lua Global Function / Global Variable ，需於其前加 `_G.` （如： `_G.convert_to_html()` ），這是為了令 Lua Linter 不會認為程式碼撰寫不符合規範）
