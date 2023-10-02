local WerewireSpareAnim, super = Class(Object)

function WerewireSpareAnim:init(x, y, after)
    super:init(self, x, y)

    self.actor_sprite = ActorSprite("werewire")
    self.actor_sprite:setScale(2, 2)
    self.actor_sprite:setOrigin(0.5, 1)
    self:addChild(self.actor_sprite)

    self.plug_sprite = Sprite("enemies/werewire/spare_plug")
    self.plug_sprite:setScale(2, 2)
    self.plug_sprite:setOriginExact(22, 187)
    self.plug_sprite:setPosition(-self.actor_sprite.width - 2, -self.actor_sprite.height*2 + 28)
    self.plug_sprite.layer = 1
    self:addChild(self.plug_sprite)

    self.timer = Timer()
    self:addChild(self.timer)


    self.actor_sprite:setAnimation("spare", function()
        self.plug_sprite:setSprite("enemies/werewire/spare_plug_full")
        self.plug_sprite.physics.speed_x = -8
        self.plug_sprite.physics.friction = 0.5
        self.plug_sprite.physics.gravity = -1.5

        self.actor_sprite:setSprite("spare_plugboy")

        Assets.stopAndPlaySound("spare")

        local spare_flash = self.actor_sprite:addFX(ColorMaskFX())
        spare_flash.amount = 0

        local sparkle_timer = 0

        self.timer:during(5/30, function()
            spare_flash.amount = spare_flash.amount + 0.2 * DTMULT
            sparkle_timer = sparkle_timer + DTMULT
            if sparkle_timer >= 0.5 then
                local x, y = Utils.random(-self.actor_sprite.width*2, 0), Utils.random(-self.actor_sprite.height*2, -self.actor_sprite.height)
                local sparkle = SpareSparkle(x, y)
                sparkle.layer = 0.5
                self:addChild(sparkle)
                sparkle_timer = sparkle_timer - 0.5
            end
        end, function()
            spare_flash.amount = 1
            local img1 = AfterImage(self.actor_sprite, 0.7, (1/25) * 0.7)
            local img2 = AfterImage(self.actor_sprite, 0.4, (1/30) * 0.4)
            img1:addFX(ColorMaskFX())
            img2:addFX(ColorMaskFX())
            img1.physics.speed_x = 4
            img2.physics.speed_x = 8
            self:addChild(img1)
            self:addChild(img2)
            self.actor_sprite:remove()
        end)

        self.timer:after(60/30, function()
            self:remove()

            if after then
                after()
            end
        end)
    end)
end

return WerewireSpareAnim