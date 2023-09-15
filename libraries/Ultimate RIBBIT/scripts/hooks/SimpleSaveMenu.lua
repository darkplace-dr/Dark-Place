if not Kristal.getLibConfig("ribbit", "changeSavepointSound") then
    return CLASS_NAME_GETTER("SimpleSaveMenu")
end

---@class SimpleSaveMenu
local SimpleSaveMenu, super = Class("SimpleSaveMenu", true)

function SimpleSaveMenu:update()
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
function SimpleSaveMenu:draw()
    love.graphics.setFont(self.font)

    if self.state == "SAVED" then
        Draw.setColor(PALETTE["world_text_selected"])
    else
        Draw.setColor(PALETTE["world_text"])
    end

    local data = self.saved_file or {}
    local name      = data.name      or "[EMPTY]"
    local level     = data.level     or 0
    local playtime  = data.playtime  or 0
    local room_name = data.room_name or ""

    love.graphics.print(name,         self.box.x,       self.box.y - 10)
    love.graphics.print("LV "..level, self.box.x + 210, self.box.y - 10)

    local minutes = math.floor(playtime / 60)
    local seconds = math.floor(playtime % 60)
    local time_text = string.format("%d:%02d", minutes, seconds)
    love.graphics.print(time_text, self.box.x + 280, self.box.y - 10)

    love.graphics.print(room_name, self.box.x, self.box.y + 30)

    if self.state == "MAIN" then
        love.graphics.print("Save",   self.box.x + 30,  self.box.y + 90)
        love.graphics.print("Return", self.box.x + 210, self.box.y + 90)

        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart_sprite, self.box.x + 2 + (self.selected_x - 1) * 180, self.box.y + 96)
    elseif self.state == "SAVED" then
        if Kristal.callEvent("isLeaderRibbit") then
            love.graphics.print("There we go.", self.box.x + 30, self.box.y + 90)
        else
            love.graphics.print("File saved.", self.box.x + 30, self.box.y + 90)
        end
    end

    Draw.setColor(1, 1, 1)

    --super.draw(self)
end

return SimpleSaveMenu