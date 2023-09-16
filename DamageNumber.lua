---@class DamageNumber : DamageNumber
---@overload fun(...) : DamageNumber
local DamageNumber, super = Class(DamageNumber)

function DamageNumber:init(type, arg, x, y, color)
	super:init(self, type, arg, x, y, color)

	if self.type == "tired" then
		self.font = Assets.getFont("bluenumbers")
		if self.amount >= 100 then
			self.type = "msg"
			self.message = "mercy"
		elseif self.amount < 0 then
			self.text = self.amount.."%"
			self.color = {self.color[1] * 0.75, self.color[2] * 0.75, self.color[3] * 0.75}
		else
			self.text = "+"..self.amount.."%"
		end
		self.x = self.x - 41
	end
end

return DamageNumber