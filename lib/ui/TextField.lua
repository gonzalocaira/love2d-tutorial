local utf8 = require("utf8")
local U = require("lib.Utils")
local Label = require("lib.ui.Label")
local TextField = Label:derive("TextField")

--On Android and iOS, textinput is disabled by default; 
--call love.keyboard.setTextInput to enable it. 

function TextField:new(x, y, w, h, text, color, align)
    TextField.super.new(self, x, y, w, h, text, color, align)
    self.focus = false

    self.key_pressed = function(key) if key == "backspace" then self:on_text_input(key) end end
    self.text_input = function(text) self:on_text_input(text) end

    --These need to be moved to on_enable
    _G.events:hook("key_pressed", self.key_pressed)
    _G.events:hook("text_input", self.text_input)
    --TODO: on_disable
    -- _G.events:unhook("key_pressed", self.key_pressed)
    -- _G.events:unhook("text_input", self.text_input)
end

function TextField:set_focus(focus)
    assert(type(focus) == 'boolean', "focus should be of type boolean")
    self.focus = focus
end

function TextField:on_text_input(text)
    -- if not self.focus or not self.enabled then return end
    if text == "backspace" then
        -- get the byte offset to the last UTF-8 character in the string.
        local byteoffset = utf8.offset(self.text, -1)
 
        if byteoffset then
            -- remove the last UTF-8 character.
            -- string.sub operates on bytes rather than UTF-8 characters, 
            --so we couldn't do string.sub(text, 1, -2).
            self.text = string.sub(self.text, 1, byteoffset - 1)
        end
    else
        self.text = self.text .. text
    end
end

function TextField:draw()
    love.graphics.setColor(U.gray(32))
    love.graphics.rectangle("fill", self.pos.x, self.pos.y - self.h / 2, self.w, self.h)
    TextField.super.draw(self)
end

return TextField