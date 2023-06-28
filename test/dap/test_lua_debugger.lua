-- [[
-- 1. Open a Neovim instance (instance A)
--
-- 2. Launch the DAP server with (A)
--  :lua require"osv".launch({port=8086})
--
-- 3. Open another Neovim instance (instance B)
--
-- 4. Open `myscript.lua` (B)
--
-- 5. Place a breakpoint on line 2 using (B)
--   :lua require"dap".toggle_breakpoint()
--
-- 6. Connect the DAP client using (B)
--   :lua require"dap".continue()
--
-- 7. Run `myscript.lua` in the other instance (A)
--   :luafile myscript.lua
--
-- 8. The breakpoint should hit and freeze the instance (B)
-- ]]

print "start"
for i = 1, 3 do
  print(i)
end
print "end"
