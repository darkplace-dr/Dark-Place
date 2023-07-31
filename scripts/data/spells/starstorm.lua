local spell, super = Class(Spell, "starstorm")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "StarStorm"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Star/Dark\nto All."
    -- Menu description
    self.description = "Star/Dark damage to all foes."

    -- TP cost
    self.cost = 50

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemies"

    -- Tags that apply to this spell
    self.tags = {"damage"}
end

function spell:onCast(user, target)

	Assets.playSound("falling_star")

	user:setAnimation("battle/spellsuper")

	Game.battle.timer:every(0.01, function(wait)
		local random = Utils.random(0, 2, 1)

		local starparticle = nil
		if random == 0 then
			starparticle = Sprite("effects/spells/dess/starstorm_big", Utils.random(SCREEN_WIDTH), Utils.random(SCREEN_HEIGHT))
		elseif random == 1 then
			starparticle = Sprite("effects/spells/dess/starstorm_medium", Utils.random(SCREEN_WIDTH), Utils.random(SCREEN_HEIGHT))
		else
			starparticle = Sprite("effects/spells/dess/starstorm_small", Utils.random(SCREEN_WIDTH), Utils.random(SCREEN_HEIGHT))
		end

		starparticle:setOrigin(0.5, 0.5)
		starparticle:setScale(2)
		starparticle.layer = BATTLE_LAYERS["above_battlers"]
		Game.battle:addChild(starparticle)
		starparticle:play(0.1, false)
		starparticle:slideToSpeed(starparticle.x+32, starparticle.y, 5)
		starparticle:fadeOutAndRemove(0.5)
	end, 250)

	Game.battle.timer:after(3, function(wait)
		local damage = math.ceil((user.chara:getStat("magic") * 20) + 130 + (Utils.random(10) * 4))
		local i = 1

		Game.battle.timer:every(0.1, function()
			Assets.playSound("celestial_hit", 1.0, 1.4)
			Assets.playSound("damage")
			target[i]:hurt(damage, user)
			target[i]:flash()
			target[i]:shake(6, 0, 0.5)

			i = i + 1
		end, #target)

		user:setAnimation("battle/idle")

		Game.battle:finishActionBy(user)
	end)

    return false
end

return spell