local HangPlug, super = Class(Event, "hangplug")

function HangPlug:init(data)
    super:init(self, data.x, data.y, 0, 0)

    self.sprite = Sprite("idle", 0, 0, nil, nil, "world/events/hangplug")
    self.sprite:setScale(2, 2)
    self.sprite:setOrigin(0.5, 1)
    self:addChild(self.sprite)

    self.extension = Sprite("extension", 0, 0, nil, nil, "world/events/hangplug")
    self.extension:setScale(1, 20)
    self.extension:setOrigin(0, 1)
    self.extension.debug_select = false
    self.sprite:addChild(self.extension)

    self.debug_rect = {
        -self.sprite:getScaledWidth()/2,
        -self.sprite:getScaledHeight() - self.extension:getScaledHeight(),
        self.sprite:getScaledWidth(),
        self.sprite:getScaledHeight() + self.extension:getScaledHeight(),
    }

    self.siner = Utils.random(460)

    self.attack = data.properties["attack"] ~= false

    self.attack_timer_max = data.properties["interval"] or 150
    self.attack_timer = self.attack_timer_max - Utils.random(math.max(0, self.attack_timer_max - 20))
    self.attack_dist = data.properties["dist"] or 160
    self.attack_range = data.properties["range"] or 300
    self.damage = data.properties["damage"] or 18
    self.buffed = data.properties["buffed"] or false
    self.ignore_y = data.properties["ignorey"] or false

    self.timer = Timer()
    self:addChild(self.timer)

    -- IDLE, ATTACKING
    self.state = "IDLE"
end

function HangPlug:postLoad()
    self:setLayer(WORLD_LAYERS["above_bullets"])
end

function HangPlug:update()
    self.siner = self.siner + DTMULT

    self.sprite.y = math.sin(self.siner / 70) * 3

    if self.attack and self.world and self.world.player then
        local x_in_range = math.abs(self.world.player.x - self.x) <= self.attack_range
        local y_in_range = math.abs(self.world.player.y - self.y) <= self.attack_range or self.ignore_y
        if x_in_range and y_in_range then
            if self.state == "IDLE" then
                local cam_x, cam_y, cam_w, cam_h = self.world.camera:getBounds()

                self.attack_timer = self.attack_timer + DTMULT
                -- TODO: increase again if player is moving

                local in_bounds = cam_x <= self.x and self.x < cam_x + cam_w and (self.ignore_y or (cam_y <= self.y and self.y < cam_y + cam_h))

                if in_bounds and self.attack_timer >= self.attack_timer_max then
                    self.state = "ATTACKING"

                    self.sprite:setAnimation({"flash", 4/30, false, next = "idle"})
                    self.extension:setAnimation({"extension_flash", 4/30, false, next = "extension"})

                    self.timer:after(self.buffed and 8/30 or 15/30, function()
                        Assets.playSound("spearappear", 0.6)

                        self.attack_timer = Utils.random(self.attack_timer_max / 2) - 30

                        local bullet = self.world:spawnBullet("hangplug/spark", self.x, self.y, self.damage, self.attack_dist, self.buffed)
                        bullet:setLayer(self.world.map.object_layer - (self.world.map.depth_per_layer / 4))

                        self.state = "IDLE"
                    end)
                end
            end
        else
            self.sprite:setSprite("idle")
            self.extension:setSprite("extension")
        end
    end

    super:update(self)
end

return HangPlug