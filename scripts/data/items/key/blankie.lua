local item, super = Class(Item, "blankie")

function item:init()
    super.init(self)

    self.name = "Fleece Blanket"
    self.type = "key"
    self.description = "A light blue fleece blanket with a sun and cloud pattern"
    self.can_sell = false
end


function item:onWorldUse()
    if Game.world.map.id == "spamroom" then
        Game.world:startCutscene("blankie_ach.blankie")
    else
        Assets.playSound("ui_cant_select")
    end
end

return item