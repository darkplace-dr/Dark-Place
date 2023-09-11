local character, super = Class("susie", true)

function character:init()
    super.init(self)

    self:addSpell("pacify")

    if Game:getFlag("susie_canact") then
        self.has_act = true
    else
        self.has_act = false
    end

    self.max_stats = {}
end

function character:onLevelUpLVLib()
    self:increaseStat("health", 15)
    self:increaseStat("attack", 2)
    self:increaseStat("magic", 1)
    self:increaseStat("defense", 1)
end

-- This function could be very useful for costumes
function character:getActor(light)
    if (Game.world and Game.world.map) and Game.world.map.id:find("flipside/") then
        return "flipside/susie"
    else
        return super.getActor(self, light)
    end
end

return character