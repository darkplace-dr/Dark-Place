local Aimingr, super = Class(Wave)

function Aimingr:onStart()
    -- Every 0.5 seconds...
    self.timer:every(1/2, function()
        -- Get all enemies that selected this wave as their attack
        local attackers = self:getAttackers()

        -- Loop through all attackers
        for _, attacker in ipairs(attackers) do

            -- Get the attacker's center position
            local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2+love.math.random(0,100))

            -- Get the angle between the bullet position and the soul's position
            local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)

            -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
            self:spawnBullet("diamondr", x, y, angle, 16)
            local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2+love.math.random(100,200))
            self:spawnBullet("diamondr", x, y, angle, 16)
        end
    end)
end

function Aimingr:update()
    -- Code here gets called every frame

    super.update(self)
end

return Aimingr