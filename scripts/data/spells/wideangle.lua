local spell, super = Class(Spell, "wideangle")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "WideAngle"
    -- Name displayed when cast (optional)
    self.cast_name = nil

    -- Battle description
    self.effect = "Examine\nenemies."
    -- Menu description
    self.description = "Examines the statistics of enemies."

    -- TP cost
    self.cost = 0

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {"check"}
end

function spell:getCastMessage(user, target)
    --return "* "..user.chara:getName().." used "..self:getCastName().."!"
	return "* "..string.upper(target.name).." - "..target.check
end


function spell:onCast(user, target)
	
	
	Assets.playSound("criticalswing")
	
	target:flash()
	
	local x, y = target:getRelativePos(target.width/2, target.height/2, Game.battle)
	
    local sprite = Sprite("effects/spells/dess/wideangle", x, y)
    sprite:setOrigin(0.5, 0.5)
    sprite:setScale(5)
    sprite.layer = BATTLE_LAYERS["above_battlers"]
	sprite.graphics.grow = -1
	sprite.graphics.remove_shrunk = true
	Game.battle:addChild(sprite)
	
	local function makeAfterImage(x2, y2)
		local sprite2 = Sprite("effects/spells/dess/wideangle", x2, y2)
		sprite2:setOrigin(0.5, 0.5)
		sprite2:setScale(sprite.scale_x)
		sprite2.layer = BATTLE_LAYERS["above_battlers"]
		sprite2:fadeOutAndRemove(0.3)
		sprite2.graphics.remove_shrunk = true
		Game.battle:addChild(sprite2)
		return sprite2
	end
	
	local afterImages = {}
	
	Game.battle.timer:during(1, function()
	
		makeAfterImage(x, y)
	
	end)
	
	Game.battle:finishActionBy(user)
    return false
end

return spell