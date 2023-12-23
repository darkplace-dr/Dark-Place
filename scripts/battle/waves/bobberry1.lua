local Bobberry1, super = Class(Wave)

function Bobberry1:onStart()
	local attackers = self:getAttackers()
	self.time = 7
	
	-- this is dumb lmao
	-- holy shit if someone looks into this code
	-- it'l look like I had a stroke while writing this part
	self:setArenaShape({0, 3*142/6}, {1*142/6, 1*142/6}, {3*142/6, 0}, {5*142/6, 1*142/6}, {6*142/6, 3*142/6}, {5*142/6, 5*142/6}, {3*142/6, 6*142/6}, {1*142/6, 5*142/6})
	
	for i=0,(#attackers*4)-1 do
		if #attackers < 3 then
			self:spawnBullet("orbitingbullet", -16, -16, i*(90/#attackers), 3-#attackers)
		else
			if i > 4 then
				self:spawnBullet("orbitingbullet", -16, -16, i*(90/#attackers), 1)
			end
		end
	end
	
    -- Every 0.5 seconds...
    --self.timer:every(1/2, function()
        -- Get all enemies that selected this wave as their attack
        --local attackers = self:getAttackers()

        -- Loop through all attackers
        --for _, attacker in ipairs(attackers) do

            -- Get the attacker's center position
            --local x, y = attacker:getRelativePos(attacker.width/2, attacker.height/2)

            -- Get the angle between the bullet position and the soul's position
            --local angle = Utils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)

            -- Spawn smallbullet angled towards the player with speed 8 (see scripts/battle/bullets/smallbullet.lua)
            --self:spawnBullet("orbitingbullet", SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 0)
        --end
    --end)
end

function Bobberry1:update()
    -- Code here gets called every frame

    super.update(self)
end

return Bobberry1