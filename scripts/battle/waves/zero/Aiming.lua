local Aiming, super = Class(Wave)

function Aiming:init()
    super.init(self)
    
end

function Aiming:onStart()
    self.user = self:getAttackers()[1]
    self.time = -1
    self.drawline = true
    self.lockline = false
    self.mx, self.my = self.user:getRelativePos(self.user.width/2 - 7, self.user.height/2)
    self.dx = Game.battle.soul.x - self.mx
    self.dy = Game.battle.soul.y - self.my
    self.targetx = Game.battle.soul.x
    self.targety = Game.battle.soul.y

    self.timer:after(3, function ()
        self.angle = Utils.angle(self.mx, self.my, self.targetx, self.targety)
        self.timer:everyInstant(0.1, function ()
            Assets.playSound("mtt_prebomb")
        end, 3)
        self.lockline = true
        self.timer:after(0.5, function ()
            self.user.physics.direction = self.angle
            self.user.physics.speed = 10
        end)
    end)
end

function Aiming:update()
    -- Code here gets called every frame
    if not self.lockline then
    self.dx = Game.battle.soul.x - self.mx
    self.dy = Game.battle.soul.y - self.my
    self.targetx = Game.battle.soul.x
    self.targety = Game.battle.soul.y
    end
    super.update(self)
end

function Aiming:draw()
    super.draw(self)
    -- Get the attacker's center position
    Draw.setColor(1,0,0, 1)
    love.graphics.setLineWidth(1)
    love.graphics.setLineStyle("smooth")
    local scale = 100
    if self.drawline then
        love.graphics.line(self.mx, self.my, scale*self.dx + self.mx, scale*self.dy + self.my)
    end
    
end

function Aiming:onEnd()
    self.user.sprite:set("idle")
    self.user.x = 690
    self.user.y = 216
    self.user.physics.speed = 0
    Game.battle.timer:tween(0.5, self.user, {x = 550}, "out-expo")
    super:onEnd()
end

return Aiming