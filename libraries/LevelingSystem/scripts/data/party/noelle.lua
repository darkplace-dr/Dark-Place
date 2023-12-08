local character, super = Class("noelle", true)

function character:init()
    super.init(self)

    self.love = 1
    if not Kristal.getLibConfig("leveling", "global_love") then
        self.level = self.love
    end

    self.max_stats = {}
    
    self.frost_resist = true
end

function character:getTitle()
    if self:checkWeapon("thornring") then
        return "LV"..self:getLevel().." Ice Trancer\nReceives pain to\nbecome stronger."
    elseif self:getFlag("iceshocks_used", 0) > 0 then
        return "LV"..self:getLevel().." Frostmancer\nFreezes the enemy."
    elseif Kristal.getLibConfig("leveling", "global_love") then
        return "LV1 "..self.title
    else
        return "LV"..self:getLevel().." "..self.title
    end
end

function character:onLevelUpLVLib()
    self:increaseStat("health", 10)
    self:increaseStat("attack", 1)
    self:increaseStat("magic", 3)
    self:increaseStat("defense", 1)
end

return character
