stackline = require("stackline.stackline.stackline")
stackline:init()

-- 對於「作用中視窗」，使用「彩色框線加以標示」。
hs.window.highlight.ui.overlay = true
hs.window.highlight.start()

hs.hotkey.bindSpec({ { "ctrl", "cmd", "alt" }, "h" }, function()
	hs.notify.show("Hello World!", "Welcome to Hammerspoon", "")
end)

hs.window.highlight.ui.overlay = true
hs.window.highlight.ui.flashDuration = 0.3
hs.window.highlight.ui.overlayColor = { 0.2, 0.05, 0, 0.25 }
hs.window.highlight.ui.frameColor = { 1, 0, 0, 0.5 }
-- hs.window.highlight.ui.frameColor = { 0, 1, 0, 1 }
hs.window.highlight.ui.frameColor = { 1, 1, 0, 1 }
hs.window.highlight.ui.frameWidth = 6
hs.window.highlight.start()

-- 將終端機視窗置於螢幕中央
-----------------------------------------------------------------------
-- References:
-- https://github.com/apesic/dotfiles/blob/master/.hammerspoon/init.lua
-- http://stevelosh.com/blog/2012/10/a-modern-space-cadet/
-- https://learnxinyminutes.com/docs/lua/
-- https://github.com/jasonrudolph/keyboard
-----------------------------------------------------------------------

require("vim")
lib = require("lib")
hs.timer = require("hs.timer")
log = hs.logger.new("phil", "debug")

-- Shortcut to reload this hammerspoon config.
-- This is bound early so that the hotkey for reloading the config still works even if there's an issue later
-- on in the file.
-- hs.hotkey.bind({ "shift", "cmd", "ctrl" }, "R", function()
-- 	hs.reload()
-- end)

----------------
-- Configuration
----------------

-- Make the alerts look nicer.
hs.alert.defaultStyle.strokeColor = { white = 1, alpha = 0 }
hs.alert.defaultStyle.fillColor = { white = 0.05, alpha = 0.75 }
hs.alert.defaultStyle.radius = 10

-- Disable the slow default window animations.
hs.window.animationDuration = 0
