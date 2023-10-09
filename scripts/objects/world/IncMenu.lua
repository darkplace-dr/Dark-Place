local IncMenu, super = Class(Object)

function IncMenu:init(limits, startingnum)
    super.init(self, SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 36, 40)
    self.bg = UIBox(0, 0, self.width, self.height)
    self.bg.layer = -1
    self.bg.debug_select = false
    self:addChild(self.bg)


    self.limits = limits or {0, 9}
    self.startingnum = startingnum or 0
    self.mynum = self.startingnum

    if self.mynum > self.limits[2] then
        self.mynum = self.limits[2]
    elseif self.mynum < self.limits[1] then
        self.mynum = self.limits[1]
    end

    self:setParallax(0, 0)
    self:setOrigin(0.5, 0.5)

    self.draw_children_below = 0

    self.font = Assets.getFont("main")

    self.ui_move = Assets.newSound("ui_move")
    self.ui_select = Assets.newSound("ui_select")
    self.ui_cant_select = Assets.newSound("ui_cant_select")
    self.ui_cancel_small = Assets.newSound("ui_cancel_small")

    self.up_sprite = Assets.getTexture("ui/flat_arrow_up")
	self.down_sprite = Assets.getTexture("ui/flat_arrow_down")


    self.decision = nil

    self.acceptinput = false

    Game.world.timer:after(1/30, function ()
        self.acceptinput = true
    end)

end

function IncMenu:update()

    if self.elevatormode == true then
        self.width = 200
        self.bg.width = 200
    end

    if self.acceptinput then
    if Input.pressed("up") then
        if self.mynum < self.limits[2] then
            self.mynum = self.mynum + 1
            self.ui_move:stop()
            self.ui_move:play()
        else
            self.ui_cant_select:stop()
            self.ui_cant_select:play()
        end
    end
    if Input.pressed("down") then
        if self.mynum > self.limits[1] then
            self.mynum = self.mynum - 1
            self.ui_move:stop()
            self.ui_move:play()
        else
            self.ui_cant_select:stop()
            self.ui_cant_select:play()
        end
    end

    if Input.pressed("cancel") then
        self.ui_cancel_small:stop()
        self.ui_cancel_small:play()
        self.decision = self.startingnum
    end

    if Input.pressed("confirm") then
        self.ui_select:stop()
        self.ui_select:play()
        self.decision = self.mynum
    end
    end
    
    super.update(self)
end


function IncMenu:draw()
    local elevator = Game.world.map:getEvent("elevator")

    love.graphics.setFont(self.font)

    if self.elevatormode == true then
        love.graphics.printf(elevator.floors[self.mynum].name, 2, 2, self.bg.width, "center")
    else
        love.graphics.printf(self.mynum, 2, 2, self.bg.width, "center")
    end

    if self.mynum < self.limits[2] then
        love.graphics.draw(self.up_sprite, (self.width/2) - 5, -10)
    end
    if self.mynum > self.limits[1] then 
        love.graphics.draw(self.down_sprite, (self.width/2) - 5, self.height+5)
    end
    
end

return IncMenu