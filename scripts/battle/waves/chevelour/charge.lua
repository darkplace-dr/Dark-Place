local Wave, super = Class(Wave)

function Wave:init()
    super.init(self)

    self.time = 7.5
    self.pounces = 5

    self:setArenaSize(86)

    self.moninis = {}
    for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
        if enemy.id == "chevelour" then
            self.enemy = enemy
            break
        end
    end

    self.start_x = self.enemy.x
    self.start_y = self.enemy.y
    self.start_layer = self.enemy.layer

    self.entered = false
    self.active = true

end

function Wave:onStart()

    local chevelour = Game.battle.enemies[1]

    local arena = Game.battle.arena
    local soul = Game.battle.soul
    local x, y = arena.width / 2, arena.height / 2
    self.collider = CircleCollider(arena, x, y, 140, {inside = true})

    self.enemy:setOrigin(0.5, 0.5)
    self.enemy.y = self.enemy.y - self.enemy.height

    self.enemy.hitbox = self:spawnBulletTo(self.enemy, "hitbox")
    self.enemy.hitbox:setHitbox(8, 17, 6, 7)
    self.enemy.hitbox.destroy_on_hit = false

    self.enemy.layer = BATTLE_LAYERS["bullets"]

    self:pounce(soul.x, soul.y - 30)

    chevelour:setSprite("warning")
    Assets.playSound("squeak")

end

function Wave:pounce(x, y)

    local angle = Utils.angle(self.enemy.x, self.enemy.y, x, y)

    self.enemy.physics.direction = angle

    Game.battle.timer:script(function(wait)

        Assets.stopAndPlaySound("wing", 1.3)
        wait(0.65)
        Assets.stopAndPlaySound("cardrive", 1.1, 1.3)
        self.enemy.physics.gravity = 0.08
        self.enemy.physics.speed = 17
        wait(1)
        self.enemy.hitbox.collidable = true

    end)

end

function Wave:pounceEnd()
    local soul = Game.battle.soul
    Game.battle.timer:script(function(wait)

        self.pounces = self.pounces - 1

        self.enemy.hitbox.grazed = false
        if self.enemy.x <= soul.x then
            self.enemy.flip_x = true
        elseif self.enemy.x >= soul.x then
            self.enemy.flip_x = false
        end
        self.enemy:setAnimation("skate")
        Assets.stopAndPlaySound("whip_throw_only")
        Game.battle.timer:tween(7/30, self.enemy, {physics = {speed = 0}}, "out-quad", function()
            self.enemy:resetPhysics()
        end)
        wait(10/30)

        if self.pounces > 0 then
            self:pounce(soul.x, soul.y - 20)
        else
            --self.can_end = true
        end

    end)

end

function Wave:checkPounceEnd()

    local arena = Game.battle.arena

    if self.active then
        if self.entered == false and self.enemy.hitbox:collidesWith(self.collider) then
            self.entered = true
        elseif self.entered == true and not self.enemy.hitbox:collidesWith(self.collider) then
            self.enemy.hitbox.collidable = false
            self.entered = false
            self:pounceEnd(true)
        end
    end

end

function Wave:lastPounce()

    Game.battle.timer:script(function(wait)

        self.enemy:resetPhysics()
        if self.enemy.flip_x == false then
            self.enemy.flip_x = true
        end
        self.enemy:setAnimation("idle")
        Assets.stopAndPlaySound("wing", 1.3)
        wait(0.4)
        self.enemy:setAnimation("skate")
        Assets.stopAndPlaySound("cardrive", 1.1, 1.3)
        Game.battle.timer:tween(0.5, self.enemy, {origin_y = 1})
        self.enemy:slideTo(self.start_x, self.start_y, 1/2)
        wait(1/2)
        self.enemy.flip_x = false
        self.enemy:setAnimation("idle")
        Assets.stopAndPlaySound("whip_throw_only")

    end)

end

function Wave:update()
    self:checkPounceEnd()

    super.update(self)
end

function Wave:onEnd()

    self:lastPounce()
            self.enemy:setOrigin(0.5, 1)

    self.enemy.layer = self.start_layer

end

function Wave:draw()

    if DEBUG_RENDER and self.collider then
        self.collider:drawFor(self, 1, 0, 0)

        local font = Assets.getFont("main", 16)
        love.graphics.setFont(font)
    
        local colliding = ""
        if self.enemy.hitbox then
            colliding = self.enemy.hitbox:collidesWith(self.collider)
        end
    
        Draw.setColor(1, 1, 1, 1)
        --Game.battle:debugPrintOutline("Entered? " .. tostring(self.entered), 200, 0)
        --Game.battle:debugPrintOutline("Active? "  .. tostring(self.active), 200, 16)
        --Game.battle:debugPrintOutline("Collide? " .. tostring(colliding), 200, 32)
        --Game.battle:debugPrintOutline("Pounces? " .. tostring(self.pounces), 400, 0)
        Game.battle:debugPrintOutline("homex " .. tostring(self.start_x), 400, 16)
        Game.battle:debugPrintOutline("homey " .. tostring(self.start_y), 400, 32)
    end

end

return Wave