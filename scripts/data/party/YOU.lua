local character, super = Class("YOU", true)

function character:init()
    super.init(self)

    self.max_stats = {}

    self.lw_health = 4

    self.lw_stats = {
        health = 4,
        attack = 2,
        defense = 1,
        magic = 0
    }
end

function character:onLevelUpLVLib(level)
    self:increaseStat("health", 10)
    self:increaseStat("attack", 1)
    self:increaseStat("defense", 2)
end

function character:lightLVStats()
    self.lw_stats = {
        health = 3 + self:getLightLV(),
        attack = 1 + self:getLightLV(),
        defense = 0 + math.ceil(self:getLightLV() / 4),
        magic = 0
    }
end

return character