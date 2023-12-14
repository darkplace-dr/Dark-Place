---@class SaveMenu : Object
---@overload fun(...) : SaveMenu
local SaveMenu, super = Class(Object)

function SaveMenu:init(save_id, marker)
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self.parallax_x = 0
    self.parallax_y = 0

    self.draw_children_below = 0

    self.font = Assets.getFont("main")

    self.ui_select = Assets.newSound("ui_select")

    self.heart_sprite = Assets.getTexture("player/heart")
    self.divider_sprite = Assets.getTexture("ui/box/dark/top")

    self.uiheart_sprite = Assets.getTexture("ui/save/heart")
    self.uimagic_sprite = Assets.getTexture("ui/save/magic")
    self.uitime_sprite = Assets.getTexture("ui/save/time")
    self.uistat_sprite = Assets.getTexture("ui/save/status")
    self.uideath_sprite = Assets.getTexture("ui/save/knife")
    self.uimap_sprite = Assets.getTexture("ui/save/map")
    self.uimap2_sprite = Assets.getTexture("ui/save/map_b")

    --[[]]
    self.box = UIBox(140, 130, 360, 200)
    self.box.layer = -1
    self:addChild(self.box)
    --]]
    --[[
    self.box = UIBox(124, 130, 391, 154)
    self.box.layer = -1
    self:addChild(self.box)
    --]]

    self.save_box = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    self.save_box:setColor(0, 0, 0, 0.8)
    self.save_box.layer = -1
    self.save_box.visible = false
    self:addChild(self.save_box)

    self.save_header = UIBox(92, 44, 457, 42)
    self.save_box:addChild(self.save_header)

    self.save_list = UIBox(92, 156, 457, 258)
    self.save_box:addChild(self.save_list)

    self.overwrite_box = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    self.overwrite_box:setColor(0, 0, 0, 0.8)
    self.overwrite_box.layer = 1
    self.overwrite_box.visible = false
    self:addChild(self.overwrite_box)

    self.overwrite_box:addChild(UIBox(42, 132, 557, 217))

    self.marker = marker

    -- MAIN, SAVE, SAVED, OVERWRITE
    self.state = "MAIN"

    self.selected_x = 1
    self.selected_y = 1

    self.saved_file = nil

    self.saves = {}
    for i = 1, 3 do
        self.saves[i] = Kristal.getSaveFile(i)
    end
end

function SaveMenu:update()
    if self.state == "MAIN" then
        if Input.pressed("cancel") then
            self:remove()
            Game.world:closeMenu()
        end
        if Input.pressed("left") or Input.pressed("right") then
            self.selected_x = self.selected_x == 1 and 2 or 1
        end
        if Input.pressed("up") or Input.pressed("down") then
            self.selected_y = self.selected_y == 1 and 2 or 1
        end
        if Input.pressed("confirm") then
            if self.selected_x == 1 and self.selected_y == 1 then
                self.state = "SAVE"

                self.ui_select:stop()
                self.ui_select:play()

                self.selected_y = Game.save_id
                self.saved_file = nil

                self.box.visible = false
                self.save_box.visible = true
            elseif self.selected_x == 2 and self.selected_y == 1 then
                self:remove()
                Game.world:closeMenu()
            elseif self.selected_x == 1 and self.selected_y == 2 then
                if Game.inventory.storage_enabled then
                    Input.clear("confirm")
                    self:remove()
                    Game.world:closeMenu()
                    Game.world:openMenu(DarkStorageMenu())
                end
            end
        end
    elseif self.state == "SAVE" then
        if Input.pressed("cancel") then
            self.state = "MAIN"

            self.ui_select:stop()
            self.ui_select:play()

            self.selected_x = 1
            self.selected_y = 1

            self.box.visible = true
            self.save_box.visible = false
        end
        local last_selected = self.selected_y
        if Input.pressed("up") then
            self.selected_y = self.selected_y - 1
        end
        if Input.pressed("down") then
            self.selected_y = self.selected_y + 1
        end
        self.selected_y = Utils.clamp(self.selected_y, 1, 4)
        if Input.pressed("confirm") then
            self.ui_select:stop()
            self.ui_select:play()

            if self.selected_y == 4 then
                self.state = "MAIN"

                self.selected_x = 1
                self.selected_y = 1

                self.box.visible = true
                self.save_box.visible = false
            elseif self.selected_y ~= Game.save_id and self.saves[self.selected_y] then
                self.state = "OVERWRITE"

                self.overwrite_box.visible = true
            else
                self.state = "SAVED"

                self.saved_file = self.selected_y
                Kristal.saveGame(self.saved_file, Game:save(self.marker))
                self.saves[self.saved_file] = Kristal.getSaveFile(self.saved_file)

                Assets.playSound("save")
            end
        end
    elseif self.state == "SAVED" then
        if Input.pressed("cancel") or Input.pressed("confirm") then
            self:remove()
            Game.world:closeMenu()
        end
    elseif self.state == "OVERWRITE" then
        if Input.pressed("cancel") then
            self.state = "SAVE"

            self.selected_x = 1
            self.overwrite_box.visible = false
        end
        if Input.pressed("left") or Input.pressed("right") then
            self.selected_x = self.selected_x == 1 and 2 or 1
        end
        if Input.pressed("confirm") then
            if self.selected_x == 1 then
                self.state = "SAVED"

                self.saved_file = self.selected_y
                Kristal.saveGame(self.saved_file, Game:save(self.marker))
                self.saves[self.saved_file] = Kristal.getSaveFile(self.saved_file)

                Assets.playSound("save_b", 0.5)

                self.selected_x = 1
                self.overwrite_box.visible = false
            else
                self.state = "SAVE"

                self.selected_x = 1
                self.overwrite_box.visible = false
            end
        end
    end

    super.update(self)
end

--[[
function SaveMenu:draw()
    love.graphics.setFont(self.font)
    love.graphics.setColor(PALETTE["world_text"])

    local data = self.saved_file or {}
    local name
    local room_name
    local level
    if Game:isLight() then
        name      = data.name      or "GEROME"
        room_name = data.room_name or "Asriel's Room"
        level     = data.level     or 1
    else
        name      = data.name      or "[EMPTY]"
        room_name = data.room_name or "??????"
        level     = data.level     or 0
    end
    local playtime  = data.playtime  or 0

    local minutes = math.floor(playtime / 60)
    local seconds = math.floor(playtime % 60)
    local time_text = string.format("%d:%02d", minutes, seconds)

    if self.state == "SAVED" then love.graphics.setColor(PALETTE["world_text_selected"]) end

    if self.state ~= "SAVED" then love.graphics.setColor({237/255, 28/255, 36/255}) end
    Draw.draw(self.uiheart_sprite, self.box.x+30 - 24, self.box.y+14, 0, 2,2)
    if self.state ~= "SAVED" then love.graphics.setColor({48/255, 229/255, 138/255}) end
    Draw.draw(self.uimap2_sprite, self.box.x+30 - 24, self.box.y+50 + 42, 0, 2,2)
    
    if Game:getFlag("##genocide", false) == true then
        local width = Assets.getFont("main"):getWidth(LevelingLib.kills) + 24
        if self.state ~= "SAVED" then love.graphics.setColor({237/255, 123/255, 57/255}) end
        Draw.draw(self.uistat_sprite, self.box.x+30 - 24, self.box.y+14 + 40, 0, 2,2)
        if self.state ~= "SAVED" then love.graphics.setColor({1, 28/255, 28/255}) end
        Draw.draw(self.uideath_sprite, self.box.x+30 + 70, self.box.y+14 + 40, 0, 2,2)
        if self.state ~= "SAVED" then love.graphics.setColor({1, 184/255, 74/255}) end
        Draw.draw(self.uitime_sprite, self.box.x+30 + 70 + width + 24, self.box.y+14 + 40, 0, 2,2)

        if self.state == "SAVED" then
            love.graphics.setColor(PALETTE["world_text_selected"])
        else
            love.graphics.setColor(PALETTE["world_text"])
        end
        love.graphics.print("LV "..Game.party[1]:getLV(), self.box.x+30, self.box.y+50)
        love.graphics.print(LevelingLib.kills, self.box.x+30 + 70 + 26, self.box.y+50)
        love.graphics.print(time_text, self.box.x+30 + 70 + width + 50, self.box.y+50)
    else 
        if self.state ~= "SAVED" then love.graphics.setColor({60/255, 163/255, 112/255}) end
        Draw.draw(self.uimagic_sprite, self.box.x+30 - 24, self.box.y+14 + 40, 0, 2,2)
        if self.state ~= "SAVED" then love.graphics.setColor({1, 184/255, 74/255}) end
        Draw.draw(self.uitime_sprite, self.box.x+30 + 70, self.box.y+14 + 40, 0, 2,2)
        
        if self.state == "SAVED" then
            love.graphics.setColor(PALETTE["world_text_selected"])
        else
            love.graphics.setColor(PALETTE["world_text"])
        end
        love.graphics.print("LV "..level, self.box.x+30, self.box.y+50)
        love.graphics.print(time_text, self.box.x+30 + 70 + 26, self.box.y+50)
    end

    love.graphics.print(name,         self.box.x+30,     self.box.y+10)
    love.graphics.print(room_name, self.box.x+30, self.box.y+50+40)

    if self.state == "MAIN" then

        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart_sprite, self.box.x + 2 + (self.selected_x - 1) * 180, self.box.y + 173)
        if self.selected_x == 1 then
            love.graphics.setColor(1, 1, 0)
            love.graphics.print("Save",   self.box.x + 30,  self.box.y + 165)
            love.graphics.setColor(1, 1, 1)
            love.graphics.print("Return", self.box.x + 210, self.box.y + 165)
        elseif self.selected_x == 2 then
            love.graphics.setColor(1, 1, 1)
            love.graphics.print("Save",   self.box.x + 30,  self.box.y + 165)
            love.graphics.setColor(1, 1, 0)
            love.graphics.print("Return", self.box.x + 210, self.box.y + 165)
        end
    elseif self.state == "SAVED" then
        love.graphics.print("File saved.", self.box.x + 30, self.box.y + 165)
    end

    love.graphics.setColor(1, 1, 1)

    super.draw(self)
end
--]]

function SaveMenu:draw()
    love.graphics.setFont(self.font)
    if self.state == "MAIN" then
        local data = Game:getSavePreview()

        --local data = self.saved_file or {}
        local name
        local room_name
        local level
        if Game:isLight() then
            name      = data.name      or "GEROME"
            room_name = data.room_name or "Asriel's Room"
            level     = data.level     or 1
        else
            name      = data.name      or "[EMPTY]"
            room_name = data.room_name or "??????"
            level     = data.level     or 0
        end
        local playtime  = data.playtime  or 0

        local minutes = math.floor(playtime / 60)
        local seconds = math.floor(playtime % 60)
        local time_text = string.format("%d:%02d", minutes, seconds)
        




        love.graphics.setColor({237/255, 28/255, 36/255})
        Draw.draw(self.uiheart_sprite, self.box.x+30 - 24, self.box.y+14, 0, 2,2)
        love.graphics.setColor({48/255, 229/255, 138/255})
        Draw.draw(self.uimap2_sprite, self.box.x+30 - 24, self.box.y+50 + 42, 0, 2,2)
        
        if Game:getFlag("##genocide", false) == true then
            local width = Assets.getFont("main"):getWidth(LevelingLib.kills) + 24
            love.graphics.setColor({237/255, 123/255, 57/255})
            Draw.draw(self.uistat_sprite, self.box.x+30 - 24, self.box.y+14 + 40, 0, 2,2)
            love.graphics.setColor({1, 28/255, 28/255})
            Draw.draw(self.uideath_sprite, self.box.x+30 + 70, self.box.y+14 + 40, 0, 2,2)
            love.graphics.setColor({1, 184/255, 74/255})
            Draw.draw(self.uitime_sprite, self.box.x+30 + 70 + width + 24, self.box.y+14 + 40, 0, 2,2)

            if self.state == "SAVED" then
                love.graphics.setColor(PALETTE["world_text_selected"])
            else
                love.graphics.setColor(PALETTE["world_text"])
            end
            love.graphics.print("LV "..Game.party[1]:getLV(), self.box.x+30, self.box.y+50)
            love.graphics.print(LevelingLib.kills, self.box.x+30 + 70 + 26, self.box.y+50)
            love.graphics.print(time_text, self.box.x+30 + 70 + width + 50, self.box.y+50)
        else 
            love.graphics.setColor({60/255, 163/255, 112/255})
            Draw.draw(self.uimagic_sprite, self.box.x+30 - 24, self.box.y+14 + 40, 0, 2,2)
            love.graphics.setColor({1, 184/255, 74/255})
            Draw.draw(self.uitime_sprite, self.box.x+30 + 70, self.box.y+14 + 40, 0, 2,2)
            
            if self.state == "SAVED" then
                love.graphics.setColor(PALETTE["world_text_selected"])
            else
                love.graphics.setColor(PALETTE["world_text"])
            end
            love.graphics.print("LV "..level, self.box.x+30, self.box.y+50)
            love.graphics.print(time_text, self.box.x+30 + 70 + 26, self.box.y+50)
        end

        love.graphics.print(name,         self.box.x+30,     self.box.y+10)
        love.graphics.print(room_name, self.box.x+30, self.box.y+50+40)



        print(self.selected_x, self.selected_y)

        -- Buttons
        if self.selected_x == 1 and self.selected_y == 1 then
            love.graphics.setColor(1, 1, 0)
            love.graphics.print("Save",   self.box.x + 30,  self.box.y + 165)
            love.graphics.setColor(1, 1, 1)
            love.graphics.print("Return", self.box.x + 210, self.box.y + 165)
            if not Game.inventory.storage_enabled then
                Draw.setColor(PALETTE["world_gray"])
            end
            love.graphics.print("Storage", self.box.x + 30, 260)
            Draw.setColor(PALETTE["world_gray"])
            love.graphics.print("Recruits", self.box.x + 210, 260)
        elseif self.selected_x == 2 and self.selected_y == 1 then
            love.graphics.setColor(1, 1, 0)
            love.graphics.print("Return",   self.box.x + 210,  self.box.y + 165)
            love.graphics.setColor(1, 1, 1)
            love.graphics.print("Save", self.box.x + 30, self.box.y + 165)
            if not Game.inventory.storage_enabled then
                Draw.setColor(PALETTE["world_gray"])
            end
            love.graphics.print("Storage", self.box.x + 30, 260)
            Draw.setColor(PALETTE["world_gray"])
            love.graphics.print("Recruits", self.box.x + 210, 260)
        elseif self.selected_x == 1 and self.selected_y == 2 then
            love.graphics.setColor(1, 1, 0)
            if not Game.inventory.storage_enabled then
                Draw.setColor(PALETTE["world_gray"])
            end
            love.graphics.print("Storage", self.box.x + 30, 260)
            love.graphics.setColor(1, 1, 1)
            love.graphics.print("Save",   self.box.x + 30,  self.box.y + 165)
            love.graphics.print("Return", self.box.x + 210, self.box.y + 165)
            Draw.setColor(PALETTE["world_gray"])
            love.graphics.print("Recruits", self.box.x + 210, 260)
        elseif self.selected_x == 2 and self.selected_y == 2 then
            love.graphics.setColor(1, 1, 0)
            Draw.setColor(PALETTE["world_gray"])
            love.graphics.print("Recruits", self.box.x + 210, 260)
            love.graphics.setColor(1, 1, 1)
            love.graphics.print("Save", self.box.x + 30, self.box.y + 165)
            love.graphics.print("Return",   self.box.x + 210,  self.box.y + 165)
            if not Game.inventory.storage_enabled then
                Draw.setColor(PALETTE["world_gray"])
            end
            love.graphics.print("Storage", self.box.x + 30, 260)
        end

        --love.graphics.print("Save", 170, 220)
        --love.graphics.print("Return", 350, 220)
        --[[
        if not Game.inventory.storage_enabled then
            Draw.setColor(PALETTE["world_gray"])
        end
        love.graphics.print("Storage", 170, 260)
        Draw.setColor(PALETTE["world_gray"])
        love.graphics.print("Recruits", 350, 260)
        ]]

        -- Heart
        local heart_positions_x = {142, 322}
        local heart_positions_y = {self.box.y + 174, 270}
        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart_sprite, heart_positions_x[self.selected_x], heart_positions_y[self.selected_y])
    elseif self.state == "SAVE" or self.state == "OVERWRITE" then
        self:drawSaveFile(0, Game:getSavePreview(), 74, 26, false, true)

        self:drawSaveFile(1, self.saves[1], 74, 138, self.selected_y == 1)
        Draw.draw(self.divider_sprite, 74, 208, 0, 493, 2)

        self:drawSaveFile(2, self.saves[2], 74, 222, self.selected_y == 2)
        Draw.draw(self.divider_sprite, 74, 292, 0, 493, 2)

        self:drawSaveFile(3, self.saves[3], 74, 306, self.selected_y == 3)
        Draw.draw(self.divider_sprite, 74, 376, 0, 493, 2)

        if self.selected_y == 4 then
            Draw.setColor(Game:getSoulColor())
            Draw.draw(self.heart_sprite, 236, 402)

            Draw.setColor(PALETTE["world_text_selected"])
        else
            Draw.setColor(PALETTE["world_text"])
        end
        love.graphics.print("Return", 278, 394)
    elseif self.state == "SAVED" then
        self:drawSaveFile(self.saved_file, self.saves[self.saved_file], 74, 26, false, true)

        self:drawSaveFile(1, self.saves[1], 74, 138, self.selected_y == 1)
        Draw.draw(self.divider_sprite, 74, 208, 0, 493, 2)

        self:drawSaveFile(2, self.saves[2], 74, 222, self.selected_y == 2)
        Draw.draw(self.divider_sprite, 74, 292, 0, 493, 2)

        self:drawSaveFile(3, self.saves[3], 74, 306, self.selected_y == 3)
    end

    super.draw(self)

    if self.state == "OVERWRITE" then
        Draw.setColor(PALETTE["world_text"])
        local overwrite_text = "Overwrite Slot "..self.selected_y.."?"
        love.graphics.print(overwrite_text, SCREEN_WIDTH/2 - self.font:getWidth(overwrite_text)/2, 123)

        local function drawOverwriteSave(data, x, y)
            local w = 478

            -- Header
            love.graphics.print(data.name, x + (w/2) - self.font:getWidth(data.name)/2, y)
            love.graphics.print("LV "..data.level, x, y)

            local minutes = math.floor(data.playtime / 60)
            local seconds = math.floor(data.playtime % 60)
            local time_text = string.format("%d:%02d", minutes, seconds)
            love.graphics.print(time_text, x + w - self.font:getWidth(time_text), y)

            -- Room name
            love.graphics.print(data.room_name, x + (w/2) - self.font:getWidth(data.room_name)/2, y+30)
        end

        Draw.setColor(PALETTE["world_text"])
        drawOverwriteSave(self.saves[self.selected_y], 80, 165)
        Draw.setColor(PALETTE["world_text_selected"])
        drawOverwriteSave(Game:getSavePreview(), 80, 235)

        if self.selected_x == 1 then
            Draw.setColor(Game:getSoulColor())
            Draw.draw(self.heart_sprite, 142, 332)

            Draw.setColor(PALETTE["world_text_selected"])
        else
            Draw.setColor(PALETTE["world_text"])
        end
        love.graphics.print("Save", 170, 324)

        if self.selected_x == 2 then
            Draw.setColor(Game:getSoulColor())
            Draw.draw(self.heart_sprite, 322, 332)

            Draw.setColor(PALETTE["world_text_selected"])
        else
            Draw.setColor(PALETTE["world_text"])
        end
        love.graphics.print("Return", 350, 324)
    end
end

function SaveMenu:drawSaveFile(index, data, x, y, selected, header)
    if self.saved_file then
        if self.saved_file == index then
            Draw.setColor(PALETTE["world_text_selected"])
        else
            Draw.setColor(PALETTE["world_save_other"])
        end
    else
        if selected then
            Draw.setColor(PALETTE["world_text_selected"])
        else
            Draw.setColor(PALETTE["world_text"])
        end
    end
    if self.saved_file == index and not header then
        love.graphics.print("File Saved", x + 180, y + 22)
    elseif not data then
        love.graphics.print("New File", x + 193, y + 22)
        if selected then
            Draw.setColor(Game:getSoulColor())
            Draw.draw(self.heart_sprite, x + 161, y + 30)
        end
    else
        if self.saved_file or header then
            love.graphics.print("LV "..data.level, x + 26, y + 6)
        else
            love.graphics.print("LV "..data.level, x + 50, y + 6)
        end

        love.graphics.print(data.name, x + (493 / 2) - self.font:getWidth(data.name) / 2, y + 6)

        local minutes = math.floor(data.playtime / 60)
        local seconds = math.floor(data.playtime % 60)
        local time_text = string.format("%d:%02d", minutes, seconds)
        love.graphics.print(time_text, x + 467 - self.font:getWidth(time_text), y + 6)

        love.graphics.print(data.room_name, x + (493 / 2) - self.font:getWidth(data.room_name) / 2, y + 38)

        if selected and not header then
            Draw.setColor(Game:getSoulColor())
            Draw.draw(self.heart_sprite, x + 18, y + 14)
        end
    end
    Draw.setColor(1, 1, 1)
end

return SaveMenu