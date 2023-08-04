---@class Nametag : Object
---@overload fun(...) : Nametag
local Nametag, super = Class(Object)

function Nametag:init(text, options)
    super.init(self, 56, 290)
    
    self.options = options or {}
    
    self.box = UIBox(0, 0, 92, 6)
    self.box.layer = -1
    self.box.debug_select = false
    self:addChild(self.box)
    
    self.name = text or ""
    self.color = self.options["color"] or {1, 1, 1, 1}
    self.font = Assets.getFont(
        self.options["font"]
        or Kristal.callEvent("getDefaultDialogNonMonospacedFont")
        or Kristal.callEvent("getDefaultDialogTextFont")
        or "main"
    )
    
    self.style = self.options["style"]
        or Kristal.callEvent("getDefaultDialogTextStyle")
        or (Game:isLight() and "none" or "dark")
    
    self.box_width = self.options["width"] or self.font:getWidth(text)
    self.box.width = self.box_width + 4
    
    local player_x = Game.world.player:localToScreenPos()
    if self.options["right"] == false then
        -- Just to make sure locational top doesn't prioritize over options bottom.
        -- Don't need to do anything here; it's already where we want it.
    elseif self.options["right"] or (player_x < 330 and #Game.world.stage:getObjects(Shopbox) == 0) then
        self.x = 585 - self.box.width
    end
    
    self.timer = 0
end

function Nametag:update()
    self.timer = self.timer + DTMULT
    super.update(self)
end

function Nametag:draw()
    super.draw(self)
    love.graphics.setFont(self.font)

    -- love.graphics.print(self.name, 2, -14)

    if self.style == "menu" then
        love.graphics.setColor(0, 0, 0)
        love.graphics.print(self.name, 4, -12)
        love.graphics.setColor(self.color)
        love.graphics.print(self.name, 2, -14)
    elseif self.style == "light" then
        local j, k = self.box:getBorder()
        local w, h = self.box.width + (j * 2), self.box.height + (k * 2)
        local canvas = Draw.pushCanvas(w, h, {stencil = false})
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(self.name, 0, 0)
        Draw.popCanvas()

        local shader = Kristal.Shaders["GradientV"]

        local last_shader = love.graphics.getShader()

        local white = self.color[1] == 1 and self.color[2] == 1 and self.color[3] == 1

        if white then
            love.graphics.setShader(shader)
            shader:sendColor("from", white and COLORS.dkgray or self.color)
            shader:sendColor("to", white and COLORS.navy or self.color)
            --love.graphics.setColor(cr, cg, cb, ca * (white and 1 or 0.3))
            local mult = white and 1 or 0.3
            love.graphics.setColor(1*mult, 1*mult, 1*mult, 1)
        else
            --love.graphics.setColor(mr, mg, mb, ma * 0.3)
            love.graphics.setColor(self.color[1]*0.3, self.color[2]*0.3, self.color[3]*0.3, self.color[4])
        end
        love.graphics.draw(canvas, 2, -14)

        if not white then
            love.graphics.setShader(shader)
            shader:sendColor("from", COLORS.white)
            shader:sendColor("to", white and COLORS.white or self.color)
        else
            love.graphics.setShader(last_shader)
        end
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(canvas, 2, -14)

        if not white then
            love.graphics.setShader(last_shader)
        end
    elseif self.style == "dark" then
        local j, k = self.box:getBorder()
        local w, h = self.box.width + (j * 2), self.font:getHeight()
        local canvas = Draw.pushCanvas(w, h, {stencil = false})
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(self.name, 0, 0)
        Draw.popCanvas()

        local shader = Kristal.Shaders["GradientV"]

        local last_shader = love.graphics.getShader()

        local white = self.color[1] == 1 and self.color[2] == 1 and self.color[3] == 1

        if white then
            love.graphics.setShader(shader)
            shader:sendColor("from", white and COLORS.dkgray or self.color)
            shader:sendColor("to", white and COLORS.navy or self.color)
            --love.graphics.setColor(cr, cg, cb, ca * (white and 1 or 0.3))
            local mult = white and 1 or 0.3
            love.graphics.setColor(1*mult, 1*mult, 1*mult, 1)
        else
            --love.graphics.setColor(mr, mg, mb, ma * 0.3)
            love.graphics.setColor(self.color[1]*0.3, self.color[2]*0.3, self.color[3]*0.3, self.color[4])
        end
        love.graphics.draw(canvas, 2, -14)

        if not white then
            love.graphics.setShader(shader)
            shader:sendColor("from", COLORS.white)
            shader:sendColor("to", white and COLORS.white or self.color)
        else
            love.graphics.setShader(last_shader)
        end
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(canvas, 2, -14)

        if not white then
            love.graphics.setShader(last_shader)
        end
    elseif self.style == "GONER" then
        -- loop through chars in text
        local x, y = 2, -14
        local specfade = 1 -- This is unused for now!
        -- It's used in chapter 1, though... so let's keep it around.
        local x_offset = 0

        for char in self.name:gmatch(utf8.charpattern) do
            if char then
                -- draw the character here, at (x + x_offset, y)
                love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4]*specfade)
                love.graphics.print(char, x + x_offset, y)
                love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4]*((0.3 + (math.sin((self.timer / 14)) * 0.1)) * specfade))
                love.graphics.print(char, x + 2 + x_offset, y)
                love.graphics.print(char, x - 2 + x_offset, y)
                love.graphics.print(char, x + x_offset, y + 2)
                love.graphics.print(char, x + x_offset, y - 2)
                love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4]*((0.08 + (math.sin((self.timer / 14)) * 0.04)) * specfade))
                love.graphics.print(char, x + 2 + x_offset, y)
                love.graphics.print(char, x - 2 + x_offset, y)
                love.graphics.print(char, x + x_offset, y + 2)
                love.graphics.print(char, x + x_offset, y - 2)
                love.graphics.setColor(self.color[1], self.color[2], self.color[3], self.color[4])
                x_offset = x_offset + self.font:getWidth(char)
            end
        end
    else
        love.graphics.setColor(self.color)
        love.graphics.print(self.name, 2, -14)
    end
end

return Nametag
