local Basic, super = Class(Wave)

function Basic:init()
	super.init(self)

	-- wait a frame so the soul has a chance to spawn
	Game.battle.timer:after(1/30, function ()
		Game.battle.soul.force_taunt = false
	end)
	
	self.arena_width = 20
    self.arena_height = 20
end

function Basic:onStart()
	Game.battle.enemies[1]:setAnimation("rocket")
	Game.battle.timer:after(0.5, function()
		local dmg_sprite = Explosion("effects/attack/ania")
		dmg_sprite:setOrigin(0.5, 0.5)
		dmg_sprite:setPosition(Game.battle.arena.x, Game.battle.arena.y)
		dmg_sprite.layer = Game.battle.soul.layer + 0.01
		Game.battle:addChild(dmg_sprite)
		Game.battle.timer:after(0.7, function()
			Kristal.callEvent("completeAchievement", "gods")
			Game:gameOver(Game.battle.arena.x, Game.battle.arena.y)
		end)
	end)
end

return Basic