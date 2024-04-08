local spell, super = Class(Spell, "multi_guard")

function spell:init()
    super.init(self)

    self.name = "M. Guard"
    self.cast_name = "MULTI GUARD"

    self.effect = "Raise\nShields"
    self.description = "Raises a temporary diamond shield to all party members."

    self.cost = 70

    self.target = "party"

    self.tags = {"heal"}
end

function spell:onCast(user, target)
    Assets.playSound("trap")
    for _,battler in ipairs(target) do
		
		target:addShield(math.floor(target.chara:getStat("health")) / 4)

        local function generateSlash(scale_x)
            local cutAnim = Sprite("effects/spells/ceroba/diamond")
            cutAnim:setOrigin(0.5, 0.5)
            cutAnim:setScale(2.5 * scale_x, 2.5)
            cutAnim:setColor(1, 1, 0)
            cutAnim:setPosition(battler:getRelativePos(battler.width/2, battler.height/2))
            cutAnim.layer = battler.layer + 0.01
            cutAnim:play(1/20, false, function(s) s:remove() end)
            user.parent:addChild(cutAnim)
        end
    
        generateSlash(1)
    end
	--Game.battle.hail_cd = 4
end

--[[function spell:isUsable(chara)
	if Game.battle.hail_cd > 0 then
		return false
	end
	return true
end]]

return spell