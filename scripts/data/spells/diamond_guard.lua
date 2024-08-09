local spell, super = Class(Spell, "diamond_guard")

function spell:init()
    super.init(self)

    self.name = "D. Guard"
    self.cast_name = "DIAMOND GUARD"

    self.effect = "Raise\nShield"
    self.description = "Raises a temporary diamond shield to one party member."

    self.cost = 45

    self.target = "ally"

    self.tags = {"heal"}
end

function spell:onCast(user, target)

	target:addShield(math.floor(target.chara:getStat("health")) / 4)

    local function generateSlash(scale_x)
        local cutAnim = Sprite("battle/bullets/ceroba/diamond")
        cutAnim:setOrigin(0.5, 0.5)
        cutAnim:setScale(2.5 * scale_x, 2.5)
        cutAnim:setColor(1, 1, 0)
        cutAnim:setPosition(target:getRelativePos(target.width/2, target.height/2))
        cutAnim.layer = target.layer + 0.01
        Assets.playSound("trap")
        cutAnim:play(1/20, false, function(s) s:remove() end)
        user.parent:addChild(cutAnim)
    end

    Game.battle.timer:after(15/30, function()
		target:flash()
	end)
    
    generateSlash(1)

	--Game.battle.hail_cd = 4
end

--[[function spell:isUsable(chara)
	if Game.battle.hail_cd > 0 then
		return false
	end
	return true
end]]

return spell