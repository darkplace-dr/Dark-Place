local Aiming, super = Class(Wave)

function Aiming:onStart()
    local mimic = Game.battle:getEnemyBattler("mimic")
    if mimic.current_actor ~= "ufoofdoom" then
        mimic.current_actor = "ufoofdoom"
        self.timer:script(function(wait)
			mimic:fadeTo(0.2, 0.05)
			wait(0.1)
			mimic:setActor("ufoofdoom")
			mimic:fadeTo(0.2, 0)
			mimic:fadeTo(1, 0.05)
		end)
    end

	self.time = 10

    -- Every 1/64 seconds...
	self.shootangle = 0
    self.timer:every(1/64, function()
        -- Get all enemies that selected this wave as their attack
        local attackers = self:getAttackers()

        -- Loop through all attackers
        for _, attacker in ipairs(attackers) do

            -- Get the attacker's center position
            local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)


            -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
            self:spawnBullet("starbullet", x, y, math.rad(self.shootangle), 6, 0)
			
			self.shootangle = math.floor((self.shootangle + 16 + (Utils.random() * 32)) % 360)
			
        end
    end)
end

function Aiming:update()
    -- Code here gets called every frame

    super.update(self)
end

return Aiming