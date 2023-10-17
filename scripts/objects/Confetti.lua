local Confetti, super = Class(Object)

function Confetti:init()
    super.init(self)
    self:setOrigin(0.5)
    self.sprite = Sprite("world/events/confetti")
    self.sprite:setScale(2)
    self:addChild(self.sprite)
    self.sprite:play(1/15, true)
    self.sprite.color = {Utils.random(0,1),Utils.random(0,1),Utils.random(0,1)}
    self.physics.speed_y = 5

    self.layer = WORLD_LAYERS["below_ui"]

    Game.world.timer:after(1, function ()
        self:fadeOutSpeedAndRemove(0.5)
    end)


end

return Confetti