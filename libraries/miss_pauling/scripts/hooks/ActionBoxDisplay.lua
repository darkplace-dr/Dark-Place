---@class ActionBoxDisplay
---@overload fun(...) : ActionBoxDisplay
local ActionBoxDisplay, super = Class("ActionBoxDisplay", true)

function ActionBoxDisplay:draw()
	if self.actbox.battler.chara.id == "pauling" then
		if Game.battle.current_selecting == self.actbox.index then
			Draw.setColor(self.actbox.battler.chara:getColor())
		else
			Draw.setColor(PALETTE["action_strip"], 1)
		end

		love.graphics.setLineWidth(2)
		love.graphics.line(0  , Game:getConfig("oldUIPositions") and 2 or 1, 213, Game:getConfig("oldUIPositions") and 2 or 1)

		love.graphics.setLineWidth(2)
		if Game.battle.current_selecting == self.actbox.index then
			love.graphics.line(1  , 2, 1,   36)
			love.graphics.line(212, 2, 212, 36)
		end
		
		Draw.setColor(PALETTE["action_fill"])
		love.graphics.rectangle("fill", 2, Game:getConfig("oldUIPositions") and 3 or 2, 209, Game:getConfig("oldUIPositions") and 34 or 35)
			
		Draw.setColor(PALETTE["action_health_bg"])
		love.graphics.rectangle("fill", 182, 10 - self.actbox.data_offset, 20, 20)
			
		local health = (self.actbox.battler.chara:getHealth() / self.actbox.battler.chara:getStat("health")) * 20

		if health > 0 then
			Draw.setColor({1,1,0})
			love.graphics.rectangle("fill", 182, 10 - self.actbox.data_offset + (20 - math.ceil(health)), 20, math.ceil(health))
		end
			
		local cover = Assets.getTexture("ui/battle/health_cover_overtime")
		Draw.setColor({1,1,1})
		love.graphics.draw(cover, 180, 8 - self.actbox.data_offset)
		
		if self.actbox.battler.shield then
			local bar_outline = Assets.getTexture("ui/battle/shield_cover")
			Draw.pushScissor()
			Draw.scissorPoints(180, 32 - math.ceil((self.actbox.battler.shield / self.actbox.battler.chara:getMaxShield()) * 24), 204, 32)
			Draw.draw(bar_outline, 180, 8)
			Draw.popScissor()
		end
			
		local color = PALETTE["action_health_text"]
		if health <= 0 then
			color = PALETTE["action_health_text_down"]
		elseif (self.actbox.battler.chara:getHealth() <= (self.actbox.battler.chara:getStat("health") / 4)) then
			color = PALETTE["action_health_text_low"]
		else
			color = PALETTE["action_health_text"]
		end

		local health_offset = 0
		health_offset = (#tostring(self.actbox.battler.chara:getHealth()) - 1) * 8

		Draw.setColor(color)
		love.graphics.setFont(self.font)
		love.graphics.print(self.actbox.battler.chara:getHealth(), 122 - health_offset, 9 - self.actbox.data_offset)
		Draw.setColor(PALETTE["action_health_text"])
		love.graphics.print("/", 131, 9 - self.actbox.data_offset)
		local string_width = self.font:getWidth(tostring(self.actbox.battler.chara:getStat("health")))
		Draw.setColor(color)
		love.graphics.print(self.actbox.battler.chara:getStat("health"), 175 - string_width, 9 - self.actbox.data_offset)
		if Mod.libs["karma"] then
			super.super.super.draw(self)
		else
			super.super.draw(self)
		end
	else
		super.draw(self)
	end
end

return ActionBoxDisplay