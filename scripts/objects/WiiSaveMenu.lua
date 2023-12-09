---@class WiiSaveMenu : Object
---@overload fun(...) : SaveMenu
local WiiSaveMenu, super = Class(Object)

function WiiSaveMenu:init(marker)
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self.parallax_x = 0
    self.parallax_y = 0

    self.draw_children_below = 0

    self.font = Assets.getFont("main")

    self.ui_select = Assets.newSound("ui_select")

    self.heart_sprite = Assets.getTexture("player/heart")
    self.divider_sprite = Assets.getTexture("ui/box/dark/top")

    self.main_box = UIBox(124, 130, 391, 154)
    self.main_box.layer = -1
    self:addChild(self.main_box)

    self.marker = marker

    -- MAIN, SAVED
    self.state = "MAIN"

    self.selected_x = 1
    self.selected_y = 1

    self.saved_file = nil
end

function WiiSaveMenu:update()
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
                self.state = "SAVED"

                Kristal.saveGame(0, Game:save(self.marker))
                self.saved_file = Kristal.getSaveFile(0)

                Assets.playSound("save")
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
    elseif self.state == "SAVED" then
        if Input.pressed("cancel") or Input.pressed("confirm") then
            self:remove()
            Game.world:closeMenu()
        end
    end

    super.update(self)
end

function WiiSaveMenu:draw()
    love.graphics.setFont(self.font)
	
    if self.state == "MAIN" then
        local data = Game:getSavePreview()

        -- Header
        Draw.setColor(PALETTE["world_text"])
        love.graphics.print(data.name, 120, 120)
        love.graphics.print("LV "..data.level, 352, 120)

        local minutes = math.floor(data.playtime / 60)
        local seconds = math.floor(data.playtime % 60)
        local time_text = string.format("%d:%02d", minutes, seconds)
        love.graphics.print(time_text, 520 - self.font:getWidth(time_text), 120)

        -- Room name
        love.graphics.print(data.room_name, 319.5 - self.font:getWidth(data.room_name)/2, 170)

        -- Buttons
        love.graphics.print("Save", 170, 220)
        love.graphics.print("Return", 350, 220)
        if not Game.inventory.storage_enabled then
            Draw.setColor(PALETTE["world_gray"])
        end
        love.graphics.print("Storage", 170, 260)
        Draw.setColor(PALETTE["world_gray"])
        love.graphics.print("Recruits", 350, 260)

        -- Heart
        local heart_positions_x = {142, 322}
        local heart_positions_y = {228, 270}
        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart_sprite, heart_positions_x[self.selected_x], heart_positions_y[self.selected_y])
    elseif self.state == "SAVED" then
        local data = Game:getSavePreview()

        -- Header
        Draw.setColor(PALETTE["world_text_selected"])
        love.graphics.print(data.name, 120, 120)
        love.graphics.print("LV "..data.level, 352, 120)

        local minutes = math.floor(data.playtime / 60)
        local seconds = math.floor(data.playtime % 60)
        local time_text = string.format("%d:%02d", minutes, seconds)
        love.graphics.print(time_text, 520 - self.font:getWidth(time_text), 120)

        -- Room name
        love.graphics.print(data.room_name, 319.5 - self.font:getWidth(data.room_name)/2, 170)
		
        love.graphics.print("File saved.", self.main_box.x + 30, self.main_box.y + 90)
    end

    super.draw(self)
end

return WiiSaveMenu
