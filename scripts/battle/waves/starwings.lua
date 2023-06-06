local Starwings, super = Class(Wave)

function Starwings:init()
    super.init(self)
    --self.time = -1
    self.time = love.math.random(10,60)
    self.starwalker = self:getAttackers()[1]
    self.timescale = 4
end

function Starwings:onStart()
    self.encounter:setMode("shoot")
    self.timer:every(1, function ()
        if not self.starwalker.sprite:set("starwalker_shoot_1") then end
        Assets.playSound("wing")

        self.timer:after(0.5, function ()
            if not self.starwalker.sprite:set("starwalker_shoot_2") then end
            Assets.playSound("stardrop")
            for i = -1, 1 do
                local offset = i * 15
                local star = self:spawnBullet("battle/bullets/star", self.starwalker.x - 20, self.starwalker.y - 40)
                star.physics.direction = math.atan2(Game.battle.soul.y - star.y, Game.battle.soul.x - star.x) + math.rad(offset)
                star.physics.speed = 6
            end
        end)
        self.timer:after(1, function ()
            if not self.starwalker.sprite:set("wings") then end
        end)
    end)
end

function Starwings:onEnd()
    self.encounter:setMode("normal")
    if not self.starwalker.sprite:set("wings") then end
    super.onEnd()
end

function Starwings:update()
    super.update(self)
end

return Starwings
