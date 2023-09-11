local spell, super = Class(Spell, "supersling")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "HealSling"

    -- Battle description
    self.effect = "Healing\nService"
    -- Menu description
    self.description = "Slingshot healing bullets to an enemy, making them more likely to spare us."

    -- TP cost
    self.cost = 32

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {"Heal"}
end

function spell:getCastMessage(user, target)
    return "* "..user.chara:getName().." used "..self:getCastName().."!"
end

function spell:onCast(user, target)
	local damage = math.floor((user.chara:getStat("attack") * 15))

	local function generateSlash(scale_x)
		local cutAnim = Sprite("effects/attack/sling")
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
		local mult = 1
		if target.health == target.max_health then
			mult = 0.5
		end
		target:heal(damage)
		target:addMercy(math.ceil(target.service_mercy*1.3*mult))
	end)
end

return spell
