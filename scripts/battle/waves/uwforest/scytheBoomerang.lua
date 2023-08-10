local ScytheBoomerang, super = Class(Wave)

function ScytheBoomerang:onStart()
    -- Every second...
	self.timer:after(0.5, function()
		local attackers = self:getAttackers()

		for _, attacker in ipairs(attackers) do
			attacker:setAnimation("scytheReady")
		end
	end)
	
    self.timer:every(1, function()
        -- Get all enemies that selected this wave as their attack
        local attackers = self:getAttackers()
		
		-- yeah ik this is stupid but fuck it
		Assets.playSound("whip_throw_only")
		self.timer:after(0.2, function()
			Assets.playSound("whip_throw_only", 0.8)
			self.timer:after(0.2, function()
				Assets.playSound("whip_throw_only", 0.6)
				self.timer:after(0.2, function()
					Assets.playSound("whip_throw_only", 0.4)
				end)
			end)
		end)

        -- Loop through all attackers
        for _, attacker in ipairs(attackers) do
			
			attacker:setAnimation("scythe")
			
            -- Get the attacker's center position
            local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)

            -- Get the angle between the bullet position and the soul's position
            local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)

            -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
            self:spawnBullet("uwforest/hauntscythe", x, y, x, y, angle, 16, 0.6)
        end
    end)
end

--function ScytheBoomerang:update()
    -- Code here gets called every frame

--    super.update(self)
--end

function ScytheBoomerang:onEnd()
	local attackers = self:getAttackers()

    for _, attacker in ipairs(attackers) do
		attacker:setAnimation("idle")
	end
end

return ScytheBoomerang