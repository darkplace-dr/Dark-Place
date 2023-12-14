---@class SimpleSaveMenu : Object
---@overload fun(...) : SimpleSaveMenu
local SimpleSaveMenu, super = Class(Object)

function SimpleSaveMenu:init(save_id, marker)
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self.parallax_x = 0
    self.parallax_y = 0

    self.draw_children_below = 0

    self.font = Assets.getFont("main")

    self.heart_sprite = Assets.getTexture("player/heart")

    self.uiheart_sprite = Assets.getTexture("ui/save/heart")
    self.uimagic_sprite = Assets.getTexture("ui/save/magic")
    self.uitime_sprite = Assets.getTexture("ui/save/time")
    self.uistat_sprite = Assets.getTexture("ui/save/status")
    self.uideath_sprite = Assets.getTexture("ui/save/knife")
    self.uimap_sprite = Assets.getTexture("ui/save/map")
    self.uimap2_sprite = Assets.getTexture("ui/save/map_b")

    self.box = UIBox(140, 130, 360, 200)
    self.box.layer = -1
    self:addChild(self.box)

    self.marker = marker

    -- MAIN, SAVED
    self.state = "MAIN"

    self.selected_x = 1

    self.save_id = save_id or Game.save_id
    self.saved_file = Kristal.getSaveFile(save_id)
end

function SimpleSaveMenu:update()
    if self.state == "MAIN" then
        if Input.pressed("cancel") then
            self:remove()
            Game.world:closeMenu()
        end
        if Input.pressed("left") or Input.pressed("right") then
            self.selected_x = self.selected_x == 1 and 2 or 1
        end
        if Input.pressed("confirm") then
            if self.selected_x == 1 then
                self.state = "SAVED"

                Kristal.saveGame(self.save_id, Game:save(self.marker))
                self.saved_file = Kristal.getSaveFile(self.save_id)

                Assets.playSound("save_b", 0.5)
            elseif self.selected_x == 2 then
                self:remove()
                Game.world:closeMenu()
            end
        end
    elseif self.state == "SAVED" then
        if Input.pressed("confirm") or Input.pressed("cancel") then
            self:remove()
            Game.world:closeMenu()
        end
    end

    super.update(self)
end

function SimpleSaveMenu:draw()
    love.graphics.setFont(self.font)
    love.graphics.setColor(PALETTE["world_text"])

    --[[
    if Game:getFlag("deltacrackmain_weird", false) == false then
        Draw.draw(Assets.getTexture("ui/save/mainicon_1"), self.box.x+285, self.box.y+135, 0, 2,2)
    else
        Draw.draw(Assets.getTexture("ui/save/mainicon_2"), self.box.x+285, self.box.y+135, 0, 2,2)
    end
    ]]

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


    --[[
    if Game:isLight() then
        if self.state ~= "SAVED" then love.graphics.setColor({1, 184/255, 74/255}) end
        Draw.draw(self.uitime_sprite, self.box.x+30 + 70, self.box.y+14 + 40, 0, 2,2)

        if self.state == "SAVED" then
            love.graphics.setColor(PALETTE["world_text_selected"])
        else
            love.graphics.setColor(PALETTE["world_text"])
        end
        love.graphics.print(time_text, self.box.x+30 + 70 + 26, self.box.y+50)
    else 
        if self.state ~= "SAVED" then love.graphics.setColor({237/255, 123/255, 57/255}) end
        Draw.draw(self.uistat_sprite, self.box.x+30 + 70, self.box.y+14 + 40, 0, 2,2)
        if self.state ~= "SAVED" then love.graphics.setColor({1, 184/255, 74/255}) end
        Draw.draw(self.uitime_sprite, self.box.x+30 + 70 + 70 + 46, self.box.y+14 + 40, 0, 2,2)
        
        if self.state == "SAVED" then
            love.graphics.setColor(PALETTE["world_text_selected"])
        else
            love.graphics.setColor(PALETTE["world_text"])
        end
        love.graphics.print(Game:getFlag("deltacrackmain_state", "lucid"):upper(), self.box.x+30 + 70 + 26, self.box.y+50)
        love.graphics.print(time_text, self.box.x+30 + 70 + 70 + 73, self.box.y+50)
    end
    ]]

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

return SimpleSaveMenu