local Aiming, super = Class(Wave)

function Aiming:init()
    super.init(self)
    self.siner = 0
end

function Aiming:onStart()
    self.startmove = false
    self.timer:script(function(wait)
    Assets.playSound("gunreload")
    wait(0.5)
    self.startmove = true
    self.timer:every(1/5, function()
        local attackers = self:getAttackers()
        for _, attacker in ipairs(attackers) do
            local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)
            local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)

            self:spawnBullet("gunbullet", x, y, angle, 28)
            Assets.playSound("gunshot")
        end
    end)
end)
    local arena = Game.battle.arena
    self.arena_start_x = arena.x
    self.arena_start_y = arena.y
end

function Aiming:update()
    if self.startmove == true then
    self.siner = self.siner + DT
    local offset = math.sin(self.siner * 3) * 60
    Game.battle.arena:setPosition(self.arena_start_x, self.arena_start_y + offset)
    end
    super.update(self)
end

return Aiming