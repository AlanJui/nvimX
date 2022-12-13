stackline = require("stackline.stackline.stackline")
stackline:init()

-- 對於「作用中視窗」，使用「彩色框線加以標示」。
hs.window.highlight.ui.overlay = true
hs.window.highlight.start()

hs.hotkey.bindSpec({ { "ctrl", "cmd", "alt" }, "h" }, function()
	hs.notify.show("Hello World!", "Welcome to Hammerspoon", "")
end)

-- hs.window.highlight.ui.overlay = true
-- hs.window.highlight.ui.flashDuration = 0.3
-- hs.window.highlight.ui.overlayColor = { 0.2, 0.05, 0, 0.25 }
-- hs.window.highlight.ui.frameColor = { 0, 0.6, 1, 0.5 }
-- hs.window.highlight.ui.frameColor = { 0, 1, 0, 1 }
hs.window.highlight.ui.frameColor = { 1, 1, 0, 1 }
hs.window.highlight.ui.frameWidth = 10
hs.window.highlight.start()
