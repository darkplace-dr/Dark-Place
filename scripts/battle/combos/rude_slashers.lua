local Forest, super = Class(Combo, "rude_slashers")

function Forest:init()
    -- Display name
    self.name = "Rude Slash"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = ""
    -- Menu description
    self.description = "YOU and Susie slash at the enemy many times."

    -- TP cost
    self.cost = 48
    -- Whether the combo can be used
    self.usable = true

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this combo
    self.tags = {}

    -- Other party members that are required to be in the party.
    self.party = {"YOU","susie"}
end

function Forest:doCutscene(cutscene, enemy)
	cutscene:text("* YOU and Susie use Rude Slash!")
	-- Get players active, get initial positions
	local krisPlayer = cutscene:getCharacter("YOU")
	local susiePlayer = cutscene:getCharacter("susie")
	local kx, ky = krisPlayer.x, krisPlayer.y
	local sx, sy = susiePlayer.x, susiePlayer.y
	local ex, ey = enemy.x, enemy.y

	-- Prepare damages for attack
	local krisDamage = math.ceil((krisPlayer.chara:getStat("attack") / 4))
	local susDamage = math.ceil((susiePlayer.chara:getStat("attack") / 4))
	local totalDamage = 0

	-- Move characters into position, flip character 2
	susiePlayer:setScale(-2, 2)
	cutscene:slideTo(krisPlayer, 200, 150, 0.25)
	cutscene:slideTo(susiePlayer, 400, 150, 0.25)
	cutscene:slideTo(enemy, 300, 150, 0.25)

	cutscene:wait(0.6)

	-- Create timer for when each character can attack
	local attackEnded = false
	local timer = 0
	local timerEnd = 2000
	local krisAttack = true
	local susieAttack = true

	--local buttons = Object(Game.world.width/2, Game.world.height/2, 280, 280)
	local krisButton = Sprite("buttons/buttonPrompt1_0")
	krisButton.alpha = 1
	krisButton:setScale(2, 2)
	krisButton.x = Game.battle.width/2 + 150
	krisButton.y = 150
	krisButton.layer = WORLD_LAYERS["above_ui"] + 100
	Game.battle:addChild(krisButton)

	local susButton = Sprite("buttons/buttonPrompt2_0")
	susButton.alpha = 1
	susButton:setScale(2, 2)
	susButton.x = Game.battle.width/2 + 450
	susButton.y = 150
	susButton.layer = WORLD_LAYERS["above_ui"] + 100
	Game.battle:addChild(susButton)

	
	for i = 0, 240/DTMULT, 1 do
		-- Emergency break, if enemy is dead
		if (enemy.health <= 0) then
			break
		end

		-- Swap between the character turns
		if (i > 30/DTMULT and i < 60/DTMULT) or (i > 90/DTMULT and i < 120/DTMULT) 
		or (i > 150/DTMULT and i < 180/DTMULT) or (i > 210/DTMULT and i < 240/DTMULT) then
			susieAttack = true
			krisAttack = false
			susButton.alpha = 1
			krisButton.alpha = 0
		else
			susieAttack = false
			krisAttack = true
			susButton.alpha = 0
			krisButton.alpha = 1
		end

		if (krisAttack) then
			if Input.pressed("confirm") then
				Assets.playSound("damage")
				krisPlayer:setAnimation({"battle/attack", 0.02, true})
				old_enemy_hp = enemy.health
				enemy:hurt(krisDamage, battler)
				if enemy.health < old_enemy_hp then
					totalDamage = totalDamage + krisDamage
				end
				cutscene:wait(0.06)
				krisPlayer:resetSprite()
				krisPlayer:setAnimation({"battle/attackready", 0.02, true})
			end
		end
		if (susieAttack) then
			if Input.pressed("cancel") then
				Assets.playSound("damage")
				susiePlayer:setAnimation({"battle/attack", 0.02, true})
				old_enemy_hp = enemy.health
				enemy:hurt(susDamage, battler)
				if enemy.health < old_enemy_hp then
					totalDamage = totalDamage + susDamage
				end
				cutscene:wait(0.06)
				susiePlayer:resetSprite()
				susiePlayer:setAnimation({"battle/attackready", 0.02, true})
			end
		end
		cutscene:wait()
	end 
	
	krisButton:remove()
	susButton:remove()

	local damageText = Text("[font:bignumbers]" ..totalDamage.. "", 300, 100, 100, 100, "bignumbers", "GONER")
	Game.battle:addChild(damageText)
	cutscene:wait(1.25);

	attackEnded = true
	damageText:remove()

	susiePlayer:setScale(2, 2)
	krisPlayer:resetSprite()
	susiePlayer:resetSprite()

	cutscene:slideTo(krisPlayer, kx, ky, 0.25)
	cutscene:slideTo(susiePlayer, sx, sy, 0.25)
	cutscene:slideTo(enemy, ex, ey, 0.25)

	cutscene:wait(0.25);
end

return Forest