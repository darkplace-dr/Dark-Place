local FinalFroggitActor, super = Class(ActorSprite)

function FinalFroggitActor:init(actor)
    super.init(self, actor)

    self.draw_children_below = 0
    self.draw_children_above = 1
	
    self.siner = 0
    self.anim = 0
    self.anim2 = 0
    self.anim3 = 0
    self.xx = 0
    self.yy = 0
    self.pause = 0
    self.offx = 24
    self.offy = 60
end

function FinalFroggitActor:draw()
    super.draw(self)
	
    if self.sprite == "enemies/finalfroggit/lightbattle/hurt" then
        self.siner = 0
        self.x = self.x
    end
	
    love.graphics.setColor(1, 1, 1, 1)
	
    Draw.draw(Assets.getTexture("enemies/finalfroggit/lightbattle/body"), (self.x + self.offx), ((self.offy + self.y)), 0, 1, (1 - (math.sin((self.siner / 3)) * 0.05)), (51 / 2), 28)
    if self.animation ~= "lightbattle_hurt" then
        Draw.draw(Assets.getTexture("enemies/finalfroggit/lightbattle/head"), ((self.offx + self.x) - (math.sin((self.siner / 6)) * 5)), ((self.offy + self.y) + (math.sin((self.siner / 3)) * 1.05) - 28), ((-(math.sin((self.siner / 6)))) * 0.05), 1, 1, (51 / 2), 39)
    else
        Draw.draw(Assets.getTexture("enemies/finalfroggit/lightbattle/head_hurt"), ((self.offx + self.x) - (math.sin((self.siner / 6)) * 5)), ((self.offy + self.y) + (math.sin((self.siner / 3)) * 1.05) - 28), ((-(math.sin((self.siner / 6)))) * 0.05), 1, 1, (51 / 2), 39)
    end

    self.siner = self.siner + DTMULT
    --self.anim = self.anim + DTMULT
end

return FinalFroggitActor