local character, super = Class("noelle", true)

function character:init()
    super.init(self)

    self.love = 1
    if not Kristal.getLibConfig("leveling", "global_love") then
        self.level = self.love
    end

    self.max_stats = {}
end

function character:getTitle()
    if self:checkWeapon("thornring") then
        return "LV"..self:getLevel().." Ice Trancer\nReceives pain to\nbecome stronger."
    elseif self:getFlag("iceshocks_used", 0) > 0 then
        return "LV"..self:getLevel().." Frostmancer\nFreezes the enemy."
    end
    return super.getTitle(self)
end

function character:levelUp()
    self:increaseStat("health", 10)
    self:increaseStat("attack", 1)
    self:increaseStat("magic", 3)
    self:increaseStat("defense", 1)
    self.love = self.love + 1
    self.req_exp = self.exp_needed[self.love + 1] or 0
end

return character