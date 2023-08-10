local spell, super = Class(Spell, "save1stbase")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Save1stBase"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Heal\nAllies"
    -- Menu description
    self.description = "Holy bat magic heals the spirits\nof party members. Depends on Magic and Attack."

    -- TP cost
    self.cost = 48

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "party"

    -- Tags that apply to this spell
    self.tags = {"heal"}
end

function spell:onCast(user, target)
	Assets.playSound("falling_star", 1.0, 1.3)

	user:setAnimation("battle/spellsuper")

	local spellEffect = SaveBaseEffect()
	Game.battle:addChild(spellEffect)

	Game.battle.timer:after(2, function(wait)
		for _,battler in ipairs(target) do
			battler:heal(((user.chara:getStat("magic") * 3) + (user.chara:getStat("attack") * 2)) * 0.85)
		end

		user:setAnimation("battle/idle")

		Game.battle:finishActionBy(user)
	end)

	return false
end

return spell