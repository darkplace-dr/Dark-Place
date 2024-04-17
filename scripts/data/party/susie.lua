local character, super = Class("susie", true)

function character:init()
    super.init(self)

    self.lw_portrait = "face/susie/smile"

    self:addSpell("pacify")

    self.has_act = Game:getFlag("susie_canact")

    self.max_stats = {}

    self.lw_health = 30

    self.lw_stats = {
        health = 30,
        attack = 12,
        defense = 10,
        magic = 1
    }

    self.special_actors = { flipside = Registry.createActor("flipside/susie") }
end

function character:lightLVStats()
    self.lw_stats = {
        health = self:getLightLV() <= 20 and math.min(25 + self:getLightLV() * 5,99) or 25 + self:getLightLV() * 5,
        attack = 10 + self:getLightLV() * 2 + math.floor(self:getLightLV() / 4),
        defense = 9 + math.ceil(self:getLightLV() / 4),
        magic = math.ceil(self:getLightLV() / 4)
    }
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