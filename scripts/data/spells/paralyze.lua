local spell, super = Class(Spell, "paralyze")

function spell:init()
    super.init(self)

    self.name = "Paralysis"

    self.effect = "Ceroba's\nSpecial"
    self.description = "Deals massive damage to one enemy.\nDepends on Magic."

    self.cost = 55

    self.target = "enemy"

    self.tags = {"Damage"}
end

function spell:getCastMessage(user, target)
    return "* "..user.chara:getName().." used "..self:getCastName().."!"
end

function spell:onCast(user, target)
	local damage = self:getDamage(user, target)

	local function generateSlash(scale_x)
		local cutAnim = Sprite("battle/bullets/ceroba/diamond")
		cutAnim:setOrigin(0.5, 0.5)
		cutAnim:setScale(2.5 * scale_x, 2.5)
		cutAnim:setPosition(target:getRelativePos(target.width/2, target.height/2))
		cutAnim.layer = target.layer + 0.01
		Assets.playSound("trap")
		cutAnim:play(1/20, false, function(s) s:remove() end)
		user.parent:addChild(cutAnim)
	end

	Game.battle.timer:after(15/30, function()
		target:flash()
		target:hurt(damage, user)
		Game.battle:finishActionBy(user)
	end)

	generateSlash(1)
	return false
end

function spell:onLightCast(user, target)
	local damage = self:getDamage(user, target)

	local function generateSlash(scale_x)
		local cutAnim = Sprite("battle/bullets/ceroba/diamond")
		cutAnim:setOrigin(0.5, 0.5)
		cutAnim:setScale(3.5 * scale_x, 3.5)
		cutAnim:setPosition(target:getRelativePos(target.width/2, target.height/2))
		cutAnim.layer = target.layer + 0.01
		Assets.playSound("trap")
		cutAnim:play(1/20, false, function(s) s:remove() end)
		user.parent:addChild(cutAnim)
	end

	Game.battle.timer:after(15/30, function()
		target:hurt(damage, user)
		Game.battle:finishActionBy(user)
	end)

	generateSlash(1)
	return false
end

function spell:getDamage(user, target)
    if Game:isLight() then
        local min_magic = Utils.clamp(user.chara:getStat("magic") - 3, 1, 999)
        return math.ceil((min_magic * 8) + 45 + Utils.random(10))
    else
		local min_magic = Utils.clamp(user.chara:getStat("magic") - 10, 1, 999)
		return math.ceil((min_magic * 12) + 90 + Utils.random(10))
    end
end

return spell
