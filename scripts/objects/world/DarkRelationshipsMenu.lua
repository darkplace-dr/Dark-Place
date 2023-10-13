local DarkRelationshipsMenu, super = Class(Object)

function DarkRelationshipsMenu:init()
    super.init(self, 170, 90, 300, 300)

    self.font = Assets.getFont("main")

    self.ui_cancel_small = Assets.newSound("ui_cancel_small")

    self.bg = UIBox(0, 0, self.width, self.height)
    self.bg.layer = -1
    self.bg.debug_select = false
    self:addChild(self.bg)
end

function DarkRelationshipsMenu:draw()
    super.draw(self)

    for i, v in ipairs(Game.party) do
        local head = nil
        if v.id == "YOU" then -- YOU's party sprite path isn't capitalized, so check if it's them specifically
            head = Assets.getTexture("party/you/head_1")
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
    if #Game.party >= 2 then -- Somebody please make this work thank you
        local member1opinions = Game.party[1].opinions
        local member1 = Game.party[1].id
        local member2opinions = Game.party[2].opinions
        local member2 = Game.party[2].id
        love.graphics.print(member1opinions[member2] or "This shit wack yo", 150, 30)
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