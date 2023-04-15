local character, super = Class("ralsei", true)

function character:init()
    super.init(self)

    self.love = 1
    if not Kristal.getLibConfig("leveling", "global_love") then
        self.level = self.love
    end

    self.max_stats = {}
end

function character:onLevelUpLVLib()
    self:increaseStat("health", 10)
    self:increaseStat("attack", 1)
    self:increaseStat("magic", 2)
    self:increaseStat("defense", 1)
end

return character