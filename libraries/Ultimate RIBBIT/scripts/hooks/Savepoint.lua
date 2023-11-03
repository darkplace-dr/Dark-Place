if not Kristal.getLibConfig("ribbit", "changeSavepointSound") then
    return CLASS_NAME_GETTER("Savepoint")
end

local Savepoint, super = Class("Savepoint", true)

function Savepoint:onInteract(player, dir)
    if Kristal.callEvent("isLeaderRibbit") then
        Assets.playSound("powerfrog")
    end

    if self.text_once and self.used then
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
    return true
end

function Savepoint:init(x, y, properties, sprite)
    super.init(self, x, y, properties, sprite)

    properties = properties or {}

    self.marker = properties["marker"]
    self.simple_menu = properties["simple"]
    self.text_once = properties["text_once"]
    self.heals = properties["heals"] ~= false

    self.solid = true

    self:setOrigin(0.5, 0.5)

    if Kristal.callEvent("isLeaderRibbit") then
        self:setSprite("world/events/savefrog", 1/6)
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

--[[
function Savepoint:onTextEnd()
    super.onTextEnd(self)

    Assets.stopSound("powerfrog")
end
--]]

return Savepoint