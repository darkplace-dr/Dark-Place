if not Kristal.getLibConfig("ribbit", "changeSavepointSound") then
    return CLASS_NAME_GETTER("SaveMenu")
end

---@class SaveMenu
local SaveMenu, super = Class("SaveMenu", true)

function SaveMenu:update()
    -- yes
    local _playSound = Assets.playSound
    Assets.playSound = function(sound, ...)
        if sound == "save" and Kristal.callEvent("isLeaderRibbit") then
            sound = "savefrog"
        end
        Assets.stopSound("powerfrog")
        return _playSound(sound, ...)
    end
    local result, info = pcall(super.update, self)
    Assets.playSound = _playSound
    if not result then error(info) end
end

--This kinda sucks ass but I'm not entirely sure how I should edit this function without copying it entirely
-- Please someone make this better - Agent 7
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
        if Kristal.callEvent("isLeaderRibbit") then
            love.graphics.print("There we go.", x + 180, y + 22)
        else
            love.graphics.print("File Saved", x + 180, y + 22)
        end
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