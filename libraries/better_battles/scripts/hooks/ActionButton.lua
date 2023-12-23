---@class ActionButton
---@overload fun(...) : ActionButton
local ActionButton, super = Class("ActionButton", true)

function ActionButton:select()
    if Game.battle.encounter:onActionSelect(self.battler, self) then return end
    if Kristal.callEvent("onActionSelect", self.battler, self) then return end
    if self.type == "fight" then
        Game.battle:setState("ENEMYSELECT", "ATTACK")
    elseif self.type == "act" then
        Game.battle:setState("ENEMYSELECT", "ACT")
    elseif self.type == "magic" then
        Game.battle:clearMenuItems()

        -- First, register X-Actions as menu items.

        if Game.battle.encounter.default_xactions and self.battler.chara:hasXAct() then
            local spell = {
                ["name"] = Game.battle.enemies[1]:getXAction(self.battler),
                ["target"] = "xact",
                ["id"] = 0,
                ["default"] = true,
                ["party"] = {},
                ["tp"] = 0
            }

            Game.battle:addMenuItem({
                ["name"] = self.battler.chara:getXActName() or "X-Action",
                ["tp"] = 0,
                ["color"] = {self.battler.chara:getXActColor()},
                ["data"] = spell,
                ["callback"] = function(menu_item)
                    Game.battle.selected_xaction = spell
                    Game.battle:setState("XACTENEMYSELECT", "SPELL")
                end
            })
        end

        for id, action in ipairs(Game.battle.xactions) do
            if action.party == self.battler.chara.id then
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
        for _,spell in ipairs(self.battler.chara:getSpells()) do
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
                ["tp"] = spell:getTPCost(self.battler.chara),
                ["unusable"] = not spell:isUsable(self.battler.chara),
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
    elseif self.type == "item" then
        Game.battle:clearMenuItems()
        for i,item in ipairs(Game.inventory:getStorage("items")) do
            Game.battle:addMenuItem({
                ["name"] = item:getName(),
                ["unusable"] = item.usable_in ~= "all" and item.usable_in ~= "battle",
                ["description"] = item:getBattleDescription(),
                ["data"] = item,
                ["callback"] = function(menu_item)
                    Game.battle.selected_item = menu_item

                    if not item.target or item.target == "none" then
                        Game.battle:pushAction("ITEM", nil, menu_item)
                    elseif item.target == "ally" then
                        Game.battle:setState("PARTYSELECT", "ITEM")
                    elseif item.target == "enemy" then
                        Game.battle:setState("ENEMYSELECT", "ITEM")
                    elseif item.target == "party" then
                        Game.battle:pushAction("ITEM", Game.battle.party, menu_item)
                    elseif item.target == "enemies" then
                        Game.battle:pushAction("ITEM", Game.battle:getActiveEnemies(), menu_item)
                    end
                end
            })
        end
        if #Game.battle.menu_items > 0 then
            Game.battle:setState("MENUSELECT", "ITEM")
        end
    elseif self.type == "spare" then
        local battle_leader = 1
        if Kristal.getLibConfig("better_battles", "dynamic_battle_leader") then
            for i,battler in ipairs(Game.battle.party) do
                if not battler.is_down then
                    battle_leader = i
                    break
                end
            end
        end
		if self.battler == Game.battle.party[battle_leader] and Kristal.getLibConfig("better_battles", "spare_tactics") then
			Game.battle:clearMenuItems()
			local sparable = false
			for k,v in pairs(Game.battle:getActiveEnemies()) do
				if v.mercy >= 100 then
					sparable = true
					break
				end
			end
			Game.battle:addMenuItem({
                ["name"] = "Spare",
                ["unusable"] = false,
                ["description"] = "",
				["color"] = sparable and {1, 1, 0, 1} or {1, 1, 1, 1},
                ["callback"] = function(menu_item)
                    Game.battle:setState("ENEMYSELECT", "SPARE")
                end
            })
			local party = {}
			local party_up = {}
			for k,chara in ipairs(Game.party) do
                table.insert(party, chara.id)
                if not Game.battle.party[k].is_down then
                    table.insert(party_up, chara.id)
                end
            end
			Game.battle:addMenuItem({
                ["name"] = "Flee",
                ["unusable"] = not Game.battle.encounter.flee,
                ["description"] = Game.battle.encounter.flee and "" or "Can't\nEscape",
				["party"] = Game.battle.encounter.flee and (Kristal.getLibConfig("better_battles", "down_flee") and party_up or party) or {},
                ["callback"] = function(menu_item)
					if (love.math.random(1,100) < Game.battle.encounter.flee_chance) then
						Game.battle:setState("FLEE")
					else
						Game.battle:setState("ENEMYDIALOGUE", "FLEE")
                        Game.battle.current_selecting = 0
					end
                end
            })
			if #Game.battle.party >= Kristal.getLibConfig("better_battles", "minimum_spare_all") then
				Game.battle:addMenuItem({
					["name"] = "Spare All",
					["unusable"] = (#party_up < Kristal.getLibConfig("better_battles", "minimum_spare_all")),
					["description"] = "Spare\nEveryone",
					["color"] = sparable and {1, 1, 0, 1} or {1, 1, 1, 1},
					["tp"] = 16,
					["party"] = (Kristal.getLibConfig("better_battles", "down_spare_all") and party_up or party),
					["callback"] = function(menu_item)
						Game:removeTension(16)
                        Game.battle.current_selecting = 0
                        for i,battler in pairs(Game.battle.party) do
                            if not battler.is_down and i ~= battle_leader then
                                battler:setAnimation("battle/spare")
                            elseif i == battle_leader then
                                    battler:setAnimation("battle/spare", function()
                                    for _,enemy in pairs(Game.battle:getActiveEnemies()) do
                                        if not enemy:onMercy(battler, true) then enemy:mercyFlash() end
                                    end
                                end)
                            end
                        end
                        Game.battle:battleText("* You spared everyone!", function()
                            Game.battle:setState("ENEMYDIALOGUE", "SPAREALL")
                            return true
                        end)
					end
				})
			end
			Game.battle:setState("MENUSELECT", "SPARE")
		else
			Game.battle:setState("ENEMYSELECT", "SPARE")
		end
    elseif self.type == "defend" then
        Game.battle:pushAction("DEFEND", nil, {tp = -16})
    elseif self.type == "skill" then
        Game.battle:clearMenuItems()

        for id, action in ipairs(self.battler.chara:getSkills()) do
            Game.battle:addMenuItem({
                ["name"] = action[1],
                ["description"] = action[2],
                ["color"] = action[3],
                ["callback"] = action[4]
            })
        end

        Game.battle:setState("MENUSELECT", "SKILL")
    end
end

function ActionButton:hasSpecial()
    if self.type == "magic" or self.type == "skill" then
        if self.battler then
            local has_tired = false
            for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
                if enemy.tired then
                    has_tired = true
                    break
                end
            end
            if has_tired then
                local has_pacify = false
                for _,spell in ipairs(self.battler.chara:getSpells()) do
                    if spell and spell:hasTag("spare_tired") then
                        if spell:isUsable(self.battler.chara) and spell:getTPCost(self.battler.chara) <= Game:getTension() then
                            has_pacify = true
                            break
                        end
                    end
                end
                return has_pacify
            end
        end
    elseif self.type == "spare" then
        for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
            if enemy.mercy >= 100 then
                return true
            end
        end
    end
    return false
end

return ActionButton