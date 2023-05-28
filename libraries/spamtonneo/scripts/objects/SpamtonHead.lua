local Head, super = Class("SpamtonPart")

function Head:init(x, y)
    super:init(self, "npcs/spamton/head", x, y, 17, 26, math.rad(10))
    self.animating = true
    self.anim_timer = 0
    self.anim_speed = 0.5
end

function Head:update()
    if self.animating then
        self.anim_timer = self.anim_timer + DT
        if self.anim_timer > self.anim_speed then
            self.anim_timer = self.anim_timer - self.anim_speed
            self.sprite:setFrame(self.sprite.frame % 3 + 1)
        end
    end
    super:update(self)
    if self.sprite.frame == 3 then
        self.sprite.rotation = self.sprite.rotation - math.rad(20)
    end
end

function Head:setFrame(num)
    self.sprite:setFrame(num)
end

return Head