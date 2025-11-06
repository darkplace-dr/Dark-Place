local Basic, super = Class(Wave)

function Basic:onStart()
    -- Every 0.33 seconds...
    self.timer:every(1, function()
        -- Our X position is offscreen, to the right
        local attackers = self:getAttackers()

        -- Loop through all attackers
        for _, attacker in ipairs(attackers) do

            -- Get the attacker's center position
            local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)

            -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
            self:spawnBullet("lob_hammer", x, y, MathUtils.random(math.pi, 2.5 * math.pi / 2), 6)
        end
    end)
end

function Basic:update()
    -- Code here gets called every frame

    super.update(self)
end

return Basic