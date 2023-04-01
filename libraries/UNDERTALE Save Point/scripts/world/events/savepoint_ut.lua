---@class SavepointUT : Interactable
---@overload fun(...) : SavepointUT
local SavepointUT, super = Class(Interactable)

function SavepointUT:init(data)
    super.init(self, data.x, data.y, 0, 0, data.properties)

    self.marker = data.properties and data.properties["marker"]

    self.simple_menu = data.properties["simple"]

    self.solid = true

    self:setOrigin(0.5, 0.5)
    self:setSprite("world/events/savepointut", 1/2)

    self.text_once = data.properties["text_once"]
    self.used = false
end

function SavepointUT:onInteract(player, dir)
    Assets.playSound("power")

    if self.text_once and self.used then
        self:onTextEnd()
        return
    end

    if self.text_once then
        self.used = true
    end

    super.onInteract(self, player, dir)
    return true
end

function SavepointUT:onTextEnd()
    if not self.world then return end

    for _,party in ipairs(Game.party) do
        party:heal(math.huge, false)
    end
    if self.simple_menu or (self.simple_menu == nil and (Game:isLight() or Game:getConfig("smallSaveMenu"))) then
        self.world:openMenu(SimpleSaveMenu(Game.save_id, self.marker))
    else
        self.world:openMenu(SaveMenu(self.marker))
    end
end

return SavepointUT