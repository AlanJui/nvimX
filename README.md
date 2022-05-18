# 專案指引

## 摘要

自 Neovim 7 發行後，各套件開發者為配合其新功能特性，多有變更；或因某些
因素考量更改了原設計。

然上述 Neovim 套件的變更，卻導致原本植基於 Neovim 5 配置的 my-nvim ，
經常無法正常作業，問題多多。為圖「除錯」，故而啟動本專案。

本專案基本上是【my-nvim 專案】之精簡版，其主要特性如下：

 - 為求除錯能精準有效，原先 my-nvim 在啟動後，會變更 Neovim 在 config, runtime 
 環境設定的設計，本專案不再延用，以免因對 Neovim Runtime 作業的掌握度不夠
 致使意外發生；

 - 所有之配置設定（configuration），以 Neovim 7 為目標；

 - 為避免配置設定散落各地，故將： lsp-installer, lspconfig, nvim-cmp, luasnip 
 視為一整組，相關設定均採 Lua Script 撰寫，並置於 <Nvim>/lua/lsp/ 路徑處。


## 參考

 - [my-nvim 專案](https://github.com/AlanJui/my-nvim)：為本專案之「前世」。

 - [mini-nvim 專案](https://github.com/AlanJui/mini-nvim)：此專案提供 LSP 除錯
 時，Neovim 可運作正常作業的最 mini 設定。 
