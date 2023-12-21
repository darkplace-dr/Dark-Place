local LightStorageMenu, super = Class(Object, "LightStorageMenu")

function LightStorageMenu:init(left_storage, right_storage)
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self:setParallax(0, 0)
    self.draw_children_below = 0

    self.font = Assets.getFont("main")

    self.box = UIBox(40, 40, 562, 402)
    self.box.layer = WORLD_LAYERS["ui"]
    self:addChild(self.box)
    
    self.heart = Sprite("player/heart_menu")
    self.heart:setScale(2)
    self.heart:setOrigin(0.5, 0.5)
    self.heart:setColor(Game:getSoulColor())
    self.heart.layer = WORLD_LAYERS["textbox"] + 5
    self:addChild(self.heart)

    self.storages = {left_storage or "items", right_storage or "box_a"}

    self.current_selecting = 1
    self.list = 1
end

function LightStorageMenu:getStorage(list)
    return Game.inventory:getStorage(self.storages[list or self.list])
end

function LightStorageMenu:getSelectedItem(list)
    return Game.inventory:getItem(self:getStorage(list), self.current_selecting)
end

function LightStorageMenu:onKeyPressed(key)
    if Input.is("cancel", key) then
        self:remove()
        Game.world:closeMenu()
    elseif Input.is("confirm", key) then
        if self.list == 1 then
            if not Game.inventory:isFull(self:getStorage(2)) then
                Game.inventory:addItemTo(self:getStorage(2), self:getSelectedItem(1))
                Game.inventory:removeItemFrom(self:getStorage(1), self.current_selecting)
            end
        elseif self.list == 2 then
            if not Game.inventory:isFull(self:getStorage(1)) then
                Game.inventory:addItemTo(self:getStorage(1), self:getSelectedItem(2))
                Game.inventory:removeItemFrom(self:getStorage(2), self.current_selecting)
            end
        end
    elseif Input.is("right", key) then
        self.list = 2
        if self.current_selecting >= self:getStorage(self.list).max then
            self.current_selecting = self:getStorage(self.list).max
        end
    elseif Input.is("left", key) then
        self.list = 1
        if self.current_selecting >= self:getStorage(self.list).max then
            self.current_selecting = self:getStorage(self.list).max
        end
    elseif Input.is("up", key) then
        self.current_selecting = self.current_selecting - 1

        if self.current_selecting < 1 then
            self.current_selecting = 1
        end
    elseif Input.is("down", key) then
        self.current_selecting = self.current_selecting + 1

        if self.current_selecting > self:getStorage(list).max then
            self.current_selecting = self:getStorage(list).max
        end
    end
end

function LightStorageMenu:update()
    self.heart.x = (self.list * 302) - 253
    self.heart.y = (self.current_selecting * 32) + 59
    super.update(self)
end

function LightStorageMenu:drawStorage(list)
    local x = (list * 302) - 234
    local y = 78
    for i = 1, self:getStorage(list).max do
        local item = Game.inventory:getItem(self:getStorage(list), i)
        if item then
            Draw.setColor(COLORS["white"])
            love.graphics.setFont(self.font)
            love.graphics.print(item:getName(), x - 2, y - 6)
        else
            Draw.setColor(COLORS["red"])
            love.graphics.setLineWidth(1)
            love.graphics.setLineStyle("rough")
            love.graphics.line(x + 12, y + 16, x + 192, y + 16)
        end
        y = y + 32
    end
end

function LightStorageMenu:draw()
    super.draw(self)

    Draw.setColor(COLORS["white"])
    love.graphics.setFont(self.font) 
    love.graphics.printf(self:getStorage(1).name, 17, 30, 300, "center")
    love.graphics.printf(self:getStorage(2).name, 319, 30, 300, "center")

    if not Input.usingGamepad() then
        love.graphics.print("Press "..Input.getText("cancel").." to Finish", 200, 406)
    else
        love.graphics.print("Press", 200, 406)
        love.graphics.print(" to Finish", 310, 406)
        Draw.draw(Input.getTexture("cancel"), 281, 410, 0, 2, 2)
    end

    love.graphics.setLineWidth(1)
    love.graphics.setLineStyle("rough")
    love.graphics.line(324, 94, 324, 394)
    love.graphics.line(322, 94, 322, 394)

    self:drawStorage(1)
    self:drawStorage(2)

end

return LightStorageMenu