if not Kristal.getLibConfig("ribbit", "changeSavepointSound") then
    return CLASS_NAME_GETTER("Savepoint")
end

local Savepoint, super = Class("Savepoint", true)

function Savepoint:onInteract(player, dir)
    if Kristal.callEvent("isLeaderRibbit") then
        Assets.playSound("powerfrog")
    end

    if self.text_once and self.used then
        if Kristal.callEvent("isLeaderRibbit") then
            Assets.stopSound("power")
        end
        self:onTextEnd()
        return
    end

    if self.text_once then
        self.used = true
    end

    super.super.onInteract(self, player, dir)
    if Kristal.callEvent("isLeaderRibbit") then
        Assets.stopSound("power")
    end
    return ok
end

-- this used to be commented out
function Savepoint:onTextEnd()
    if Kristal.callEvent("isLeaderRibbit") then
        Assets.stopSound("powerfrog")
    end

    super.onTextEnd(self)
end

function Savepoint:init(x, y, properties, sprite)
    super.init(self, x, y, properties, sprite)
    self.siner = 0

    properties = properties or {}

    self.marker = properties["marker"]
    self.simple_menu = properties["simple"]
    self.text_once = properties["text_once"]
    self.heals = properties["heals"] ~= false

    self.solid = true
    self.frog_mode = false

    self:setOrigin(0.5, 0.5)

    if Kristal.callEvent("isLeaderRibbit") then
        self.frog_mode = true
        self:setSprite("world/events/savefrog", 0.2)
        self:setOrigin(0.5, 0.5)

        -- I am an idot.
        --               -SadDiamondMan 2023 - 2023

        --sprite.glow = Sprite("world/events/save_glow")
        --sprite:addChild(sprite.glow)
    else
        self:setSprite("world/events/savepoint", 1/6)
    end

    self.used = false

    -- The hitbox is ALMOST half the size of the sprite, but not quite.
    -- It's 9 pixels tall, 10 pixels away from the top.
    -- So divide by 2, round, then multiply by 2 to get the right size for 2x.
    local width, height = self:getSize()
    self:setHitbox(0, math.ceil(height / 4) * 2, width, math.floor(height / 4) * 2)
end

function Savepoint:draw()
    if self.frog_mode then
        self.siner = self.siner + 1 * DTMULT
        love.graphics.setColor(1, 1, 0, (0.4 - (math.sin((self.siner / 9)) * 0.2)))
        love.graphics.ellipse( "fill", 30, 30, 20 + math.sin(self.siner/16), 12, 16 )
        love.graphics.ellipse( "fill", 30, 30, 25 + math.sin(self.siner/16), 12, 6  )
        love.graphics.ellipse( "fill", 30, 30, 32 + math.sin(self.siner/16), 12, 6  )
        love.graphics.ellipse( "fill", 30, 30, 35 + math.sin(self.siner/16), 12, 16 )
        
        -- The following is the code for this effect found in RIBBIT. If someone wants to make it more accurate, go for it. - Agent 7
        --[[
            draw_set_color(c_yellow)
        for (i = 0; i < 4; i += 1)
        {
            draw_set_alpha((0.4 - (sin((siner / 9)) * 0.2)))
            draw_ellipse(((x - 8) - ((sin((siner / 14)) * 2) - (i * 4))), (y + 22), ((x + 37) + ((sin((siner / 14)) * 2) + (i * 4))), (y + 42), 0)
            draw_set_circle_precision((8 + (i * 3)))
        }
        ]]



    end
    super.draw(self)
end

return Savepoint