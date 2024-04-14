local character, super = Class("robo_susie", true)

function character:init()
    super.init(self)

    self.lw_portrait = "face/robo_susie/smile"

    self.max_stats = {}
end

function character:onLevelUpLVLib(level)
    self:increaseStat("health", 15)
    self:increaseStat("attack", 2)
    self:increaseStat("magic", 1)
    self:increaseStat("defense", 1)
end

return character