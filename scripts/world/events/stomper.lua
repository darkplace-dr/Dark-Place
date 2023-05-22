local Stomper, super = Class(Event)

function Stomper:init(x, y, data)
    super.init(self, x, y, data)

    self.sprite = Sprite("world/events/stomper/thwomp")
    self.sprite:setScale(2)
    self:addChild(self.sprite)
	
    self.physics.speed_y = speed_y
	
    self.form = 1
    self.subform = 0
    self.init_x = self.x
    self.init_y = self.y
	
    self.candamage = 1

    self.snded = 0

end

function Stomper:update()
    super.update(self)
	
    self.player_k = Sprite(Game.world.player.actor:getSpritePath().."/battle/defeat")
    self.player_k.visible = false

    if self.form == 1 then
        self.sprite:setFrame(1)
	end
    if self.form == 2 then
        self.sprite:setFrame(2)
	end
    if self.form == 3 then
        self.sprite:setFrame(3)
        if (self.y < (Game.world.player.y + 10)) then
            self.form = 4
        end
	end
    if self.form == 4 then
        if (Game.world.player.x >= self.x) then
            self.x = Utils.lerp(self.x, Game.world.player.x, 0.25)
        end
        self.physics.speed_y = 15
        if (self.y >= (Game.world.player.y)) then
            self.physics.speed_y = 0
            self.form = 5
        end
    end
    if self.form == 5 then
        if self.x > self.init_x then
            self.physics.speed_x = -5
        else
            self.physics.speed_x = 0
        end
        if self.y ~= self.init_y then
            self.physics.speed_y = -10
        else
            self.snded = 0
            self.physics.speed_y = 0
            self.form = 1
        end
    end

    if self.subform == 1 then
        Game.world.player.visible = false
        self.player_k.visible = true
        --Game.lock_movement = true
        self.player_k.x = Utils.lerp(self.player_k.x, (self.x - 80), 0.1)
        self.player_k.y = Game.world.player.y
        Game.world.player.x = self.player_k.x
        if (Game.world.player.x <= (self.x - 73)) then
            Game.world.player.visible = true
            self.player_k.visible = false
            self.subform = 0
            --Game.lock_movement = false
            self.candamage = 1
        end
    end

    if self.form <= 3 then
        if (Game.world.player.x >= (self.x - 100) and Game.world.player.x <= (self.x - 40)) then
            self.form = 2
        elseif (Game.world.player.x >= (self.x - 40)) then
            self.form = 3
        else
            self.form = 1
        end
    end
    if (self.y < self.init_y) then
        self.y = self.init_y
        self.physics.speed_y = 0
    end
	
    if self:collidesWith(Game.world.player) and self.candamage == 1 then
        if self.snded == 0 then
            Assets.playSound("twomp1")
            Assets.playSound("twomp2")
            self.snded = 1
        end
        self.candamage = 0
        local a = AfterImage(self, 0.5)
		self:addChild(a)
        Assets.playSound("hurt", 5)
        Game.world.camera:shake(8)
        self.subform = 1
        self.player_k.x = Game.world.player.x
        self.layer = Game.world.player.layer - 0.1
    end
end

return Stomper
