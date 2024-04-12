local character, super = Class("susie", true)

function character:init()
    super.init(self)

    self.lw_portrait = "face/susie/smile"

    self:addSpell("pacify")

    self.has_act = Game:getFlag("susie_canact")

    self.max_stats = {}

    self.special_actors = { flipside = Registry.createActor("flipside/susie") }
end

function character:onLevelUpLVLib()
    self:increaseStat("health", 15)
    self:increaseStat("attack", 2)
    self:increaseStat("magic", 1)
    self:increaseStat("defense", 1)
end

function character:getActor(light)
    if Game.world and Game.world.map then
        local is_in_flipside, _ = Utils.startsWith(Game.world.map.id, "flipside/")
        if is_in_flipside then return self.special_actors.flipside end
    end

    return super.getActor(self, light)
end

return character