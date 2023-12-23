local Bobberry2, super = Class(Wave)

function Bobberry2:onStart()
    -- Every 0.5 seconds...
    self.timer:every(1/2, function()
        -- Get all enemies that selected this wave as their attack
        local attackers = self:getAttackers()

        -- Loop through all attackers
        for _, attacker in ipairs(attackers) do

            -- Get the attacker's center position
            local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)

            -- Get the angle between the bullet position and the soul's position
            local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)

            -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
            self:spawnBullet("wilybullet", x, y, angle, 8)
        end
    end)
end

function Bobberry2:update()
    -- Code here gets called every frame

    super.update(self)
end

return Bobberry2