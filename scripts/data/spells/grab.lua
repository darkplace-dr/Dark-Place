local spell, super = Class(Spell, "grab")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Grab"

    -- Battle description
    self.effect = "Flame"
    -- Menu description
    self.description = "Attempt to slow down an enemy, making them lose their turn."

    -- TP cost
    self.cost = 50

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    -- Tags that apply to this spell
    self.tags = {"Status"}
	
	self.success = 0
end

function spell:getCastMessage(user, target)
	if target.boss then
		return "* "..user.chara:getName().." used "..self:getCastName().."!\n* It had no effect..."
	end
	
	self.success = love.math.random(1,100)
	
	if self.success > 50 then
		return "* "..user.chara:getName().." used "..self:getCastName().."!\n* It worked!\n* " .. target.name .. "'s turn is skipped."
	end
    return "* "..user.chara:getName().." used "..self:getCastName().."!\n* " .. target.name .. " resisted!"
end

function spell:onCast(user, target)
	if self.success > 50 and not target.boss then
		target.wii_grab = true
	end
end

return spell
