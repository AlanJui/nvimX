local Comment = _G.safe_require("Comment")
if not Comment then
	return
end

Comment.setup()
-- Comment.setup({
-- 	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
-- })
