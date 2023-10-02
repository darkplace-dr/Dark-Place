local BG, super = Class(Object)

function BG:init(color, fill)
    super:init(self)
    self.color = color
    self.fill = fill or {0, 0, 0}
	self.offset = 0
    self.speed = 0.5
    self.size = 50
    self.layer = BATTLE_LAYERS["bottom"]
    Game.battle.discoball = Discoball()
    Game.battle:addChild(Game.battle.discoball)

end

function BG:update(dt)
    super:update(self, dt)
    self.fade = Game.battle.transition_timer / 10
    self.offset = self.offset + self.speed*DTMULT
	
    if self.offset >= 100 then
        self.offset = self.offset - 100
    end
end

function BG:draw()
    super:draw(self)

    local r,g,b,a = unpack(self.fill)
    love.graphics.setColor(r,g,b, a or self.fade)
    love.graphics.rectangle("fill", -10, -10, SCREEN_WIDTH+10, SCREEN_HEIGHT+10)

    local r,g,b,a = unpack(self.color)
    love.graphics.setColor(r,g,b, a or self.fade)
    for x = 0, 1, 50 do
        for y = 0, 1, 50 do
            local dojo = Assets.getTexture("battle/dojo_battlebg")
            love.graphics.draw(dojo, SCREEN_WIDTH/2, (SCREEN_HEIGHT/2)-50, 0, (2 + math.sin(self.offset/2) * 0.008), (2 + math.cos(self.offset/2) * 0.008), dojo:getWidth()/2, dojo:getHeight()/2)
        end
    end
end

return BG