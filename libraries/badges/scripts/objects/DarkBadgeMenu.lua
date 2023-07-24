---@class DarkBadgeMenu : Object
---@overload fun(...) : DarkBadgeMenu
local DarkBadgeMenu, super = Class(Object)

function DarkBadgeMenu:init()
    super.init(self, 82, 112, 477, 277)

    self.draw_children_below = 0

    self.font = Assets.getFont("main")

    self.ui_move = Assets.newSound("ui_move")
    self.ui_select = Assets.newSound("ui_select")
    self.ui_cant_select = Assets.newSound("ui_cant_select")
    self.ui_cancel_small = Assets.newSound("ui_cancel_small")

    self.heart_sprite = Assets.getTexture("player/heart")
    self.arrow_sprite = Assets.getTexture("ui/page_arrow_down")

    self.bg = UIBox(0, 0, self.width, self.height)
    self.bg.layer = -1
    self.bg.debug_select = false
    self:addChild(self.bg)

    -- SELECT, ALL, EQUIPPED
    self.state = "SELECT"
    self.selected_option = 1
    self.badge_list_offset = 0
end

function DarkBadgeMenu:getCurrentBadgeState()
    local state = "ALL"
    if self.state == "EQUIPPED" or (self.state == "SELECT" and self.selected_option == 2) then
        state = "EQUIPPED"
    end
    return state
end

function DarkBadgeMenu:getStorage()
    return Game.inventory:getStorage("badges")
end

function DarkBadgeMenu:getBadges(state)
    local badge_state = state or self:getCurrentBadgeState()
    if badge_state == "ALL" then
        return self:getStorage()
    end

    local items = {}
    for _, badge in ipairs(self:getStorage()) do
        if badge.equipped then
            table.insert(items, badge)
        end
    end
    return items
end

function DarkBadgeMenu:getSelectedBadge()
    return self:getBadges()[self.selected_option]
end

function DarkBadgeMenu:updateSelectedItem()
    local badge = self:getSelectedBadge()
    if badge then
        Game.world.menu:setDescription(badge:getDescription(), true)
    end
end

function DarkBadgeMenu:update()
    if self.state == "SELECT" then
        if Input.pressed("cancel") then
            self.ui_cancel_small:stop()
            self.ui_cancel_small:play()
            Game.world.menu:closeBox()
            Game.world.menu:setDescription("", false)
            return
        end
        if Input.pressed("up") or Input.pressed("down") then
            self.ui_move:stop()
            self.ui_move:play()
            self.selected_option = (self.selected_option == 2) and 1 or 2
        end

        if Input.pressed("confirm") then
            self.state = (self.selected_option == 1) and "ALL" or "EQUIPPED"
            if (#self:getBadges() == 0) then
                self.state = "SELECT"
                self.ui_cant_select:stop()
                self.ui_cant_select:play()
                return
            end
            self.ui_select:stop()
            self.ui_select:play()
            self.selected_option = 1
            self:updateSelectedItem()
        end
    elseif self.state == "ALL" or self.state == "EQUIPPED" then
        if Input.pressed("cancel") then
            self.ui_cancel_small:stop()
            self.ui_cancel_small:play()
            self.selected_option = (self.state == "ALL") and 1 or 2
            self.state = "SELECT"
            Game.world.menu:setDescription("", false)
        end
        if Input.pressed("up") then
            self.ui_move:stop()
            self.ui_move:play()
            self.selected_option = (self.selected_option == 1) and #self:getBadges() or self.selected_option - 1
            self:updateSelectedItem()
        end
        if Input.pressed("down") then
            self.ui_move:stop()
            self.ui_move:play()
            self.selected_option = (self.selected_option == #self:getBadges()) and 1 or self.selected_option + 1
            self:updateSelectedItem()
        end
        if Input.pressed("confirm") then
            local item = self:getSelectedBadge()
            if item:isEquipped() then
                item:setEquipped(false)
                self.ui_select:stop()
                self.ui_select:play()
                if self.state == "EQUIPPED" then
                    if (#self:getBadges() == 0) then
                        self.state = "SELECT"
                        self.selected_option = 1
                    elseif self.selected_option > #self:getBadges() then
                        self.selected_option = #self:getBadges()
                    end
                end
            elseif (BadgesLib.total_bp - BadgesLib:getUsedBadgePoints()) >= item:getBadgePoints() then
                item:setEquipped(true)
                self.ui_select:stop()
                self.ui_select:play()
            else
                self.ui_cant_select:stop()
                self.ui_cant_select:play()
            end
        end
    end

    super.update(self)
end

function DarkBadgeMenu:draw()
    love.graphics.setFont(self.font)

    Draw.setColor(PALETTE["world_border"])
    love.graphics.rectangle("fill", 188, -24,  6,  322)
    love.graphics.rectangle("fill", -24, 120, 218,  6)

    Draw.setColor(Game:getSoulColor())
    if self.state == "SELECT" then
        Draw.draw(self.heart_sprite, 0, 16 + ((self.selected_option - 1) * 32))
    elseif self.state == "ALL" or self.state == "EQUIPPED" then
        if self.selected_option < self.badge_list_offset + 1 then
            self.badge_list_offset = self.selected_option - 1
        end

        if self.selected_option > self.badge_list_offset + 9 then
            self.badge_list_offset = self.selected_option - 9
        end

        Draw.draw(self.heart_sprite, 180 + 54 - 26 - 8, 16 + ((self.selected_option - self.badge_list_offset - 1) * 30))
    end

    Draw.setColor(PALETTE["world_header"])
    if self.state == "ALL" then Draw.setColor(PALETTE["world_header_selected"]) end
    if (#self:getBadges("ALL") == 0) then Draw.setColor(PALETTE["world_gray"]) end
    love.graphics.print("All Badges", 26, 6)
    Draw.setColor(PALETTE["world_header"])
    if self.state == "EQUIPPED" then Draw.setColor(PALETTE["world_header_selected"]) end
    if (#self:getBadges("EQUIPPED") == 0) then Draw.setColor(PALETTE["world_gray"]) end
    love.graphics.print("Equip Only", 26, 38)

    local state = self:getCurrentBadgeState()

    local item_x = 0
    local item_y = 0
    for i = self.badge_list_offset + 1, self.badge_list_offset + 9 do
        local badge = self:getBadges(state)[i]
        if badge then
            Draw.setColor(PALETTE["world_text_shadow"])
            local name = badge:getWorldMenuName() .. " - " .. badge:getBadgePoints() .. " BP"
            love.graphics.print(name, 180 + 54 + (item_x * 210) + 2 - 8, 6 + (item_y * 30) + 2)
            Draw.setColor(1, 1, 1, 1)
            if (BadgesLib.total_bp - BadgesLib:getUsedBadgePoints()) < badge:getBadgePoints() then Draw.setColor(PALETTE["world_gray"]) end
            if (badge.equipped) then Draw.setColor(PALETTE["world_header_selected"]) end
            love.graphics.print(name, 180 + 54 + (item_x * 210) - 8, 6 + (item_y * 30))
            item_y = item_y + 1
        end
    end

    local sine_off = math.sin((Kristal.getTime()*30)/6) * 3
    if self.badge_list_offset + 9 < #self:getBadges(state) then
        Draw.draw(self.arrow_sprite, 476, 149 + sine_off + 105)
    end
    if self.badge_list_offset > 0 then
        Draw.draw(self.arrow_sprite, 476, 8 - sine_off + 16, 0, 1, -1)
    end

    local x = 0
    local y = 0
    for i = 1, BadgesLib.total_bp do
        Draw.setColor(1, 1, 1, 1)
        Draw.draw(
            Assets.getTexture(
                "ui/menu/badge_point_" .. ((i <= BadgesLib:getUsedBadgePoints()) and "filled" or "empty" )
            ),
            0 + x * 18,
            120 + 16 + y * 18
        )

        x = x + 1
        if x > 8 then
            x = 0
            y = y + 1
        end
    end

    super.draw(self)
end

return DarkBadgeMenu