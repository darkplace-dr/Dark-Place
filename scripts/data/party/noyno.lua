local character, super = Class("noyno", true)

function character:init()
    super.init(self)

    self.max_stats = {}
end

function character:onLevelUpLVLib()
    self:increaseStat("health", 10)
    self:increaseStat("attack", 1)
    self:increaseStat("magic", 2)
    self:increaseStat("defense", 1)
end

return character
