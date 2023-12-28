---@class PartyMember
---@field ribbit boolean
---@field opinions integer[]
local PartyMember, super = Class("PartyMember", true)

function PartyMember:init()
    super.init(self)
    
    self.flee_text = {}
    
    self.has_command = false
    
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

    self.future_heals = {}

    self.ribbit = false

    self.opinions = {}
    self.default_opinion = 50
end

function PartyMember:onSave(data)
    super.onSave(self, data)

    data.opinions = self.opinions
    
    if Kristal.getLibConfig("leveling", "global_love") then return end

    data.exp = self.exp
    data.love = self.love
end

function PartyMember:onLoad(data)
    super.onLoad(self, data)
    
    self.opinions = data.opinions or self.opinions
    
    if Kristal.getLibConfig("leveling", "global_love") then return end

    self.exp = data.exp or self.exp
    self.love = data.love or self.love
end

function PartyMember:getMaxShield()
    return self:getStat("health") / 2
end

function PartyMember:hasSkills()
    return (self:hasAct() and self:hasSpells())
end

function PartyMember:getSkills()
    local color = {1, 1, 1, 1}
    for _,spell in ipairs(self:getSpells()) do
        if spell:hasTag("spare_tired") and spell:isUsable(spell) and spell:getTPCost(spell) <= Game:getTension() then
            local has_tired = false
            for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
                if enemy.tired then
                    has_tired = true
                    break
                end
            end
            if has_tired then
                color = {0, 178/255, 1, 1}
            end
        end
    end
    return {
        {"ACT", "Do all\nsorts of\nthings", nil, function() Game.battle:setState("ENEMYSELECT", "ACT") end},
        {(Kristal.getLibConfig("better_battles", "magic_name")) or "Magic", Kristal.getLibConfig("better_battles", "magic_description") or "Cast\nSpells", color, function()
            Game.battle:clearMenuItems()

            -- First, register X-Actions as menu items.

            if Game.battle.encounter.default_xactions and self:hasXAct() then
                local spell = {
                    ["name"] = Game.battle.enemies[1]:getXAction(self.battler),
                    ["target"] = "xact",
                    ["id"] = 0,
                    ["default"] = true,
                    ["party"] = {},
                    ["tp"] = 0
                }

                Game.battle:addMenuItem({
                    ["name"] = self:getXActName() or "X-Action",
                    ["tp"] = 0,
                    ["color"] = {self:getXActColor()},
                    ["data"] = spell,
                    ["callback"] = function(menu_item)
                        Game.battle.selected_xaction = spell
                        Game.battle:setState("XACTENEMYSELECT", "SPELL")
                    end
                })
            end

            for id, action in ipairs(Game.battle.xactions) do
                if action.party == self.id then
                    local spell = {
                        ["name"] = action.name,
                        ["target"] = "xact",
                        ["id"] = id,
                        ["default"] = false,
                        ["party"] = {},
                        ["tp"] = action.tp or 0
                    }

                    Game.battle:addMenuItem({
                        ["name"] = action.name,
                        ["tp"] = action.tp or 0,
                        ["description"] = action.description,
                        ["color"] = action.color or {1, 1, 1, 1},
                        ["data"] = spell,
                        ["callback"] = function(menu_item)
                            Game.battle.selected_xaction = spell
                            Game.battle:setState("XACTENEMYSELECT", "SPELL")
                        end
                    })
                end
            end

            -- Now, register SPELLs as menu items.
            for _,spell in ipairs(self:getSpells()) do
                local color = spell.color or {1, 1, 1, 1}
                if spell:hasTag("spare_tired") then
                    local has_tired = false
                    for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
                        if enemy.tired then
                            has_tired = true
                            break
                        end
                    end
                    if has_tired then
                        color = {0, 178/255, 1, 1}
                    end
                end
                Game.battle:addMenuItem({
                    ["name"] = spell:getName(),
                    ["tp"] = spell:getTPCost(self),
                    ["unusable"] = not spell:isUsable(self),
                    ["description"] = spell:getBattleDescription(),
                    ["party"] = spell.party,
                    ["color"] = color,
                    ["data"] = spell,
                    ["callback"] = function(menu_item)
                        Game.battle.selected_spell = menu_item

                        if not spell.target or spell.target == "none" then
                            Game.battle:pushAction("SPELL", nil, menu_item)
                        elseif spell.target == "ally" then
                            Game.battle:setState("PARTYSELECT", "SPELL")
                        elseif spell.target == "enemy" then
                            Game.battle:setState("ENEMYSELECT", "SPELL")
                        elseif spell.target == "party" then
                            Game.battle:pushAction("SPELL", Game.battle.party, menu_item)
                        elseif spell.target == "enemies" then
                            Game.battle:pushAction("SPELL", Game.battle:getActiveEnemies(), menu_item)
                        end
                    end
                })
            end

            Game.battle:setState("MENUSELECT", "SPELL")
        end}
    }
end

function PartyMember:hasLightSkills()
    return (self:hasAct() and self:hasSpells())
end

function PartyMember:getLightSkills()
    local color = {1, 1, 1, 1}
    for _,spell in ipairs(self:getSpells()) do
        if spell:hasTag("spare_tired") and spell:isUsable(spell) and spell:getTPCost(spell) <= Game:getTension() then
            local has_tired = false
            for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
                if enemy.tired then
                    has_tired = true
                    break
                end
            end
            if has_tired then
                color = {0, 178/255, 1, 1}
            end
        end
    end
    return {
        {"ACT", "Do all\nsorts of\nthings", nil, function() Game.battle:setState("ENEMYSELECT", "ACT") end},
        {"Spell", Kristal.getLibConfig("better_battles", "magic_description") or "Cast\nSpells", color, function()
            Game.battle:clearMenuItems()
			Game.battle.current_menu_columns = 2
			Game.battle.current_menu_rows = 3

			if Game.battle.encounter.default_xactions and Game.battle.party[1].chara:hasXAct() then
				local spell = {
					["name"] = Game.battle.enemies[1]:getXAction(Game.battle.party[1]),
					["target"] = "xact",
					["id"] = 0,
					["default"] = true,
					["party"] = {},
					["tp"] = 0
				}

				Game.battle:addMenuItem({
					["name"] = Game.battle.party[1].chara:getXActName() or "X-Action",
					["tp"] = 0,
					["color"] = { Game.battle.party[1].chara:getXActColor() },
					["data"] = spell,
					["callback"] = function(menu_item)
						Game.battle.selected_xaction = spell
						Game.battle:setState("XACTENEMYSELECT", "SPELL")
					end
				})
			end

			for id, action in ipairs(Game.battle.xactions) do
				if action.party == Game.battle.party[1].chara.id then
					local spell = {
						["name"] = action.name,
						["target"] = "xact",
						["id"] = id,
						["default"] = false,
						["party"] = {},
						["tp"] = action.tp or 0
					}

					Game.battle:addMenuItem({
						["name"] = action.name,
						["tp"] = action.tp or 0,
						["description"] = action.description,
						["color"] = action.color or { 1, 1, 1, 1 },
						["data"] = spell,
						["callback"] = function(menu_item)
							Game.battle.selected_xaction = spell
							Game.battle:setState("XACTENEMYSELECT", "SPELL")
						end
					})
				end
			end

			-- Now, register SPELLs as menu items.
			for _, spell in ipairs(Game.battle.party[1].chara:getSpells()) do
				local color = spell.color or { 1, 1, 1, 1 }
				if spell:hasTag("spare_tired") then
					local has_tired = false
					for _, enemy in ipairs(Game.battle:getActiveEnemies()) do
						if enemy.tired then
							has_tired = true
							break
						end
					end
					if has_tired then
						color = { 0, 178 / 255, 1, 1 }
					end
				end
				Game.battle:addMenuItem({
					["name"] = spell:getName(),
					["tp"] = spell:getTPCost(Game.battle.party[1].chara),
					["unusable"] = not spell:isUsable(Game.battle.party[1].chara),
					["description"] = spell:getBattleDescription(),
					["party"] = spell.party,
					["color"] = color,
					["data"] = spell,
					["callback"] = function(menu_item)
						Game.battle.selected_spell = menu_item

						if not spell.target or spell.target == "none" then
							Game.battle:pushAction("SPELL", nil, menu_item)
						elseif spell.target == "ally" and #Game.battle.party == 1 then
							Game.battle:pushAction("SPELL", Game.battle.party[1], menu_item)
						elseif spell.target == "ally" then
							Game.battle:setState("PARTYSELECT", "SPELL")
						elseif spell.target == "enemy" then
							Game.battle:setState("ENEMYSELECT", "SPELL")
						elseif spell.target == "party" then
							Game.battle:pushAction("SPELL", Game.battle.party, menu_item)
						elseif spell.target == "enemies" then
							Game.battle:pushAction("SPELL", Game.battle:getActiveEnemies(), menu_item)
						end
					end
				})
			end

			Game.battle:setState("MENUSELECT", "SPELL")
        end}
    }
end

-- Getters

function PartyMember:getLevel()
    return self.level
end

function PartyMember:getLOVE()
    return self.love
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

function PartyMember:getCommandOptions()
    return {"FIGHT", "ACT", "MAGIC"}, {"ITEM", "SPARE", "DEFEND"}
end

--- Called whenever a HealItem is used. \
--- Calculates the amount of healing an item should apply based on the character's healing bonuses.
---@param amount integer The amount of base healing for the item.
---@param item any The HealItem that is being used.
function PartyMember:applyHealBonus(amount, item)
    -- Check to see whether this item allows heal bonuses, return original amount if it does not.
    if item.block_heal_bonus then
        return amount
    end
    
    -- Doesn't apply bonuses if the original heal amount is 0 or less, unless the config overrides this behaviour.
    if amount <= 0 and not Kristal.getLibConfig("pie", "alwaysApplyHealBonus", true) then
        return amount
    end
    
    local equipment = self:getEquipment()
    local final_amount = amount
    local multiplier = 1
    local bonus = 0

    -- Gathers all the heal bonuses from the character's equipment.
    for _,equipitem in ipairs(equipment) do
        if equipitem:includes(Item) then
            multiplier = multiplier * equipitem:getHealMultiplier(self, item)
            bonus = bonus + equipitem:getHealBonus(self, item)
        end
    end

    -- Applies the heal bonus, based on the order set in the config.
    if Kristal.getLibConfig("pie", "healMultiplierTakesPriority", true) then
        final_amount = (final_amount * multiplier) + bonus
    else
        final_amount = (final_amount + bonus) * multiplier
    end

    return math.floor(final_amount)
end

--- Registers a future heal for this party member.
---@param amount integer Amount of HP to restore.
---@param turns integer Amount of turns this heal happens in.
function PartyMember:addFutureHeal(amount, turns)
    table.insert(self.future_heals, {amount = amount, turns = turns})
end

--- Callback for when a future heal activates. \
--- If this function returns `true`, the future heal will be cancelled.
---@param amount integer The amount of HP restored by this heal.
---@param battler PartyBattler The PartyBattler associated with this character.
function PartyMember:onFutureHeal(amount, battler) end

---@param other_party string|PartyMember
function PartyMember:getOpinion(other_party)
    if type(other_party) == "table" and other_party:includes(PartyMember) then
        other_party = other_party.id
    end
    if self.opinions[other_party] ~= nil then return self.opinions[other_party] end
    return self.default_opinion
end

---@param other_party string|PartyMember
function PartyMember:setOpinion(other_party, amount)
    if type(other_party) == "table" and other_party:includes(PartyMember) then
        other_party = other_party.id
    end
    self.opinions[other_party] = amount
    return amount
end

---@param other_party string|PartyMember
function PartyMember:addOpinion(other_party, amount)
    if type(other_party) == "table" and other_party:includes(PartyMember) then
        other_party = other_party.id
    end
    self.opinions[other_party] = self:getOpinion(other_party) + amount
    return self.opinions[other_party]
end

return PartyMember