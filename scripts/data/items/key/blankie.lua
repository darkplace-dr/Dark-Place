local item, super = Class(Item, "blankie", true)

function item:init()
    super.init(self)

    self.name = "Fleece Blanket"
    self.type = "key"
    self.description = "A light blue fleece blanket with a sun and cloud pattern"
    self.can_sell = false
end


function item:onWorldUse()
    Game.world:startCutscene("blankie_ach.blankie")
end

return item