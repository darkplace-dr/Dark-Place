if not CLASS_NAME_GETTER("LightSaveMenu") then
    return "LightSaveMenu is simply absent before Kristal#29; so this is added to make Kristal stop yelling about us returning nil in older versions. I know we target v0.8.1-dev, but..."
end

if not Kristal.getLibConfig("ribbit", "changeSavepointSound") then
    return CLASS_NAME_GETTER("LightSaveMenu")
end

---@class LightSaveMenu
local LightSaveMenu, super = Class("LightSaveMenu", true)

function LightSaveMenu:update()
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
function LightSaveMenu:draw()
    love.graphics.setFont(self.font)

    if self.state == "SAVED" then
        Draw.setColor(PALETTE["world_text_selected"])
    else
        Draw.setColor(PALETTE["world_text"])
    end

    local data      = self.saved_file or {}
    local name      = data.name      or "Kris"
    local level     = data.level     or 1
    local playtime  = data.playtime  or 0
    local room_name = data.room_name or ""

    love.graphics.print(name,         self.box.x + 8,        self.box.y - 10 + 8)
    love.graphics.print("LV "..level, self.box.x + 210 - 34, self.box.y - 10 + 8)

    local minutes = math.floor(playtime / 60)
    local seconds = math.floor(playtime % 60)
    local time_text = string.format("%d:%02d", minutes, seconds)
    love.graphics.printf(time_text, self.box.x - 280 + 148, self.box.y - 10 + 8, 500, "right")

    love.graphics.print(room_name, self.box.x + 8, self.box.y + 38)

    if self.state == "MAIN" then
        love.graphics.print("Save",   self.box.x + 30  + 8, self.box.y + 98)
        love.graphics.print("Return", self.box.x + 210 + 8, self.box.y + 98)

        Draw.setColor(Game:getSoulColor())
        Draw.draw(self.heart_sprite, self.box.x + 10 + (self.selected_x - 1) * 180, self.box.y + 96 + 8, 0, 2, 2)
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

return LightSaveMenu