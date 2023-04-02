---@class LightStatMenu : Object
---@overload fun(...) : LightStatMenu
local LightStatMenu, super = Class(Object)

function LightStatMenu:init()
    super.init(self, 212, 76, 298, 370)
    
    self.chara = Game.party[1]
    self.selected = 1

    self.draw_children_below = 0

    self.font = Assets.getFont("main")

    self.ui_move = Assets.newSound("ui_move")
    self.ui_select = Assets.newSound("ui_select")

    self.heart_sprite = Assets.getTexture("player/heart_menu")
    
    self.arrowLeft = Assets.getTexture("kristal/menu_arrow_left")
    self.arrowRight = Assets.getTexture("kristal/menu_arrow_right")

    self.bg = UIBox(0, 0, self.width, self.height)
    self.bg.layer = -1
    self:addChild(self.bg)
end

function LightStatMenu:update()
    if Input.pressed("cancel") then
        self.ui_move:stop()
        self.ui_move:play()
        Game.world.menu:closeBox()
        return
    end

    if Input.pressed("left") then
        if self.selected == 1 then
    
        
    
        elseif self.selected == 2 then
        
            self.selected = 1
            self.ui_move:play()
            self.chara = Game.party[1]
    
        elseif self.selected == 3 then
    
            self.selected = 2
            self.ui_move:play()
            self.chara = Game.party[2]
    
        elseif self.selected == 4 then
    
            self.selected = 3
            self.ui_move:play()
            self.chara = Game.party[3]
    
        elseif self.selected == 5 then
    
            self.selected = 4
            self.ui_move:play()
            self.chara = Game.party[4]
    
    
    
    
        end
    
    
    elseif Input.pressed("right") then
    
        if self.selected == 1 then
    
            if #Game.party == 1 then
                
            else
                self.selected = 2
                self.ui_move:play()
                self.chara = Game.party[2]
            end
    
        elseif self.selected == 2 then
    
            if #Game.party == 2 then
                
            else
                self.selected = 3
                self.ui_move:play()
                self.chara = Game.party[3]
            end
    
            
    
        elseif self.selected == 3 then
    
            if #Game.party == 3 then
                
            else
                self.selected = 4
                self.ui_move:play()
                self.chara = Game.party[4]
            end
    
        elseif self.selected == 4 then
    
            if #Game.party == 4 then
                
            else
                self.selected = 5
                self.ui_move:play()
                self.chara = Game.party[5]
            end
    
        elseif self.selected == 5 then
    
    
    
    
    
        end
    
    
    
    
    
    
    
    
    
    
    
    
    end










    super.update(self)
end


--[[


function LightStatMenu:onKeyPressed(key)
    self.ui_move:play()

    if key == "left" then
    if self.selected == 1 then

    

    elseif self.selected == 2 then
    
        self.selected = 1
        self.chara = Game.party[1]

    elseif self.selected == 3 then

        self.selected = 2
        self.chara = Game.party[2]

    elseif self.selected == 4 then

        self.selected = 3
        self.chara = Game.party[3]

    elseif self.selected == 5 then

        self.selected = 4
        self.chara = Game.party[4]




    end


elseif key == "right" then

    if self.selected == 1 then

        if #Game.party == 1 then
            
        else
            self.selected = 2
            self.chara = Game.party[2]
        end

    elseif self.selected == 2 then

        if #Game.party == 2 then
            
        else
            self.selected = 3
            self.chara = Game.party[3]
        end

        

    elseif self.selected == 3 then

        if #Game.party == 3 then
            
        else
            self.selected = 4
            self.chara = Game.party[4]
        end

    elseif self.selected == 4 then

        if #Game.party == 4 then
            
        else
            self.selected = 5
            self.chara = Game.party[5]
        end

    elseif self.selected == 5 then





    end




    end










end


]]

function LightStatMenu:draw()
    love.graphics.setFont(self.font)


    if self.selected == 1 then

        if #Game.party == 1 then
            love.graphics.setColor(PALETTE["world_gray"])
            love.graphics.draw(self.arrowLeft, 4, 20, 0, 1, 1, 0, 0 )
            love.graphics.setColor(PALETTE["world_gray"])
            love.graphics.draw(self.arrowRight, 20, 20, 0, 1, 1, 0, 0 )
        else
            love.graphics.setColor(PALETTE["world_gray"])
            love.graphics.draw(self.arrowLeft, 4, 20, 0, 1, 1, 0, 0 )
            love.graphics.setColor(PALETTE["world_text"])
            love.graphics.draw(self.arrowRight, 20, 20, 0, 1, 1, 0, 0 )
        end

    elseif self.selected == 2 then


        if #Game.party == 2 then
            love.graphics.setColor(PALETTE["world_text"])
            love.graphics.draw(self.arrowLeft, 4, 20, 0, 1, 1, 0, 0 )
            love.graphics.setColor(PALETTE["world_gray"])
            love.graphics.draw(self.arrowRight, 20, 20, 0, 1, 1, 0, 0 )
        else
            love.graphics.setColor(PALETTE["world_text"])
            love.graphics.draw(self.arrowLeft, 4, 20, 0, 1, 1, 0, 0 )
            love.graphics.setColor(PALETTE["world_text"])
            love.graphics.draw(self.arrowRight, 20, 20, 0, 1, 1, 0, 0 )
        end

    elseif self.selected == 3 then

        if #Game.party == 3 then
            love.graphics.setColor(PALETTE["world_text"])
            love.graphics.draw(self.arrowLeft, 4, 20, 0, 1, 1, 0, 0 )
            love.graphics.setColor(PALETTE["world_gray"])
            love.graphics.draw(self.arrowRight, 20, 20, 0, 1, 1, 0, 0 )
        else
            love.graphics.setColor(PALETTE["world_text"])
            love.graphics.draw(self.arrowLeft, 4, 20, 0, 1, 1, 0, 0 )
            love.graphics.setColor(PALETTE["world_text"])
            love.graphics.draw(self.arrowRight, 20, 20, 0, 1, 1, 0, 0 )
        end

    elseif self.selected == 4 then

        if #Game.party == 4 then
            love.graphics.setColor(PALETTE["world_text"])
            love.graphics.draw(self.arrowLeft, 4, 20, 0, 1, 1, 0, 0 )
            love.graphics.setColor(PALETTE["world_gray"])
            love.graphics.draw(self.arrowRight, 20, 20, 0, 1, 1, 0, 0 )
        else
            love.graphics.setColor(PALETTE["world_text"])
            love.graphics.draw(self.arrowLeft, 4, 20, 0, 1, 1, 0, 0 )
            love.graphics.setColor(PALETTE["world_text"])
            love.graphics.draw(self.arrowRight, 20, 20, 0, 1, 1, 0, 0 )
        end

    elseif self.selected == 5 then

        love.graphics.setColor(PALETTE["world_text"])
        love.graphics.draw(self.arrowLeft, 4, 20, 0, 1, 1, 0, 0 )
        love.graphics.setColor(PALETTE["world_gray"])
        love.graphics.draw(self.arrowRight, 20, 20, 0, 1, 1, 0, 0 )




    end




    love.graphics.setColor(PALETTE["world_text"])


    love.graphics.print("\"" .. self.chara:getName() .. "\"", 36, 8)

    if self.chara.lwstatsportrait ~= nil then
        love.graphics.draw(self.chara.lwstatsportrait, 170, 5, 0, 2.5, 2.5, 0, 0 )
    end

    love.graphics.print("LV  "..self.chara:getLightLV(), 4, 68)
    love.graphics.print("HP  "..self.chara:getHealth().." / "..self.chara:getStat("health"), 4, 100)

    local exp_needed = math.max(0, self.chara:getLightEXPNeeded(self.chara:getLightLV() + 1) - self.chara:getLightEXP())

    love.graphics.print("AT  "..self.chara:getBaseStats()["attack"] .." ("..self.chara:getEquipmentBonus("attack") ..")", 4, 164)
    love.graphics.print("DF  "..self.chara:getBaseStats()["defense"].." ("..self.chara:getEquipmentBonus("defense")..")", 4, 196)
    love.graphics.print("EXP: "..self.chara:getLightEXP(),   172, 164)
    love.graphics.print("NEXT: "..exp_needed, 172, 196)

    local weapon_name = self.chara:getWeapon() and self.chara:getWeapon():getName() or "None"
    local armor_name = self.chara:getArmor(1) and self.chara:getArmor(1):getName() or "None"

    love.graphics.print("WEAPON: "..weapon_name, 4, 256)
    love.graphics.print("ARMOR: "..armor_name, 4, 288)

    love.graphics.print(Game:getConfig("lightCurrency"):upper()..": "..Game.lw_money, 4, 328)

    super.draw(self)
end

return LightStatMenu