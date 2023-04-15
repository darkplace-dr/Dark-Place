---@class _PartyMember : PartyMember
---@overload fun(...) : PartyMember
local PartyMember, super = Class("PartyMember", true)

function PartyMember:init()
    super.init(self)

    self.love = 1
    self.exp = 0
    self.req_exp = 10
    self.next_lv = 10
    -- EXP requirements
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

function PartyMember:getLevel() return Kristal.getLibConfig("leveling", "global_love") and self.level or self.love end

-- Functions / Getters & Setters

function PartyMember:addExp(amount)
    self.exp = self.exp + amount
    Utils.clamp(self.exp, 0, 99999)
end

function PartyMember:onLevelUpLVLib()
    self:increaseStat("health", 10)
    self:increaseStat("attack", 2)
    self:increaseStat("defense", 2)
end

function PartyMember:levelUp()
    self:onLevelUpLVLib()
    if not Kristal.getLibConfig("leveling", "global_love") then
        self.love = self.love + 1
        self.req_exp = self.exp_needed[self.love + 1] or 0
    end
end

function PartyMember:getExp()
    return self.exp
end

function PartyMember:getNextLv()
    return self.next_lv
end

function PartyMember:save()
    local data = {
        id = self.id,
        title = self.title,
        level = self.level,
        health = self.health,
        stats = self.stats,
        lw_lv = self.lw_lv,
        lw_exp = self.lw_exp,
        lw_health = self.lw_health,
        lw_stats = self.lw_stats,
        spells = self:saveSpells(),
        equipped = self:saveEquipment(),
        flags = self.flags,
        exp = self.exp,
        love = self.love,
        req_exp = self.req_exp,
        next_lv = self.next_lv
    }
    self:onSave(data)
    return data
end

function PartyMember:load(data)
    self.title = data.title or self.title
    self.level = data.level or self.level
    self.stats = data.stats or self.stats
    self.lw_lv = data.lw_lv or self.lw_lv
    self.lw_exp = data.lw_exp or self.lw_exp
    self.lw_stats = data.lw_stats or self.lw_stats
    if data.spells then
        self:loadSpells(data.spells)
    end
    if data.equipped then
        self:loadEquipment(data.equipped)
    end
    self.flags = data.flags or self.flags
    self.health = data.health or self:getStat("health", 0, false)
    self.lw_health = data.lw_health or self:getStat("health", 0, true)
    self.exp = data.exp or self.exp
    self.love = data.love or self.love
    self.req_exp = data.req_exp or self.req_exp
    self.next_lv = data.next_lv or self.next_lv

    self:onLoad(data)
end

return PartyMember