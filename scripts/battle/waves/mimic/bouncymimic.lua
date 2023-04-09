local BouncyMimic, super = Class(Wave)

function BouncyMimic:onStart()
    local mimic = Game.battle:getEnemyBattler("mimic")
    if mimic.current_actor ~= "poseur" then
        mimic.current_actor = "poseur"
        self.timer:script(function(wait)
			mimic:fadeTo(0.2, 0.05)
			wait(0.1)
			mimic:setActor("poseur")
			mimic:fadeTo(0.2, 0)
			mimic:fadeTo(1, 0.05)
		end)
    end
    self.timer:every(1/8, function()
        local posx = Utils.random(Game.battle.arena.left, Game.battle.arena.right)
        local posy = Game.battle.arena.top

        -- Spawn smallbullet going left with speed 8 (see scripts/battle/bullets/smallbullet.lua)
        self:spawnBullet("poseur/bouncybullet", posx, posy)
    end)
end

function BouncyMimic:update()
    -- Code here gets called every frame

    super.update(self)
end

return BouncyMimic