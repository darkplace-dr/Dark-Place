local spell, super = Class(Spell, "peace")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Peace"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Induce\nSPARE."
    -- Menu description
    self.description = "Increases an enemy's SPARE bar\nby a varying amount."

    -- TP cost
    self.cost = 32

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {"check"}
end

function spell:getCastMessage(user, target)
    return "* "..user.chara:getName().." used "..self:getCastName().."!"
end


function spell:onCast(user, target)
	
	Assets.playSound("spare_spell_weak")
	local peaceAnim = Sprite("effects/spells/dess/Peace", target.x, target.y)
	peaceAnim.alpha = 0.7
	peaceAnim:setOrigin(0.5, 1)
	peaceAnim:setScale(2)
	peaceAnim.layer = BATTLE_LAYERS["above_battlers"]
	Game.battle:addChild(peaceAnim)
	peaceAnim:play(1/17, false)
	peaceAnim.anim_callback = function(self)
		self:remove()
	end
	
	Game.battle.timer:after(1, function()
		if target.service_mercy then
			target:addMercy(math.ceil(target.service_mercy))
			Assets.playSound("spare_spell_hit")
			target:flash()
		end
		Game.battle:finishActionBy(user)
	end)
    return false
end

return spell