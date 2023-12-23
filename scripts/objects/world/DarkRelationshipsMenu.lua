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

    for i, party in ipairs(Game.party) do
        local head = nil
        if party.id == "jamm" then -- Check if on the Dungeonkiller route or not
            if Game:getFlag("dungeonkiller") and Game:getFlag("jamm_closure") then
                head = Assets.getTexture("party/jamm/head_shadowed")
            else
                head = Assets.getTexture("party/jamm/head")
            end
        else
            --LLDbg:bp()
            head = Assets.getTexture(party.menu_icon)
        end
        assert(head)
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

    love.graphics.setFont(self.font2)
    if #Game.party >= 2 then
        love.graphics.print(Game.party[1]:getOpinion(Game.party[2]), 80, 45)
        love.graphics.print(Game.party[2]:getOpinion(Game.party[1]), 200, 75)
        love.graphics.draw(self.relationship_arrows, 75, 60, 0, 2)
    end
    if #Game.party >= 3 then
        love.graphics.print(Game.party[3]:getOpinion(Game.party[1]), 30, 230, math.rad(270))
        love.graphics.print(Game.party[1]:getOpinion(Game.party[3]), 70, 100, math.rad(90))
        love.graphics.draw(self.relationship_arrows, 60, 95, math.rad(90), 2)
        love.graphics.print(Game.party[3]:getOpinion(Game.party[2]), 80, 220, math.rad(-45))
        love.graphics.print(Game.party[2]:getOpinion(Game.party[3]), 202, 130, math.rad(-45))
        love.graphics.draw(self.relationship_arrows, 230, 110, math.rad(135), 2.8, 2)
    end
    if #Game.party >= 4 then
        love.graphics.print(Game.party[4]:getOpinion(Game.party[1]), 200, 232, math.rad(45))
        love.graphics.print(Game.party[1]:getOpinion(Game.party[4]), 100, 95, math.rad(45))
        love.graphics.draw(self.relationship_arrows, 220, 255, math.rad(225), 2.8, 2)
        love.graphics.print(Game.party[3]:getOpinion(Game.party[4]), 80, 253)
        love.graphics.print(Game.party[4]:getOpinion(Game.party[3]), 200, 280)
        love.graphics.draw(self.relationship_arrows, 75, 265, 0, 2)
        love.graphics.print(Game.party[4]:getOpinion(Game.party[2]), 230, 230, math.rad(270))
        love.graphics.print(Game.party[2]:getOpinion(Game.party[4]), 270, 100, math.rad(90))
        love.graphics.draw(self.relationship_arrows, 260, 95, math.rad(90), 2)
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