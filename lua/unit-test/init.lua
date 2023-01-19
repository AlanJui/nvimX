if not safe_require("neotest") then
	return
end

local ok, neotest_plenary = pcall(require, "neotest-plenary")
if not ok then
	require("neotest").setup({
		adapters = {
			require("neotest-python")({
				dap = { justMyCode = false },
			}),
		},
	})
else
	require("neotest").setup({
		adapters = {
			require("neotest-python")({
				dap = { justMyCode = false },
			}),
			require("neotest-plenary"),
		},
	})
end
