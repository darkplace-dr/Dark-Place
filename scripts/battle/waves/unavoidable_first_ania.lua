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
	Game.battle.timer:after(0.5, function()
		local dmg_sprite = Sprite("effects/attack/ania")
		dmg_sprite:setOrigin(0.5, 0.5)
		dmg_sprite:setScale(2, 2)
		dmg_sprite:setPosition(Game.battle.arena.x, Game.battle.arena.y)
		dmg_sprite.layer = Game.battle.soul.layer + 0.01
		dmg_sprite:play(1/15, false, function(s)
			s:remove()
			for _,battler in ipairs(Game.battle.party) do
				battler:breakShield()
			end
			Game.battle.timer:after(1, function()
				Game.battle.encounter:onWavesDone()
			end)
		end)
		Game.battle:addChild(dmg_sprite)
	end)
end

function Basic:update()
    -- Code here gets called every frame

    super.update(self)
	
	if not Game.battle.unstun then
		Game.battle.unstun = true
		local jamm = Game.battle.party[1]
		if jamm.is_down then
			jamm:revive()
		end
		jamm.chara.stun = false
		jamm:setAnimation("battle/spell", function()
			Game.battle.party[1]:setAnimation("battle/idle")
			for _,battler in ipairs(Game.battle.party) do
				battler:addShield(1000)
			end
		end)
	end
end

function Basic:onEnd()
	Game.battle:startCutscene("shade_ania.unstun")
end

return Basic