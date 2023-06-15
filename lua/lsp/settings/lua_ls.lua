return {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "hs" },
      },
      workspace = {
        library = {
          [vim.fn.stdpath("config") .. "/lua"] = true,
          -- [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        },
      },
    },
  },
}
