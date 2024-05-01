local LightBattleUI, super = Class(Object)

function LightBattleUI:init()
    super.init(self, 0, 270)

    self.layer = BATTLE_LAYERS["ui"]

    self.current_encounter_text = Game.battle.encounter.text

    self.arena = Game.battle.arena

    self.style = Kristal.getLibConfig("magical-glass", "gauge_style")
    self.draw_mercy = Kristal.getLibConfig("magical-glass", "mercy_bar")
    self.draw_percents = Kristal.getLibConfig("magical-glass", "enemy_bar_percentages")

    self.encounter_text = Textbox(14, 17, SCREEN_WIDTH - 30, SCREEN_HEIGHT - 53, "main_mono", nil, true)
    self.encounter_text.text.default_sound = "ut"
    self.encounter_text.text.hold_skip = false
    self.encounter_text.text.line_offset = 5
    self.encounter_text.text.style = "none"
    self.encounter_text:setText("")
    self.encounter_text.debug_rect = {-30, -12, SCREEN_WIDTH+1, 124}
    Game.battle.arena:addChild(self.encounter_text)

    self.choice_box = Choicebox(56, 49, 529, 103, true)
    self.choice_box.active = false
    self.choice_box.visible = false
    Game.battle.arena:addChild(self.choice_box)

    self.text_choice_box = TextChoicebox(14, 17, SCREEN_WIDTH - 30, SCREEN_HEIGHT - 53, default_font, default_font_size, true)
    self.text_choice_box:setText("")
    self.text_choice_box.active = false
    self.text_choice_box.visible = false
    Game.battle.arena:addChild(self.text_choice_box)

    self.short_act_text_1 = DialogueText("", 14, 15, SCREEN_WIDTH - 30, SCREEN_HEIGHT - 53, {wrap = false, line_offset = 0})
    self.short_act_text_2 = DialogueText("", 14, 15 + 30, SCREEN_WIDTH - 30, SCREEN_HEIGHT - 53, {wrap = false, line_offset = 0})
    self.short_act_text_3 = DialogueText("", 14, 15 + 30 + 30, SCREEN_WIDTH - 30, SCREEN_HEIGHT - 53, {wrap = false, line_offset = 0})
    Game.battle.arena:addChild(self.short_act_text_1)
    Game.battle.arena:addChild(self.short_act_text_2)
    Game.battle.arena:addChild(self.short_act_text_3)

    -- active: 237
    -- inactive: 280
    if Kristal.getLibConfig("magical-glass", "item_info") == "deltatraveler" then
        self.help_window = HelpWindow(SCREEN_WIDTH/2, 280) -- height is 99px in dt
        self.help_window.layer = self.arena.layer - 10
        Game.battle:addChild(self.help_window)
    end

    self.attack_box = nil
    self.action_boxes = {}
    
    self.attacking = false

    for i,battler in ipairs(Game.battle.party) do
        self.action_box_ut = LightActionBox(20, 0, i, battler)
        self.action_box_ut.layer = BATTLE_LAYERS["below_ui"]
        self.action_box_ut:move(self:getRelativePos())
        Game.battle:addChild(self.action_box_ut)
        table.insert(self.action_boxes, self.action_box_ut)
        battler.chara:onActionBox(self.action_box_ut, false)
    end

    self.shown = true 
    
    self.arrow_sprite = Assets.getTexture("ui/page_arrow_down")

    self.sparestar = Assets.getTexture("ui/battle/sparestar")
    self.tiredmark = Assets.getTexture("ui/battle/tiredmark")
    
end

function LightBattleUI:clearEncounterText()
    self.encounter_text:setActor(nil)
    self.encounter_text:setFace(nil)
    self.encounter_text:setFont()
    self.encounter_text:setAlign("left")
    self.encounter_text:setSkippable(true)
    self.encounter_text:setAdvance(true)
    self.encounter_text:setAuto(false)
    self.encounter_text:setText("")
end

function LightBattleUI:beginAttack()
    Game.battle.current_selecting = 0

    local attack_order = Utils.pickMultiple(Game.battle.normal_attackers, #Game.battle.normal_attackers)

    local last_offset = -1
    local offset = 0

    self.attack_box = LightAttackBox(self.arena.width / 2, self.arena.height / 2)
    self.arena:addChild(self.attack_box)

    self.attacking = true
end

function LightBattleUI:endAttack()
    if not Game.battle:retargetEnemy() then
        Game.battle.cancel_attack = true
    else
        self.attack_box.fading = true
    end

    for _,lane in ipairs(self.attack_box.lanes) do
        for _,bolt in ipairs(lane.bolts) do
            bolt:remove()
        end
    end

    self.attacking = false
end

function LightBattleUI:drawActionArea()
    self:drawState()
end

function LightBattleUI:drawState()
    local state = Game.battle.state
    if state == "MENUSELECT" then
        local page = Game.battle:isPagerMenu() and math.ceil(Game.battle.current_menu_x / Game.battle.current_menu_columns) - 1 or math.ceil(Game.battle.current_menu_y / Game.battle.current_menu_rows) - 1
        local max_page = math.ceil(#Game.battle.menu_items / (Game.battle.current_menu_columns * Game.battle.current_menu_rows)) - 1

        local x = 0
        local y = 0

        local menu_offsets = { -- {soul, text}
            ["ACT"] = {12, 16},
            ["ITEM"] = {0, 0},
            ["SPELL"] = {12, 16},
            ["MERCY"] = {0, 0}, --doesn't matter lmao
        }

        for lib_id,_ in Kristal.iterLibraries() do
            menu_offsets = Kristal.libCall(lib_id, "getLightBattleMenuOffsets", menu_offsets) or menu_offsets
        end
        menu_offsets = Kristal.modCall("getLightBattleMenuOffsets", menu_offsets) or menu_offsets

        local extra_offset
        for name, offset in pairs(menu_offsets) do
            if name == Game.battle.state_reason then
                extra_offset = offset
            end
        end

        if Game.battle:isPagerMenu() then
            Game.battle.soul:setPosition(72 + ((Game.battle.current_menu_x - 1 - (page * 2)) * (248 + extra_offset[1])), 255 + ((Game.battle.current_menu_y) * 31.5))
        else
            Game.battle.soul:setPosition(72 + ((Game.battle.current_menu_x - 1) * (248 + extra_offset[1])), 255 + ((Game.battle.current_menu_y - (page * Game.battle.current_menu_rows)) * 31.5))
        end

        local font = Assets.getFont("main_mono")
        love.graphics.setFont(font, 32)

        local col = Game.battle.current_menu_columns
        local row = Game.battle.current_menu_rows
        local draw_amount = col * row

        local page_offset = page * draw_amount
        
        for i = page_offset + 1, math.min(page_offset + draw_amount, #Game.battle.menu_items) do
            local item = Game.battle.menu_items[i]

            Draw.setColor(1, 1, 1, 1)
            local text_offset = 0
            local able = Game.battle:canSelectMenuItem(item)
            
            -- Head counter
            local heads = 0
            if item.party then
                for index, party_id in ipairs(item.party) do
                    local chara = Game:getPartyMember(party_id)
                    if Game.battle:getPartyIndex(party_id) ~= Game.battle.current_selecting then
                        heads = heads + 1
                    end
                end
                if not able then
                    Draw.setColor(COLORS.gray)
                end

                if heads <= 1 then
                    for index, party_id in ipairs(item.party) do
                        local chara = Game:getPartyMember(party_id)

                        if Game.battle:getPartyIndex(party_id) ~= Game.battle.current_selecting then
                            local ox, oy = chara:getHeadIconOffset()
                            Draw.draw(Assets.getTexture(chara:getHeadIcons() .. "/head"), text_offset + 92 + (x * (240 + extra_offset[2])) + ox, 5 + (y * 32) + oy)
                            text_offset = text_offset + 37
                        end
                    end
                else
                    for index, party_id in ipairs(item.party) do
                        local chara = Game:getPartyMember(party_id)
                        -- Draw head only if it isn't the currently selected character
                        if Game.battle:getPartyIndex(party_id) ~= Game.battle.current_selecting then
                            local ox, oy = chara:getHeadIconOffset()
                            Draw.draw(Assets.getTexture(chara:getHeadIcons() .. "/head"), text_offset + 92 + (x * (240 + extra_offset[2])) + ox, 5 + (y * 32) + oy)
                            text_offset = text_offset + 30
                        end
                    end
                end
            end

            if item.icons then
                if not able then
                    Draw.setColor(COLORS.gray)
                end

                for _, icon in ipairs(item.icons) do
                    if type(icon) == "string" then
                        icon = {icon, false, 0, 0, nil}
                    end
                    if not icon[2] then
                        local texture = Assets.getTexture(icon[1])
                        Draw.draw(texture, text_offset + 102 + (x * (240 + extra_offset[2])) + (icon[3] or 0), 50 + (y * 32) + (icon[4] or 0))
                        text_offset = text_offset + (icon[5] or texture:getWidth())
                    end
                end
            end

            if able then
                Draw.setColor(item.color or {1, 1, 1, 1})
            else
                Draw.setColor(COLORS.gray)
            end

            for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
                if enemy.mercy >= 100 and item.special == "spare" then
                    love.graphics.setColor(MagicalGlassLib.name_color)
                end
            end

            local name = item.name
            if item.seriousname and MagicalGlassLib.serious_mode then
                name = item.seriousname
            elseif item.shortname then
                name = item.shortname
            end

            if heads > 0 then
--[[                 self.menuselect_options[i]:setText(name)
                self.menuselect_options[i]:setPosition(text_offset + 67 + (x * (240 + extra_offset[2])), 15 + (y * 32)) ]]
                love.graphics.print(name, text_offset + 95 + (x * (240 + extra_offset[2])), (y * 32))
            else
--[[                 self.menuselect_options[i]:setText("* " .. name)
                self.menuselect_options[i]:setPosition(text_offset + 62 + (x * (240 + extra_offset[2])), 15 + (y * 32)) ]]
                love.graphics.print("* " .. name, text_offset + 100 + (x * (240 + extra_offset[2])), (y * 32))
            end

            text_offset = text_offset + font:getWidth(item.name)

            if item.icons then
                if able then
                    Draw.setColor(1, 1, 1)
                end

                for _, icon in ipairs(item.icons) do
                    if type(icon) == "string" then
                        icon = {icon, false, 0, 0, nil}
                    end
                    if icon[2] then
                        local texture = Assets.getTexture(icon[1])
                        Draw.draw(texture, text_offset + 30 + (x * 230) + (icon[3] or 0), 50 + (y * 30) + (icon[4] or 0))
                        text_offset = text_offset + (icon[5] or texture:getWidth())
                    end
                end
            end

            if Game.battle.current_menu_columns == 1 then
                if x == 0 then
                    y = y + 1
                end
            else
                if x == 0 then
                    x = 1
                else
                    x = 0
                    y = y + 1
                end
            end

        end

        local tp_offset = 0
        local current_item = Game.battle.menu_items[Game.battle:getItemIndex()] or Game.battle.menu_items[1] -- crash prevention in case of an invalid option
        if current_item.description then
            if self.help_window then
                self.help_window:setDescription(current_item.description)
            elseif Kristal.getLibConfig("magical-glass", "item_info") == "magical_glass" then
                Draw.setColor(COLORS.gray)
                local str = current_item.description:gsub('\n', ' ')
                love.graphics.print(str, 100 - 16, 64)
            end
        end

        if current_item.tp and current_item.tp ~= 0 then
            if self.help_window then
                self.help_window:setTension(current_item.tp)
                Game:setTensionPreview(current_item.tp)
            elseif Kristal.getLibConfig("magical-glass", "item_info") == "magical_glass" then
                Draw.setColor(PALETTE["tension_desc"])
                love.graphics.print(math.floor((current_item.tp / Game:getMaxTension()) * 100) .. "% "..Game:getConfig("tpName"), 260 + 208, 64)
                Game:setTensionPreview(current_item.tp)
            end
        else
            Game:setTensionPreview(0)
        end

        Draw.setColor(1, 1, 1, 1)

        if Game.battle:isPagerMenu() then
            love.graphics.print("PAGE " .. page + 1, 388, 64)
        else
            if page < max_page then
                Draw.draw(self.arrow_sprite, 45, 90 + (math.sin(Kristal.getTime()*6) * 2))
            end
            if page > 0 then
                Draw.draw(self.arrow_sprite, 45, 10 - (math.sin(Kristal.getTime()*6) * 2), 0, 1, -1)
            end
        end

    elseif state == "ENEMYSELECT" then
        --self:clearMenuText()

        local enemies = Game.battle.enemies_index
        local reason = Game.battle.state_reason

        local page = math.ceil(Game.battle.current_menu_y / 3) - 1
        local max_page = math.ceil(#enemies / 3) - 1
        local page_offset = page * 3

        Game.battle.soul:setPosition(72, 255 + ((Game.battle.current_menu_y - (page * 3)) * 31.5))
        local font_main = Assets.getFont("main")
        local font_mono = Assets.getFont("main_mono")
        local font_status = Assets.getFont("battlehud")

        Draw.setColor(1, 1, 1, 1)

        if self.draw_mercy then
            if self.style == "deltarune" then
                love.graphics.setFont(font_main)
                if Game.battle.state_reason ~= "XACT" then
                    love.graphics.print("HP", 400, -10, 0, 1, 0.5)
                end
                love.graphics.print("MERCY", 500, -10, 0, 1, 0.5)
            elseif self.style == "deltatraveler" then
                love.graphics.setFont(font_main)
                if Game.battle.state_reason ~= "XACT" then
                    love.graphics.print("HP", 412, -15, 0, 1, 0.75)
                end
                love.graphics.print("MERCY", 502, -15, 0, 1, 0.75)
            end
        end

        love.graphics.setFont(font_mono)
        
        local letters = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}
        local enemy_counter = {}
        
        for _,enemy in pairs(enemies) do
            if enemy then
                enemy_counter[enemy.id] = 0
            end
        end
        
        for _,enemy in pairs(enemies) do
            if enemy then
                enemy_counter[enemy.id] = enemy_counter[enemy.id] + 1
                if not enemy.index and enemy_counter[enemy.id] <= math.pow(#letters, 2) + #letters then
                    if enemy_counter[enemy.id] > #letters then
                        enemy.index = letters[math.floor((enemy_counter[enemy.id] - 1) / #letters)] .. letters[enemy_counter[enemy.id] - #letters * math.floor((enemy_counter[enemy.id] - 1) / #letters)]
                    else
                        enemy.index = letters[enemy_counter[enemy.id]]
                    end
                end
            end
        end
        
        for index = page_offset + 1, math.min(page_offset + 3, #enemies) do
        
            love.graphics.setFont(font_mono)
            
            local enemy = enemies[index]
            local y_offset = (index - page_offset - 1) * 32

            if enemy then
                local name_colors = enemy:getNameColors()
                if type(name_colors) ~= "table" then
                    name_colors = {name_colors}
                end

                local name = "* " .. enemy.name
                if enemy_counter[enemy.id] > 1 and enemy.index then
                    name = name .. " " .. enemy.index
                end

                if #name_colors <= 1 then
                    Draw.setColor(name_colors[1] or enemy.selectable and {1, 1, 1} or {0.5, 0.5, 0.5})
                    love.graphics.print(name, 100, 0 + y_offset)
                else
                    local canvas = Draw.pushCanvas(font_mono:getWidth(name), font_mono:getHeight())
                    Draw.setColor(1, 1, 1)
                    love.graphics.print(name)
                    Draw.popCanvas()

                    local color_canvas = Draw.pushCanvas(#name_colors, 1)
                    for i = 1, #name_colors do
                        -- Draw a pixel for the color
                        Draw.setColor(name_colors[i])
                        love.graphics.rectangle("fill", i-1, 0, 1, 1)
                    end
                    Draw.popCanvas()

                    Draw.setColor(1, 1, 1)

                    local shader = Kristal.Shaders["DynGradient"]
                    love.graphics.setShader(shader)
                    shader:send("colors", color_canvas)
                    shader:send("colorSize", {#name_colors, 1})
                    Draw.draw(canvas, 100, 0 + y_offset)
                    love.graphics.setShader()
                end
                
                Draw.setColor(1, 1, 1)

                if self.style ~= "undertale" then
                    local spare_icon = false
                    local tired_icon = false

                    if enemy.tired and enemy:canSpare() then
                        Draw.draw(self.sparestar, 100 + font_mono:getWidth(name) + 10, 10 + y_offset)
                        spare_icon = true
                        
                        Draw.draw(self.tiredmark, 100 + font_mono:getWidth(name) + 30, 10 + y_offset)
                        tired_icon = true
                    elseif enemy.tired then
                        Draw.draw(self.tiredmark, 100 + font_mono:getWidth(name) + 30, 10 + y_offset)
                        tired_icon = true
                    elseif enemy.mercy >= 100 then
                        Draw.draw(self.sparestar, 100 + font_mono:getWidth(name) + 10, 10 + y_offset)
                        spare_icon = true
                    end

                    for i = 1, #enemy.icons do
                        if enemy.icons[i] then
                            if (spare_icon and (i == 1)) or (tired_icon and (i == 2)) then
                                -- Skip the custom icons if we're already drawing spare/tired ones
                            else
                                Draw.setColor(1, 1, 1, 1)
                                Draw.draw(enemy.icons[i], 60 + font:getWidth(name) + (i * 20), 60 + y_off)
                            end
                        end
                    end
                end
                
                if Game.battle.state_reason == "XACT" then
                    Draw.setColor(Game.battle.party[Game.battle.current_selecting].chara:getXActColor())
                    if Game.battle.selected_xaction.id == 0 then
                        love.graphics.print(enemy:getXAction(Game.battle.party[Game.battle.current_selecting]), 322, y_offset)
                    else
                        love.graphics.print(Game.battle.selected_xaction.name, 322, y_offset)
                    end
                elseif self.style ~= "undertale" then
                    local namewidth = font_mono:getWidth(enemy.name)

                    Draw.setColor(128/255, 128/255, 128/255, 1)

                    if ((80 + namewidth + 110 + (font_mono:getWidth(enemy.comment) / 2)) < 338) then
                        love.graphics.print(enemy.comment, 80 + namewidth + 110, 0 + y_offset)
                    else
                        love.graphics.print(enemy.comment, 80 + namewidth + 110, 0 + y_offset, 0, 0.5, 1)
                    end
                end

                local hp_percent = enemy.health / enemy.max_health

                if self.style == "undertale" then
                    local name_length = 0
                    for _,enemy in ipairs(enemies) do
                        if enemy and string.len(enemy.name) > name_length then
                            name_length = string.len(enemy.name)
                        end
                    end
                    local hp_x = 190 + (name_length * 16)
                    if Game.battle.state_reason ~= "ACT" and Game.battle.state_reason ~= "SPARE" and Game.battle.state_reason ~= "XACT" then
                        if enemy:getHPVisibility() and enemy.selectable then
                            Draw.setColor(PALETTE["action_health_bg_ut"])
                            love.graphics.rectangle("fill", hp_x, 10 + y_offset, 101, 17)

                            Draw.setColor(PALETTE["action_health"])
                            love.graphics.rectangle("fill", hp_x, 10 + y_offset, math.max(0,math.ceil(hp_percent),math.floor(hp_percent * 101)), 17)
                            if self.draw_percents then
                                love.graphics.setFont(font_status)
                                local shadow_offset = 1

                                Draw.setColor(COLORS.black)
                                love.graphics.printf(math.max(0,math.ceil(hp_percent),math.floor(hp_percent * 100)) .. "%", (hp_x + 19) + shadow_offset, (9 + y_offset) + shadow_offset, 64, "center")

                                Draw.setColor(PALETTE["action_health_text"])
                                love.graphics.printf(math.max(0,math.ceil(hp_percent),math.floor(hp_percent * 100)) .. "%", hp_x + 19, 9 + y_offset, 64, "center")
                            end
                        end
                    else
                        local mercy_x = Game.battle.state_reason == "XACT" and 480 or hp_x
                        if self.draw_mercy and enemy:getMercyVisibility() then
                            if enemy.selectable then
                                Draw.setColor(PALETTE["battle_mercy_bg"])
                            else
                                Draw.setColor(127/255, 127/255, 127/255, 1)
                            end
                            
                            love.graphics.rectangle("fill", mercy_x, 10 + y_offset, 101, 17)
                            
                            if enemy.disable_mercy then
                                Draw.setColor(PALETTE["battle_mercy_text"])
                                love.graphics.setLineWidth(2)
                                love.graphics.line(mercy_x, 11 + y_offset, mercy_x + 101, 10 + y_offset + 17 - 1)
                                love.graphics.line(mercy_x, 10 + y_offset + 17 - 1, mercy_x + 101, 11 + y_offset)
                            else
                                Draw.setColor(1, 1, 0, 1)
                                love.graphics.rectangle("fill", mercy_x, 10 + y_offset, ((enemy.mercy / 100) * 101), 17)
                                if self.draw_percents and enemy.selectable then
                                    love.graphics.setFont(font_status)
                                    local shadow_offset = 1

                                    Draw.setColor(COLORS.black)
                                    love.graphics.printf(math.floor(enemy.mercy) .. "%", (mercy_x + 19) + shadow_offset, (9 + y_offset) + shadow_offset, 64, "center")

                                    Draw.setColor(PALETTE["battle_mercy_text"])
                                    love.graphics.printf(math.floor(enemy.mercy) .. "%", mercy_x + 19, 9 + y_offset, 64, "center")
                                end
                            end
                        end
                    end
                elseif self.style == "deltarune" then
                    local hp_x = self.draw_mercy and 400 or 500
                    if enemy.selectable and Game.battle.state_reason ~= "XACT" then
                        if enemy:getHPVisibility() then
                            Draw.setColor(PALETTE["action_health_bg_ut"])
                            love.graphics.rectangle("fill", hp_x, 10 + y_offset, 81, 16)
        
                            Draw.setColor(PALETTE["action_health"])
                            love.graphics.rectangle("fill", hp_x, 10 + y_offset, math.max(0,math.ceil(hp_percent),math.floor(hp_percent * 81)), 16)
                        else
                            Draw.setColor(PALETTE["action_health"])
                            love.graphics.rectangle("fill", hp_x, 10 + y_offset, 81, 16)
                        end
                        
                        if self.draw_percents then
                            Draw.setColor(PALETTE["action_health_text"])
                            if enemy:getHPVisibility() then
                                love.graphics.print(math.max(0,math.ceil(hp_percent),math.floor(hp_percent * 100)) .. "%", hp_x + 4, 10 + y_offset, 0, 1, 0.5)
                            else
                                love.graphics.print("???", hp_x + 4, 10 + y_offset, 0, 1, 0.5)
                            end
                        end
                    end
                    
                    if self.draw_mercy then
                        if enemy.selectable then
                            Draw.setColor(PALETTE["battle_mercy_bg"])
                        else
                            Draw.setColor(127/255, 127/255, 127/255, 1)
                        end
                        
                        love.graphics.rectangle("fill", 500, 10 + y_offset, 81, 16)
                        
                        if enemy.disable_mercy then
                            Draw.setColor(PALETTE["battle_mercy_text"])
                            love.graphics.setLineWidth(2)
                            love.graphics.line(500, 11 + y_offset, 500 + 81, 10 + y_offset + 16 - 1)
                            love.graphics.line(500, 10 + y_offset + 16 - 1, 500 + 81, 11 + y_offset)
                        else
                            if enemy:getMercyVisibility() then
                                Draw.setColor(1, 1, 0, 1)
                                love.graphics.rectangle("fill", 500, 10 + y_offset, ((enemy.mercy / 100) * 81), 16)
                            end
                            
                            if self.draw_percents and enemy.selectable then
                                Draw.setColor(PALETTE["battle_mercy_text"])
                                if enemy:getMercyVisibility() then
                                    love.graphics.print(math.floor(enemy.mercy) .. "%", 500 + 4, 10 + y_offset, 0, 1, 0.5)
                                else
                                    love.graphics.print("???", 500 + 4, 10 + y_offset, 0, 1, 0.5)
                                end
                            end
                        end
                    end
                elseif self.style == "deltatraveler" then
                    local hp_x = self.draw_mercy and 400 or 500
                    if enemy.selectable and Game.battle.state_reason ~= "XACT" then
                        if enemy:getHPVisibility() then
                            Draw.setColor(PALETTE["action_health_bg_ut"])
                            love.graphics.rectangle("fill", hp_x + 12, 11 + y_offset, 75, 17)
        
                            Draw.setColor(PALETTE["action_health"])
                            love.graphics.rectangle("fill", hp_x + 12, 11 + y_offset, math.max(0,math.ceil(hp_percent),math.floor(hp_percent * 75)), 17)
                        else
                            Draw.setColor(PALETTE["action_health"])
                            love.graphics.rectangle("fill", hp_x + 12, 11 + y_offset, 75, 17)
                        end

                        if self.draw_percents then
                            love.graphics.setFont(font_status)
                            local shadow_offset = 1

                            Draw.setColor(COLORS.black)
                            if enemy:getHPVisibility() then
                                love.graphics.printf(math.max(0,math.ceil(hp_percent),math.floor(hp_percent * 100)) .. "%", (hp_x + 20) + shadow_offset, (10 + y_offset) + shadow_offset, 64, "center")
                            else
                                love.graphics.print("???", (hp_x + 36) + shadow_offset, (10 + y_offset) + shadow_offset)
                            end

                            Draw.setColor(PALETTE["action_health_text"])
                            if enemy:getHPVisibility() then
                                love.graphics.printf(math.max(0,math.ceil(hp_percent),math.floor(hp_percent * 100)) .. "%", hp_x + 20, 10 + y_offset, 64, "center")
                            else
                                love.graphics.print("???", hp_x + 36, 10 + y_offset)
                            end
                        end
                    end

                    if self.draw_mercy then
                        love.graphics.setFont(font_status)
                        local shadow_offset = 1

                        if enemy.selectable then
                            Draw.setColor(PALETTE["battle_mercy_bg"])
                        else
                            Draw.setColor(127/255, 127/255, 127/255, 1)
                        end

                        love.graphics.rectangle("fill", 502, 11 + y_offset, 75, 17)
        
                        if enemy.disable_mercy then
                            Draw.setColor(PALETTE["battle_mercy_text"])
                            love.graphics.setLineWidth(2)
                            love.graphics.line(502, 12 + y_offset, 502 + 75, 12 + y_offset + 16 - 1)
                            love.graphics.line(502, 12 + y_offset + 16 - 1, 502 + 75, 12 + y_offset)
                        else
                            Draw.setColor(1, 1, 0, 1)
                            if enemy:getMercyVisibility() then
                                love.graphics.rectangle("fill", 502, 11 + y_offset, ((enemy.mercy / 100) * 75), 17)
                            end
        
                            if self.draw_percents and enemy.selectable then
                                Draw.setColor(COLORS.black)
                                if enemy:getMercyVisibility() then
                                    love.graphics.printf(math.floor(enemy.mercy) .. "%", 509 + shadow_offset, (10 + y_offset) + shadow_offset, 64, "center")
                                else
                                    love.graphics.print("???", 526 + shadow_offset, (10 + y_offset) + shadow_offset)
                                end

                                Draw.setColor(PALETTE["battle_mercy_text"])
                                if enemy:getMercyVisibility() then
                                    love.graphics.printf(math.floor(enemy.mercy) .. "%", 509, 10 + y_offset, 64, "center")
                                else
                                    love.graphics.print("???", 526, 10 + y_offset)
                                end
                            end
                        end
                    end
                end
            end
        end
        
        Draw.setColor(1, 1, 1, 1)
        local arrow_down = page_offset + 3
        while true do
            arrow_down = arrow_down + 1
            if arrow_down > #enemies then
                arrow_down = false
                break
            elseif enemies[arrow_down] then
                arrow_down = true
                break
            end
        end
        local arrow_up = page_offset + 1
        while true do
            arrow_up = arrow_up - 1
            if arrow_up < 1 then
                arrow_up = false
                break
            elseif enemies[arrow_up] then
                arrow_up = true
                break
            end
        end
        if arrow_down then
            Draw.draw(self.arrow_sprite, 45, 90 + (math.sin(Kristal.getTime()*6) * 2))
        end
        if arrow_up then
            Draw.draw(self.arrow_sprite, 45, 10 - (math.sin(Kristal.getTime()*6) * 2), 0, 1, -1)
        end
    elseif state == "PARTYSELECT" then
        local page = math.ceil(Game.battle.current_menu_y / 3) - 1
        local max_page = math.ceil(#Game.battle.party / 3) - 1
        local page_offset = page * 3

        Game.battle.soul:setPosition(72, 255 + ((Game.battle.current_menu_y - (page * 3)) * 31.5))

        local font = Assets.getFont("main_mono")
        love.graphics.setFont(font)
        
        local name_length = 0
        for _,party in ipairs(Game.battle.party) do
            if string.len(party.chara.name) > name_length then
                name_length = string.len(party.chara.name)
            end
        end
        local hp_x = 190 + (name_length * 16)

        for index = page_offset + 1, math.min(page_offset + 3, #Game.battle.party) do
            Draw.setColor(1, 1, 1, 1)
            love.graphics.print("* " .. Game.battle.party[index].chara:getName(), 100, 0 + ((index - page_offset - 1) * 32))

            if self.style ~= "deltarune" then
                Draw.setColor(PALETTE["action_health_bg_ut"])
                love.graphics.rectangle("fill", hp_x, 10 + ((index - page_offset - 1) * 32), 101, 17)

                local percentage = Game.battle.party[index].chara:getHealth() / Game.battle.party[index].chara:getStat("health")
                Draw.setColor(PALETTE["action_health"])
                love.graphics.rectangle("fill", hp_x, 10 + ((index - page_offset - 1) * 32), math.max(0,math.ceil(percentage),math.floor(percentage * 101)), 17)
            else
                -- Draw.setColor(PALETTE["action_health_bg"])
                Draw.setColor(PALETTE["action_health_bg_ut"])
                love.graphics.rectangle("fill", 420, 10 + ((index - page_offset - 1) * 32), 101, 17)

                local percentage = Game.battle.party[index].chara:getHealth() / Game.battle.party[index].chara:getStat("health")
                Draw.setColor(PALETTE["action_health"])
                love.graphics.rectangle("fill", 420, 10 + ((index - page_offset - 1) * 32), math.ceil(percentage * 101), 17)
            end
        end
        
        Draw.setColor(1, 1, 1, 1)
        
        if page < max_page then
            Draw.draw(self.arrow_sprite, 45, 90 + (math.sin(Kristal.getTime()*6) * 2))
        end
        if page > 0 then
            Draw.draw(self.arrow_sprite, 45, 10 - (math.sin(Kristal.getTime()*6) * 2), 0, 1, -1)
        end
    elseif state == "FLEEING" or state == "TRANSITIONOUT" then
        local font = Assets.getFont("main_mono")
        love.graphics.setFont(font, 32)
        local message = Game.battle.encounter:getUsedFleeMessage() or ""

        Draw.setColor(1, 1, 1, 1)
        love.graphics.print(message, 100, 0)
    end

end

function LightBattleUI:draw()
    self:drawState()
    super.draw(self)
end

return LightBattleUI