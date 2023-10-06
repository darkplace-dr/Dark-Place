local Aiming, super = Class(Wave)

function Aiming:init()
    super.init(self)
    
end

function Aiming:onStart()
    Game.battle.timer:after(35, function ()
        Game.battle.music:fade(0,20/30, function ()
            Game.battle.music.volume = 1
            Game.battle.music:stop()
        end)
        Game.battle:setState("VICTORY")
    end)
    Game.battle.music:fade(0,20/30, function ()
        Game.battle.music.volume = 1
        Game.battle.music:stop()
    end)
    self.user = self:getAttackers()[1]
    self.time = -1
    self.drawline = true
    self.lockline = false
    self.mx, self.my = self.user:getRelativePos(self.user.width/2 - 7, self.user.height/2)

    self.timer:after(3, function ()
        self.bird = Sprite("world/npcs/smallfly")
        self.bird:setOrigin(0.5,1)
        self.bird:play(1/15,true)
        self.user:addChild(self.bird)
        self.bird.x = 100
        self.bird.y = -30
        self.timer:everyInstant(0.1, function ()
            Assets.playSound("mtt_prebomb")
        end, 3)
        self.lockline = true
        self.timer:after(0.5, function ()
            self.user.physics.direction = math.rad(-90)
            --self.user.physics.speed = 0.3
            Game.battle.music:stop()
            Game.battle.music:play("mus_birdsong")
            Game.battle.timer:tween(2, self.bird, {x = 25}, "linear")
            Game.battle.timer:after(2, function ()
                Game.battle.timer:tween(2, self.bird, {y = 25}, "linear")
            end)
            self.timer:after(6, function ()
                self.drawline = false
                self.user.physics.speed = 0.3
                self.user.sprite:set("hurt_fly")
            end)
        end)
    end)
end

function Aiming:update()
    -- Code here gets called every frame
    super.update(self)
end

function Aiming:draw()
    super.draw(self)
    Draw.setColor(1,0,0, 1)
    love.graphics.setLineWidth(1)
    love.graphics.setLineStyle("smooth")
    if self.drawline then
        love.graphics.line(self.mx, self.my, self.mx, 0)
    end
    
end

return Aiming