# 專案指引

## 專案簡介

Neovim 0.5 的發行，將它推進到一個新的里程碑。打造滿足自己需求、符合個人操作習慣
的編輯器，因著 Neovim 0.5 支援 LSP 及 Lua Script 特性，令懷抱著夢想的人們，
有機會美夢成真。

【附註】：[Neovim Language Server Protocol (LSP) 主要功能列表：](https://neovim.io/doc/lsp/)

- Go to definition：定義跳轉
- (auto)completion：自動補全
- Code Actions (automatic formatting, organize imports, ...)：程式碼操作，如：
  自動調整排版、組識 import 順序...等
- Show method signatures：顯示用法
- Show/go to references：顯示/跳轉引用處
- snippets：程式碼片段

### 專案需求

本專案為：「符合個人應用需求的編輯器打造計畫」。為檢驗計畫是否達成，設定之
專案目標如下：

能支援 Django App 開發作業的需求。

開發作業的需求，細分詳述如下：

- 程式編碼可透過自動補全，加快輸入及避免打字錯誤
- 程式碼在呼叫某 method/function 時，能「顯示用法」，提示該輸入的引數順序，
  及應使用的資料類型（Data Type）
- 可使用 snippets ，加速編碼工作及避免打字錯誤
- 原先在 VS Code 已建置的 Snippets ，能於 Neovim 環境套用
- 自動檢查程式碼，確保沒有語法的錯誤
- 程式碼已被檢查到的錯誤，可提示：「統計總數」、「標示位置」
- 適用於 Django 開發專案
- 能依據語法標準（如：autopep8），自動調整程式碼的排版格式
- 可編輯及預覽 Markdown 文件，以便可以與 VuePress 整合，作為「技術文件」編輯器
- 可使用如 PlantUML 的工具，以文字描述，繪製 UML 圖形（Diagrams）
- 可以透過 [DAP](https://alpha2phi.medium.com/neovim-dap-enhanced-ebc730ff498b)
  與 Neovim 整合，讓 Neovim 可像 VS Code 一樣，當作除錯（Debug）工具來使用

### 環境需求

Neovim 在執行時期，啟動作業需讀取的設定檔；安裝／更新：擴充套件（Plugins）、
LSP Servers 時，其存取的「目錄」預設如下：

- 設定（Configuration）存放目錄路徑： `~/.config/nvim/`
- 執行（Runtime）存放目錄路徑： `~/.local/share/nvim/`
- 插件存放目錄路徑： `~/.local/share/nvim/site/pack/packer/start/`

上述之目錄路徑，為 Neovim 的 RTP (Run Time Path) 預設值。

打造個人專屬的編輯器，其過程免不了得：參考別人作品及實作驗證。經此過程，
才能深入了解自己在應用的需求，並逐漸培養出自身在客製化時應具備之技能。

所以，理論上：在我們的電腦中，至少要能安裝兩套以上的 Neovim ，一套供自己
每日使用；另一套則存放正在實作驗證的半成品；甚至在加上第三套：某高手的參考
作品。

- 在目錄： ~/.config/nvim ，放置「可正常作業的 Neovim」；
- 在目錄： ~/.config/my-nvim ，放置「試驗用之 Neovim」；
- 在目錄： ~/.config/my-nvim2 ，放置「高手 X 的 Neovim 作品」；
- 在目錄： ~/.config/my-nvim3 ，放置「高手 Y 的 Neovim 作品」。

綜合上述，可得 Neovim 的應用需求：在一台電腦中，可依「目錄」區隔 Neovim
的作業環境(RTP)，彼此均可獨立運作，不會相互干擾。

## 前置基礎（Prerequisites）

使用 Neovim 之前，請先完成下列套件、執行環境的安裝及設定。個人慣用的安裝作業
程序，均有標示文件的「連結」網址，提供給有需要的朋友參考。

上述的安裝操作文件，因為原屬個人用的《備忘錄》，所以，其排版格式及遣詞用字，未必
完美；另外，適用的作業系統僅止於：（1）Manjaro (ArchLinux)、(2) Ubuntu 20.04、
(3) macOS 11.6 。

- 完成 [Neovim] (<https://alanjui.github.io/my-dev-env/nvim/#%E5%AE%89%E8%A3%9D%E8%88%87%E6%93%8D%E4%BD%9C>) 套件的安裝
- 完成 [Python](https://alanjui.github.io/my-docs/python.html#install-python-tools) 開發環境的安裝
- 完成 [Node.js](https://alanjui.github.io/my-docs/nodejs.html#%E5%AE%89%E8%A3%9D%E8%88%87%E8%A8%AD%E5%AE%9A) 開發環境的安裝（因為諸多的 Langage Server 均是以 Node.js 來運作）
- 完成 [Lua](https://alanjui.github.io/my-docs/lua.html#building-lua) 開發環境及 [Lua Langage Server](https://alanjui.github.io/my-docs/lua.html#install-lua-support-for-vim-neovim) 的安裝

## 安裝與設定作業（Setup process）

### 1. 下載（Download）

```sh
git clone git@github.com:AlanJui/nvimX.git ~/.config/nvim
```

### 2. 安裝插件（Install plugins）

本專案使用 packer.nvim 作為 Neovim 的「插件管理工具」。nvim 會在 Neovim
啟動的時候，檢查 packer.nvim 是否已存在；並於必要的時候後，自動執行安裝作業。
另外，nvim 使用到的各種插件，也會由 packer.nvim 自動進行安裝。

(1) 安裝執行檔 nvim

請依下列指令，完成 nvim 這個 Shell Script 執行檔的安裝作業。

```sh
mkdir -p ~/.local/bin
cp ~/.config/nvim/tools/nvim ~/.local/bin
```

為了讓作業系統能依據 PATH 這個環境變數，搜尋到 nvim 這個執行銷，請記得在您使用
的 Bash Shell 或 ZSH Shell 設定檔中，於 PATH 環境變數加入 `~/.local/bin` 搜尋路徑。

```sh
...
export PATH="$HOME/.local/bin:$PATH"
```

重啟 Bash / ZSH Shell，以便新設定的 PATH 環境變數能生效。

```sh
source ~/.bashrc
```

或

```sh
source ~/.zshrc
```

(2) 安裝插件

在終端機輸入下列指令，以便 Neovim 可在不啟動 UI 介面的模式下執行（headless）。
以便 nvim 需要用到的各種插件(Plugins)，可以執行安裝作業。

每個插件在完成下載及安裝的工作後，均會顯示結果回報在畫面上，待看到「... has been
installed」的時候，則可按《Ctrl》＋《C》鍵，終結這個安裝指令。

```sh
nvim --headless
```

### 3. 操作 Neovim（Start Neovim）

請務必記得，使用 nvim 需以如下執行檔啟動，而不要直接執行 nvim 指令：

```sh
nvim
```

**【附註】：**

本專案的 Neovim 設定檔存放目錄及插件的存放目錄說明：

- 設定 (Configuration) 存放目錄路徑： `~/.config/nvim/`
- 執行時使月檔案及插件存放目錄路徑： `~/.local/share/nvim/`

## 後續規劃（Todos）

- 將 DAP 插入納入，以便可以針對 Python 、 JavaScript 及 Lua Script 進行除錯
- 編撰與 nvim 相關的《安裝作業》程序文件，如：Python 、NodeJS、Lua
- 製作示範影片，供人快速掌握 nvim 的操作應用

**【附註】：**

因個人能力、精力有限，目前預計編撰的《XYZ 安裝作業》程序文件，其範圍僅下
述三種，且其優先順序由上而下：

- Manjaro (ArchLinux)
- macOS 11.6.1
- Ubuntu 22.04

## 快捷鍵（Bindings）

【附註】：

**〈leader〉** = `《，》`

| Plugin    | Mapping      | Action                                  |
| --------- | ------------ | --------------------------------------- |
|           | \<Space\>e   | Open file explorer                      |
|           | \<Space\>;   | Open a terminal window                  |
|           | sp           | Split window horizontally               |
|           | vs           | Split window vertically                 |
|           | \<C-H\>      | Move cursor to split left               |
|           | \<C-J\>      | Move cursor to split down               |
|           | \<C-K\>      | Move cursor to split up                 |
|           | \<C-L\>      | Move cursor to split right              |
|           | fr           | Search & replace in current buffer      |
|           | tj           | Move one tab left                       |
|           | tk           | Move one tab right                      |
|           | tn           | Create a new tab                        |
|           | to           | Close all other tabs                    |
|           | gt           | Go to next tabline                      |
|           | gT           | Go to prettier tabline                  |
| coc       | \<C-@\>      | Open autocompletion                     |
| coc       | \<Enter\>    | Select autocompletion                   |
| coc       | \<S-Tab\>    | Browse previous autocompletion          |
| coc       | \<Tab\>      | Browse next autocompletion              |
| coc       | \<C-S\>      | Selections ranges                       |
| coc       | \<leader\>a  | Applying code action to selected region |
| coc       | \<leader\>ac | Applying code action for current buffer |
| coc       | \<leader\>qf | Apply AutoFix on current line           |
| coc       | \<leader\>l  | Execute code autofix                    |
| coc       | \<leader\>rn | Rename                                  |
| coc       | K            | Show document in pop up window          |
| coc       | gd           | Go to definition                        |
| coc       | gy           | Go to type definition                   |
| coc       | gi           | Go to implementation                    |
| coc       | gr           | Go to references                        |
| coc       | gr           | Go to references                        |
| coc       | [g           | Go to prettier diagnostic               |
| coc       | ]g           | Go to next diagnostic                   |
| coc       | \<Space\>a   | List all diagnostics                    |
| coc       | \<Space\>x   | List all coc extensions installed       |
| coc       | \<Space\>c   | Search command available in coc.nvim    |
| coc       | \<Space\>o   | Search symbol within outline view       |
| Telescope | ;b           | Switch opened files                     |
| Telescope | ;f           | Find file by file name                  |
| Telescope | ;g           | Find file by keyword(Live Grep)         |
| Telescope | ;t           | Open Git worktree picker                |
| Telescope | ;h           | Search help by tags                     |

## 使用插件（Plugins）

- [Lualine](https://github.com/nvim-lualine/lualine.nvim)
- [Packer](https://github.com/wbthomason/packer.nvim)
- [Plenary](https://github.com/nvim-lua/plenary.nvim)
- [Surround](https://github.com/blackCauldron7/surround.nvim)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Tokyo Night](https://github.com/folke/tokyonight.nvim)
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring)
- [nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)
- [vim-commentary](https://github.com/tpope/vim-commentary/)

## 維護者（Maintainers）

<a href="https://github.com/albingroen">
  <img src="https://avatars.githubusercontent.com/u/2138279?v=4" width="80" height="80" />
</a>
