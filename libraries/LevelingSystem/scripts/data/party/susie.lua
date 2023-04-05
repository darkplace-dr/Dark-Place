local character, super = Class("susie", true)

function character:init()
    super.init(self)

    self.love = 1
    if not Kristal.getLibConfig("leveling", "global_love") then
        self.level = self.love
    end

    self.max_stats = {}
end

function character:onLevelUpLVLib()
    self:increaseStat("health", 15)
    self:increaseStat("attack", 2)
    self:increaseStat("magic", 1)
    self:increaseStat("defense", 1)
end

return character