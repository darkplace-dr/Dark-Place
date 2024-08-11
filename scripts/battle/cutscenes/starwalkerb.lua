return {

	---@param cutscene BattleCutscene
	---@param battler PartyBattler
	---@param enemy EnemyBattler
	die = function(cutscene, battler, enemy)
		Game.battle.music:stop()
		cutscene:wait(2)

		local player = Mod:getLeader("battler")
		local sus = cutscene:getCharacter("susie")
		cutscene:setAnimation(player, "battle/attack_ready")
		if sus then
			sus:setSprite("shock_right")
			Assets.playSound("sussurprise")
		end
		cutscene:wait(0.2)

		cutscene:slideTo(player, enemy.x - 120, enemy.y + 5, 0.4)
		cutscene:wait(0.5)
        local attack_sound = Assets.stopAndPlaySound(player.chara:getAttackSound() or "laz_c")
        attack_sound:setPitch(player.chara:getAttackPitch() or 1)
		cutscene:wait(cutscene:setAnimation(player, "battle/attack"))
		local dmg_sprite = Sprite(player.chara:getAttackSprite() or "effects/attack/cut")
		dmg_sprite:setOrigin(0.5, 0.5)
		dmg_sprite:setScale(2.5, 2.5)
		dmg_sprite:setPosition(enemy:getRelativePos(enemy.width/2, enemy.height/2))
		dmg_sprite.layer = enemy.layer + 0.01
		dmg_sprite:play(1/15, false, function(s) s:remove() end)
		enemy.parent:addChild(dmg_sprite)
		local sound = enemy:getDamageSound() or "damage"
		if sound and type(sound) == "string" then
			Assets.stopAndPlaySound(sound)
		end
		enemy:statusMessage("damage", 9999, player and {player.chara:getDamageColor()})
		---@diagnostic disable-next-line: redundant-parameter
		enemy:hurt(enemy.max_health, player, function(damage, battler) -- COPY OF onDefeatFatal
			enemy.hurt_timer = -1

			Assets.playSound("deathnoise")

			local sprite = enemy:getActiveSprite()

			sprite.visible = false
			sprite:stopShake()

			local death_x, death_y = sprite:getRelativePos(0, 0, enemy)
			local death = FatalEffect(sprite:getTexture(), death_x, death_y, function() enemy:remove() end)
			death:setColor(sprite:getDrawColor())
			death:setScale(sprite:getScale())
			enemy:addChild(death)

			enemy.done_state = "KILLED"
		end, player and {player.chara:getDamageColor()}, false)

		cutscene:wait(1)
		player:getActiveSprite():setSprite("walk")
		player:getActiveSprite():setFacing("right")
		player:getActiveSprite():setFrame(1)

		cutscene:wait(1.5)
		cutscene:wait(cutscene:fadeOut(1))

		Game.battle.encounter.no_end_message = true
        cutscene:after(function()
			Game.battle:setState("VICTORY")
			Game.world.timer:after(0.5, function()
				Game.fader:fadeIn(nil, {
					speed = 0.5
				})
			end)
		end)
	end,

	spare = function(cutscene, battler, enemy)
		cutscene:wait(1.5)
		cutscene:wait(cutscene:fadeOut(1))

		Game.battle.encounter.no_end_message = true
        cutscene:after(function()
			Game.battle:setState("VICTORY")
			Game.world.timer:after(0.5, function()
				Game.fader:fadeIn(nil, {
					speed = 0.5
				})
			end)
		end)
	end
}
