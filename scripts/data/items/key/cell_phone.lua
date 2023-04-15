local item, super = Class("cell_phone", true)

function item:onWorldUse()
    Game.world:startCutscene("cell_phone")
end

return item
