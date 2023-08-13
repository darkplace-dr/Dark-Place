---@class PartyMember
local PartyMember, super = Class("PartyMember", true)

function PartyMember:init()
    super.init(self)

    self.love = 1
    self.exp = 0
    self.max_exp = 99999

    -- Party member specific EXP requirements
    -- The size of this table is the max LV
    self.exp_needed = {
        [ 1] = 0,
        [ 2] = 10,
        [ 3] = 30,
        [ 4] = 70,
        [ 5] = 120,
        [ 6] = 200,
        [ 7] = 300,
        [ 8] = 500,
        [ 9] = 800,
        [10] = 1200,
        [11] = 1700,
        [12] = 2500,
        [13] = 3500,
        [14] = 5000,
        [15] = 7000,
        [16] = 10000,
        [17] = 15000,
        [18] = 25000,
        [19] = 50000,
        [20] = 99999
    }
end

-- Getters

function PartyMember:getLevel()
    return Kristal.getLibConfig("leveling", "global_love") and self.level or self.love
end

-- Functions / Getters & Setters

function PartyMember:addExp(amount)
    self.exp = Utils.clamp(self.exp + amount, 0, self.max_exp)

    local leveled_up = false
    while self.exp >= self:getNextLvRequiredEXP() and self.love < #self.exp_needed do
        leveled_up = true
        self.love = self.love + 1
        self:onLevelUpLVLib(self.love)
    end

    return leveled_up
end

function PartyMember:onLevelUpLVLib(level)
    self:increaseStat("health", 10)
    self:increaseStat("attack", 2)
    self:increaseStat("defense", 2)
end

function PartyMember:getExp()
    return self.exp
end

function PartyMember:getNextLvRequiredEXP()
    return self.exp_needed[self.love + 1] or 0
end

function PartyMember:getNextLv()
    return Utils.clamp(self:getNextLvRequiredEXP() - self.exp, 0, self.max_exp)
end

function PartyMember:onSave(data)
    if Kristal.getLibConfig("leveling", "global_love") then return end

    data.exp = self.exp
    data.love = self.love
end

function PartyMember:onLoad(data)
    if Kristal.getLibConfig("leveling", "global_love") then return end

    self.exp = data.exp or self.exp
    self.love = data.love or self.love
end

return PartyMember