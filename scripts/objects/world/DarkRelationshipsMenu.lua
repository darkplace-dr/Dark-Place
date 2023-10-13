local DarkRelationshipsMenu, super = Class(Object)

function DarkRelationshipsMenu:init()
    super.init(self, 170, 90, 300, 300)

    self.parallax_x = 0
    self.parallax_y = 0

    self.font = Assets.getFont("main")
    self.font2 = Assets.getFont("plain")

    self.ui_cancel_small = Assets.newSound("ui_cancel_small")

    self.relationship_arrows = Assets.getTexture("ui/menu/relationshiparrows")

    self.bg = UIBox(0, 0, self.width, self.height)
    self.bg.layer = -1
    self.bg.debug_select = false
    self:addChild(self.bg)
end

function DarkRelationshipsMenu:draw()
    super.draw(self)

    love.graphics.setFont(self.font)
    love.graphics.printf("Relationships", 0, 0, self.width, "center")

    for i, v in ipairs(Game.party) do
        local head = nil
        if v.id == "YOU" then -- YOU's party sprite path isn't capitalized, so check if it's them specifically
            head = Assets.getTexture("party/you/head_1")
        elseif v.id == "jamm" then -- Check if on the Dungeonkiller route or not
            if Game:getFlag("dungeonkiller") and Game:getFlag("jamm_closure") then
                head = Assets.getTexture("party/jamm/head_shadowed")
            else
                head = Assets.getTexture("party/jamm/head")
            end
        else
            head = Assets.getTexture("party/"..v.id.."/head")
        end
        if i == 1 then
            love.graphics.draw(head, 25, 50, 0, 2)
        elseif i == 2 then
            love.graphics.draw(head, 225, 50, 0, 2)
        elseif i == 3 then
            love.graphics.draw(head, 25, 250, 0, 2)
        elseif i == 4 then
            love.graphics.draw(head, 225, 250, 0, 2)
        end
    end
    if #Game.party >= 2 then
        local member1opinions = Game.party[1].opinions
        local member1 = Game.party[1].id
        local member2opinions = Game.party[2].opinions
        local member2 = Game.party[2].id
        love.graphics.setFont(self.font2)
        love.graphics.print(member1opinions[member2], 80, 45)
        love.graphics.print(member2opinions[member1], 200, 75)
        love.graphics.draw(self.relationship_arrows, 75, 60, 0, 2)
        if #Game.party >= 3 then
            local member3opinions = Game.party[3].opinions
            local member3 = Game.party[3].id
            love.graphics.print(member3opinions[member1], 30, 230, math.rad(270))
            love.graphics.print(member1opinions[member3], 70, 100, math.rad(90))
            love.graphics.draw(self.relationship_arrows, 60, 95, math.rad(90), 2)
            love.graphics.print(member3opinions[member2], 80, 220, math.rad(-45))
            love.graphics.print(member2opinions[member3], 202, 130, math.rad(-45))
            love.graphics.draw(self.relationship_arrows, 230, 110, math.rad(135), 2.8, 2)
            if #Game.party >= 4 then
                local member4opinions = Game.party[4].opinions
                local member4 = Game.party[4].id
                love.graphics.print(member4opinions[member1], 200, 232, math.rad(45))
                love.graphics.print(member1opinions[member4], 100, 95, math.rad(45))
                love.graphics.draw(self.relationship_arrows, 220, 255, math.rad(225), 2.8, 2)
                love.graphics.print(member3opinions[member4], 80, 253)
                love.graphics.print(member4opinions[member3], 200, 280)
                love.graphics.draw(self.relationship_arrows, 75, 265, 0, 2)
                love.graphics.print(member4opinions[member2], 230, 230, math.rad(270))
                love.graphics.print(member2opinions[member4], 270, 100, math.rad(90))
                love.graphics.draw(self.relationship_arrows, 260, 95, math.rad(90), 2)
            end
        end
    end
end

function DarkRelationshipsMenu:close()
    Game.world.menu = nil
    self:remove()
end

function DarkRelationshipsMenu:onKeyPressed(key)
    if Input.pressed("cancel") or Input.pressed("menu") then
        self.ui_cancel_small:stop()
        self.ui_cancel_small:play()
        Game.world:closeMenu()
        return
    end
end

return DarkRelationshipsMenu