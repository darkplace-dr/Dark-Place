local LightActionButton, super = Class(Object)

function LightActionButton:init(type, battler, x, y)
    super.init(self, x, y)

    self.type = type
    self.battler = battler
    
    if Kristal.getLibConfig("magical-glass", "action_button_style") == "deltatraveler" and Assets.getTexture("ui/lightbattle/btn/alt/" .. type) then
        self.tex = Assets.getTexture("ui/lightbattle/btn/alt/" .. type)
        self.hover_tex = Assets.getTexture("ui/lightbattle/btn/alt/" .. type .. "_h")
        self.special_tex = Assets.getTexture("ui/lightbattle/btn/alt/" .. type .. "_a")
    else
        self.tex = Assets.getTexture("ui/lightbattle/btn/" .. type)
        self.hover_tex = Assets.getTexture("ui/lightbattle/btn/" .. type .. "_h")
        self.special_tex = Assets.getTexture("ui/lightbattle/btn/" .. type .. "_a")
    end

    self.width = self.tex:getWidth()
    self.height = self.tex:getHeight()

    self:setOriginExact(self.width / 2, 13)

    self.hovered = false
    self.selectable = true

    self.highlight = Kristal.getLibConfig("magical-glass", "action_button_flash")
end

function LightActionButton:select()
    Game.battle.current_menu_columns = nil
    Game.battle.current_menu_rows = nil

    if Game.battle.encounter:onActionSelect(self.battler, self) then return end
    if Kristal.callEvent("onActionSelect", self.battler, self) then return end

    if self.type == "fight" then
        Game.battle:setState("ENEMYSELECT", "ATTACK")
    elseif self.type == "act" then
        Game.battle:setState("ENEMYSELECT", "ACT")
        -- todo: mini party member shit
    elseif self.type == "spell" then
        Game.battle:clearMenuItems()
        Game.battle.current_menu_columns = 2
        Game.battle.current_menu_rows = 3

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
                ["color"] = { self.battler.chara:getXActColor() },
                ["data"] = spell,
                ["callback"] = function(menu_item)
                    Game.battle.selected_xaction = spell
                    Game.battle:setState("ENEMYSELECT", "XACT")
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
                    ["color"] = action.color or { 1, 1, 1, 1 },
                    ["data"] = spell,
                    ["callback"] = function(menu_item)
                        Game.battle.selected_xaction = spell
                        Game.battle:setState("ENEMYSELECT", "XACT")
                    end
                })
            end
        end

        -- Now, register SPELLs as menu items.
        for _, spell in ipairs(self.battler.chara:getSpells()) do
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
    elseif self.type == "item" then
        Game.battle.current_menu_columns = 2
        Game.battle.current_menu_rows = 2
        Game.battle:clearMenuItems()
        for i, item in ipairs(Game.inventory:getStorage("items")) do
            Game.battle:addMenuItem({
                ["name"] = item:getName(),
                ["shortname"] = item.short_name,
                ["seriousname"] = item.serious_name,
                ["unusable"] = item.usable_in ~= "all" and item.usable_in ~= "battle",
                ["description"] = item:getBattleDescription(),
                ["data"] = item,
                ["callback"] = function(menu_item)
                    Game.battle.selected_item = menu_item

                    if not item.target or item.target == "none" then
                        Game.battle:pushAction("ITEM", nil, menu_item)
                    elseif item.target == "ally" and #Game.battle.party == 1 then
                        Game.battle:pushAction("ITEM", Game.battle.party[1], menu_item)
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
    elseif self.type == "mercy" then
        Game.battle.current_menu_columns = 1
        Game.battle.current_menu_rows = 3
        Game.battle:clearMenuItems()
        Game.battle:addMenuItem({
            ["name"] = "Spare",
            ["special"] = "spare",
            ["callback"] = function(menu_item)
                Game.battle:pushAction("SPARE", Game.battle:getActiveEnemies())
            end
        })
        if Kristal.getLibConfig("magical-glass", "light_battle_defend_btn") then
            Game.battle:addMenuItem({
                ["name"] = "Defend",
                ["special"] = "defend",
                ["callback"] = function(menu_item)
                    Game.battle:toggleSoul(false)
                    Game.battle:pushAction("DEFEND", nil, {tp = Game.battle.tension_bar.visible and -16 or 0})
                end
            })
        end
        if Game.battle.encounter.can_flee then
            Game.battle:addMenuItem({
                ["name"] = "Flee",
                ["special"] = "flee",
                ["callback"] = function(menu, item)
                    local chance = Game.battle.encounter.flee_chance

                    for _,party in ipairs(Game.battle.party) do
                        for _,equip in ipairs(party.chara:getEquipment()) do
                            chance = chance + (equip.getFleeBonus and equip:getFleeBonus() or 0)
                        end
                    end

                    if chance > 50 then
                        Game.battle:setState("FLEEING")
                    else
                        Game.battle:playSelectSound()
                        Game.battle:setState("FLEEFAIL")
                    end
                end
            })
        end
        Game.battle:setState("MENUSELECT", "MERCY")
    -- this is meant to be Send
    elseif self.type == "send" then
        Game.battle.current_menu_columns = 1
        Game.battle.current_menu_rows = 3
        Game.battle:clearMenuItems()
        Game.battle:addMenuItem({
            ["name"] = "Send",
            ["special"] = "spare",
            ["callback"] = function(menu_item)
                Game.battle:pushAction("SPARE", Game.battle:getActiveEnemies())
            end
        })
        if Kristal.getLibConfig("magical-glass", "light_battle_defend_btn") then
            Game.battle:addMenuItem({
                ["name"] = "Defend",
                ["special"] = "defend",
                ["callback"] = function(menu_item)
                    Game.battle:toggleSoul(false)
                    Game.battle:pushAction("DEFEND", nil, {tp = Game.battle.tension_bar.visible and -16 or 0})
                end
            })
        end
        if Game.battle.encounter.can_flee then
            Game.battle:addMenuItem({
                ["name"] = "Fly",
                ["special"] = "flee",
                ["callback"] = function(menu, item)
                    local chance = Game.battle.encounter.flee_chance

                    for _,party in ipairs(Game.battle.party) do
                        for _,equip in ipairs(party.chara:getEquipment()) do
                            chance = chance + (equip.getFleeBonus and equip:getFleeBonus() or 0)
                        end
                    end

                    if chance > 50 then
                        Game.battle:setState("FLEEING")
                    else
                        Game.battle:playSelectSound()
                        Game.battle:setState("FLEEFAIL")
                    end
                end
            })
        end
        Game.battle:setState("MENUSELECT", "SEND")
    elseif self.type == "defend" then
        Assets.playSound("scott_here")
    elseif self.type == "croak" then
        Assets.stopAndPlaySound("croak", nil, 0.8 + Utils.random(0.4))

        local bubble = Sprite("croak", nil, nil, nil, nil, "party/you")
        bubble:setOriginExact(60, 23) -- center??
        bubble:setPosition(Game.battle.soul.width/2 + 8.5, -20.5)
        bubble.physics.speed_y = -0.8
        bubble:fadeOutSpeedAndRemove(0.065)
		bubble.layer = 9999
        self:addChild(bubble)
    elseif self.type == "skill" then
        Game.battle.current_menu_columns = 2
        Game.battle.current_menu_rows = 2
        Game.battle:clearMenuItems()

        for id, action in ipairs(self.battler.chara:getLightSkills()) do
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

function LightActionButton:unselect()
    -- Do nothing ?
end

function LightActionButton:hasSpecial()
    if self.highlight then
        if self.type == "spell" then
            if self.battler then
                local has_tired = false
                for _, enemy in ipairs(Game.battle:getActiveEnemies()) do
                    if enemy.tired then
                        has_tired = true
                        break
                    end
                end
                if has_tired then
                    local has_pacify = false
                    for _, spell in ipairs(self.battler.chara:getSpells()) do
                        if spell and spell:hasTag("spare_tired") then
                            has_pacify = true
                            break
                        end
                    end
                    return has_pacify
                end
            end
        elseif self.type == "mercy" then
            for _, enemy in ipairs(Game.battle:getActiveEnemies()) do
                if enemy.mercy >= 100 then
                    return true
                end
            end
        end
    end
    return false
end

function LightActionButton:draw()
    if self.selectable and self.hovered then
        love.graphics.draw(self.hover_tex or self.tex)
    else
        love.graphics.draw(self.tex)
        if self.selectable and self.special_tex and self:hasSpecial() then
            local r, g, b, a = self:getDrawColor()
            love.graphics.setColor(r, g, b, a * (0.4 + math.sin((Kristal.getTime() * 30) / 6) * 0.4))
            love.graphics.draw(self.special_tex)
        end
    end

    super.draw(self)
end

return LightActionButton
