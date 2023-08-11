local spell, super = Class(Spell, "xslash")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "X-Slash"
    -- Name displayed when cast (optional)
    self.cast_name = "X-SLASH"

    -- Battle description
    self.effect = "Physical\nDamage"
    -- Menu description
    self.description = "Deals large physical damage to 1 enemy."

    -- TP cost
    self.cost = 40

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {"Damage"}
end

function spell:getCastMessage(user, target)
    return "* "..user.chara:getName().." used "..self:getCastName().."!"
end

function spell:onCast(user, target)
	local damage = math.floor((((user.chara:getStat("attack") * 150) / 20) - 3 * (target.defense)) * 1.3)

	local function generateSlash(scale_x)
		local cutAnim = Sprite("effects/attack/cut")
		Assets.playSound("scytheburst")
		Assets.playSound("criticalswing", 1.2, 1.3)
		user.overlay_sprite:setAnimation("battle/attack") -- Makes the afterimages use the first frame of the attack animation
		user:toggleOverlay(true)
		local afterimage1 = AfterImage(user, 0.5)
		local afterimage2 = AfterImage(user, 0.6)
		user:toggleOverlay(false)
		afterimage1.physics.speed_x = 2.5
		afterimage2.physics.speed_x = 5
		afterimage2:setLayer(afterimage1.layer - 1)
		user:setAnimation("battle/attack", function()
			user:setAnimation("battle/idle")
		end)
		user:flash()
		cutAnim:setOrigin(0.5, 0.5)
		cutAnim:setScale(2.5 * scale_x, 2.5)
		cutAnim:setPosition(target:getRelativePos(target.width/2, target.height/2))
		cutAnim.layer = target.layer + 0.01
		cutAnim:play(1/15, false, function(s) s:remove() end)
		user.parent:addChild(cutAnim)
		user.parent:addChild(afterimage1)
		user.parent:addChild(afterimage2)
	end

	Game.battle.timer:after(0.1/2, function()
		generateSlash(1)
		target:hurt(damage, user)
		Game.battle.timer:after(1/2, function()
			generateSlash(-1)
			target:hurt(damage, user)
		end)
	end)
end

return spell
