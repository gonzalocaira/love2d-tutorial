local Scene = require("lib.Scene")
local Button = require("lib.ui.Button")
local Label = require("lib.ui.Label")
local U = require("lib.Utils")
local TextField = require("lib.ui.TextField")

local MM = Scene:derive("MainMenu")

function MM:new(scene_mgr)
    MM.super.new(self, scene_mgr)
    self.click = function(btn)
        self:on_click(btn)
    end
end

local entered = false
function MM:enter()
    MM.super.enter(self)
    if not entered then
        entered = true
        local sw = love.graphics.getWidth()
        local sh = love.graphics.getHeight()
        
        local start_button = Button(sw / 2, sh / 2 - 30, 140, 40, "Start")
        local exit_button = Button(sw / 2, sh / 2 + 30, 140, 40, "Exit")
        exit_button:colors({0, 128, 0, 255}, {64, 212, 64, 255}, {200, 255, 200, 255})

        local mmtext = Label(0, 20, love.graphics.getWidth(), 40, "Main Menu")

        local tf = TextField(love.graphics.getWidth() / 2- 50, 60, 100, 40, "hello", U.gray(196), "left")

        self.em:add(start_button)
        self.em:add(exit_button)
        self.em:add(mmtext)
        self.em:add(tf)
    end
    
    _G.events:hook("onBtnClick", self.click)
end

function MM:exit()
    _G.events:unhook("onBtnClick", self.click)
end

function MM:on_click(button)
    print("Button Clicked: " .. button.text)
    if button.text == "Start" then
        self.scene_mgr:switch("Test")
    elseif button.text == "Exit" then
        love.event.quit()
    end
end

function MM:update(dt)
    self.super.update(self,dt)

    if Key:key_down("escape") then
        love.event.quit()
    -- elseif Key:key_down("space") then
    --     self.button:enable(not self.button.interactible)
    end
    
end

return MM
