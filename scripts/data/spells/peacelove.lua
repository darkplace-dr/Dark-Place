local spell, super = Class(Spell, "peacelove")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Peace&Love"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Induce\nSPARE."
    -- Menu description
    self.description = "Increases every enemy's SPARE bar\nby a varying amount."

    -- TP cost
    self.cost = 64

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemies"

    -- Tags that apply to this spell
    self.tags = {"check"}
end

function spell:getCastMessage(user, target)
    return "* "..user.chara:getName().." used "..self:getCastName().."!"
end


function spell:onCast(user, target)
	
	Assets.playSound("spare_spell_weak")
	local peaceAnim = Sprite("effects/spells/dess/peace", battler.x, battler.y)
	peaceAnim.alpha = 0.7
	peaceAnim:setOrigin(0.5, 0.5)
	peaceAnim:setScale(2)
	peaceAnim.layer = BATTLE_LAYERS["above_battlers"]
	Game.battle:addChild(peaceAnim)
	peaceAnim:play(1/17, false)
	
	Game.battle.timer:after(1, function()
		for _,battler in ipairs(target) do
			if battler.service_mercy then
				battler:addMercy(math.ceil(battler.service_mercy))
				Assets.playSound("spare_spell_hit")
				battler:flash()
			end
		end
		Game.battle:finishActionBy(user)
	end)
    return false
end

return spell