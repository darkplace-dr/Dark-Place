---@class _LightStatMenu : LightStatMenu
---@overload fun(...) : LightStatMenu
local LightStatMenu, super = Class(LightStatMenu, true)

function LightStatMenu:init()
    super.init(self)

    self.selected = 1

    self.arrow_left = Assets.getTexture("kristal/menu_arrow_left")
    self.arrow_right = Assets.getTexture("kristal/menu_arrow_right")
end

function LightStatMenu:update()
    if Input.pressed("cancel") then
        self.ui_move:stop()
        self.ui_move:play()
        Game.world.menu:closeBox()
        return
    end

    if #Game.party > 1 then
        if Input.pressed("left") and self.selected > 1 then
            self.selected = self.selected - 1
        end
        if Input.pressed("right") and self.selected < #Game.party then
            self.selected = self.selected + 1
        end
    end

    super.super.update(self)
end

function LightStatMenu:draw()
    love.graphics.setFont(self.font)
    love.graphics.setColor(PALETTE["world_text"])

    local chara = Game.party[self.selected]

    love.graphics.print("\"" .. chara:getName() .. "\"", 36, 8)

    if chara.lwstatsportrait ~= nil then
        love.graphics.draw(chara.lwstatsportrait, 170, 5, 0, 2.5, 2.5, 0, 0 )
    end

    love.graphics.setColor((#Game.party > 1 and self.selected > 1)
        and PALETTE["world_text"]
        or PALETTE["world_gray"])
    love.graphics.draw(self.arrow_left, 4, 20, 0, 1, 1, 0, 0)
    love.graphics.setColor((#Game.party > 1 and self.selected < #Game.party)
        and PALETTE["world_text"]
        or PALETTE["world_gray"])
    love.graphics.draw(self.arrow_right, 20, 20, 0, 1, 1, 0, 0)

    love.graphics.print("LV  "..chara:getLightLV(), 4, 68)
    love.graphics.print("HP  "..chara:getHealth().." / "..chara:getStat("health"), 4, 100)

    local exp_needed = math.max(0, chara:getLightEXPNeeded(chara:getLightLV() + 1) - chara:getLightEXP())

    love.graphics.print("AT  "..chara:getBaseStats()["attack"] .." ("..chara:getEquipmentBonus("attack") ..")", 4, 164)
    love.graphics.print("DF  "..chara:getBaseStats()["defense"].." ("..chara:getEquipmentBonus("defense")..")", 4, 196)
    love.graphics.print("EXP: "..chara:getLightEXP(),   172, 164)
    love.graphics.print("NEXT: "..exp_needed, 172, 196)

    local weapon_name = chara:getWeapon() and chara:getWeapon():getName() or "None"
    local armor_name = chara:getArmor(1) and chara:getArmor(1):getName() or "None"

    love.graphics.print("WEAPON: "..weapon_name, 4, 256)
    love.graphics.print("ARMOR: "..armor_name, 4, 288)

    love.graphics.print(Game:getConfig("lightCurrency"):upper()..": "..Game.lw_money, 4, 328)

    super.super.draw(self)
end

return LightStatMenu