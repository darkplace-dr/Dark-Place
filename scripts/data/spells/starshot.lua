local spell, super = Class(Spell, "starshot")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "StarShot"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Damage\nw/ STAR"
    -- Menu description
    self.description = "Deals magical Star damage to\none enemy."

    -- TP cost
    self.cost = 16

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {"damage"}
end

function spell:onCast(user, target)
	local targetX, targetY = target:getRelativePos(target.width/2, target.height/2, Game.battle)
	local userX, userY = user:getRelativePos(user.width, user.height/2, Game.battle)

	user:setAnimation("battle/snap")

    Game.battle.timer:script(function(wait)
		wait(10/30)

		Game.battle.starbasic = Sprite("effects/spells/dess/star_basic", userX+32, userY)
		Game.battle.starbasic:setOrigin(0.5, 0.5)
		Game.battle.starbasic:setScale(2)
		Game.battle.starbasic.layer = BATTLE_LAYERS["above_battlers"]
		Game.battle:addChild(Game.battle.starbasic)
		Game.battle.starbasic:slideToSpeed(targetX, targetY, 20, function()
			local damage = math.ceil((user.chara:getStat("magic") * 20) + 100 + (Utils.random(10) * 2))
			target:hurt(damage, user)

			Assets.playSound("celestial_hit")
			Assets.playSound("damage")
			target:shake(6, 0, 0.5)

			Game.battle.starbasic:remove()

			Game.battle:finishActionBy(user)
		end)

		Game.battle.timer:every(0.01, function()
			local starparticle = Sprite("effects/spells/dess/rainbow_star", Game.battle.starbasic.x + Utils.random(32), Game.battle.starbasic.y + Utils.random(32))
			starparticle:setOrigin(0.5, 0.5)
			starparticle:setScale(2)
			starparticle.layer = BATTLE_LAYERS["above_battlers"]
			Game.battle:addChild(starparticle)
			starparticle:play(0.1, false)
			starparticle:slideToSpeed(starparticle.x+32, starparticle.y, 2)
			starparticle:fadeOutAndRemove(0.5)
		end, 50)

        wait(1/30)
        Assets.playSound("wish")
		Assets.playSound("bomb")
    end)

    return false
end

function spell:hasWorldUsage(chara)
    return false
end

function spell:onWorldCast(chara)
    Assets.playSound("celestial_hit")
end

return spell