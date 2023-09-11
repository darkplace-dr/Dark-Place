local character, super = Class("kris", true)

function character:init()
    super.init(self)

    self.has_spells = true

    self.has_xact = false

    self:addSpell("xslash")
end

-- This function could be very useful for costumes
function character:getActor(light)
    if (Game.world and Game.world.map) and Game.world.map.id:find("flipside/") then
        return "flipside/kris"
    else
        return super.getActor(self, light)
    end
end

return character