---@class ChaserEnemy
---@overload fun(...) : ChaserEnemy
local ChaserEnemy, super = Class(ChaserEnemy)

function ChaserEnemy:onCollide(player)
    if self:isActive() and player:includes(Player) then
        self.encountered = true
        local encounter = self.encounter
		Mod.back_attack = false
		local angle = Utils.angle(Game.world.player.x, Game.world.player.y, self.x, self.y)
		local facing = Utils.facingFromAngle(angle)
		if facing == self:getBackFace() and Kristal.getLibConfig("better_battles", "back_attack") then
			print("Back attack!")
			Mod.back_attack = true
		end
        if not encounter and Registry.getEnemy(self.enemy or self.actor.id) then
            encounter = Encounter()
            encounter:addEnemy(self.actor.id)
        end
        if encounter then
            self.world.encountering_enemy = true
			if not Mod.back_attack then
				self.sprite:setAnimation("hurt")
			end
            self.sprite.aura = false
            Game.lock_movement = true
            self.world.timer:script(function(wait)
				if Mod.back_attack then
					Assets.playSound("back_attack")
					wait(15/30)
				else
					Assets.playSound("tensionhorn")
					wait(8/30)
					local src = Assets.playSound("tensionhorn")
					src:setPitch(1.1)
					wait(12/30)
				end
                self.world.encountering_enemy = false
                Game.lock_movement = false
                local enemy_target = self
                if self.enemy then
                    enemy_target = {{self.enemy, self}}
                end
                Game:encounter(encounter, true, enemy_target, self)
            end)
        end
    end
end

function ChaserEnemy:getBackFace()
	local player = Game.world.player
	if player.facing == "right" then
		return "left"
	elseif player.facing == "left" then
		return "right"
	elseif player.facing == "up" then
		return "down"
	elseif player.facing == "down" then
		return "up"
	end
end

return ChaserEnemy