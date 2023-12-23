---@class PartyMember
---@overload fun(...) : PartyMember
local PartyMember, super = Class("PartyMember", true)

function PartyMember:init()
	super.init(self)
	
	self.flee_text = {}
	
	self.has_command = false
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

function PartyMember:getCommandOptions()
	return {"FIGHT", "ACT", "MAGIC"}, {"ITEM", "SPARE", "DEFEND"}
end

return PartyMember