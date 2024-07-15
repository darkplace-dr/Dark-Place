local OpponentBoxDisplay, super = Class(Object)

function OpponentBoxDisplay:init(actbox, color, x, y)
    super:init(self, x, y)

    self.font = Assets.getFont("smallnumbers")

    self.actbox = actbox
	
	self.color = color
end

function OpponentBoxDisplay:draw()
    love.graphics.setColor({0,0,0,1})

    love.graphics.setLineWidth(2)
    love.graphics.line(0  , Game:getConfig("oldUIPositions") and 2 or 1, 213, Game:getConfig("oldUIPositions") and 2 or 1)

    love.graphics.setLineWidth(2)

    love.graphics.setColor(PALETTE["action_fill"])
    love.graphics.rectangle("fill", 2, Game:getConfig("oldUIPositions") and 3 or 2, 209, Game:getConfig("oldUIPositions") and 34 or 35)

    love.graphics.setColor(PALETTE["action_health_bg"])
    love.graphics.rectangle("fill", 128, 22 - self.actbox.data_offset, 76, 9)

    local health = (Game.card_game.opponent_hp / Game.card_game.max_hp) * 76

    if health > 0 then
        love.graphics.setColor(self.color)
        love.graphics.rectangle("fill", 128, 22 - self.actbox.data_offset, health, 9)
    end


    if health <= 0 then
        love.graphics.setColor(PALETTE["action_health_text_down"])
    elseif (Game.card_game.opponent_hp <= (Game.card_game.max_hp / 4)) then
        love.graphics.setColor(PALETTE["action_health_text_low"])
    else
        love.graphics.setColor(PALETTE["action_health_text"])
    end


    local health_offset = 0
    health_offset = (#tostring(Game.card_game.opponent_hp) - 1) * 8

    love.graphics.setFont(self.font)
    love.graphics.print(Game.card_game.opponent_hp, 152 - health_offset, 9 - self.actbox.data_offset)
    love.graphics.print("/", 161, 9 - self.actbox.data_offset)
    local string_width = self.font:getWidth(tostring(Game.card_game.max_hp))
    love.graphics.print(Game.card_game.max_hp, 205 - string_width, 9 - self.actbox.data_offset)

    super:draw(self)
end

return OpponentBoxDisplay