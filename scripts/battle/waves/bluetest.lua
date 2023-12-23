local CollideTest, super = Class(Wave)

function CollideTest:init()
    super.init(self)
    self:setArenaSize(280, 140)
    self:setSoulPosition(240, 172)
    self.time = -1
    self.siner = 0
    self.solid = nil
    self.mode = 0
end

function CollideTest:onStart()
    Game.battle:swapSoul(BlueSoul())
    Game.battle.soul.can_doublejump = true
    local arena = Game.battle.arena

    --[[
    self:spawnBulletTo(Game.battle.arena, "smallbullet", arena.width/2, 10)
    self:spawnBulletTo(Game.battle.arena, "smallbullet", arena.width/2, 25)
    self:spawnBulletTo(Game.battle.arena, "smallbullet", arena.width/2, 40)
    self:spawnBulletTo(Game.battle.arena, "smallbullet", arena.width/2, 55)
    self:spawnBulletTo(Game.battle.arena, "smallbullet", arena.width/2, 70)
    self:spawnBulletTo(Game.battle.arena, "smallbullet", arena.width/2, 85)
    self:spawnBulletTo(Game.battle.arena, "smallbullet", arena.width/2, 100)
    self:spawnBulletTo(Game.battle.arena, "smallbullet", arena.width/2, 115)
    self:spawnBulletTo(Game.battle.arena, "smallbullet", arena.width/2, 130)
    --]]

    self.start_x = 320
    self.start_y = 200

    self.solid = self:spawnObject(Solid(true, 320, 200, 60, 5))
    self.solid:setLayer(BATTLE_LAYERS["above_arena"])
    self.solid:setOrigin(0.5, 0.5)
    self.solid.hitbox = Hitbox(self.solid, 0, -5, 60, 5)

    self:spawnBullet("endbullet", 320, 130)


    --[[
    local checker = CollisionCheck(x, y)

    checker.collider = ColliderGroup(checker, {
        CircleCollider(checker, 0, 0, 32, {inside = true}),
        CircleCollider(checker, 0, 0, 32, {invert = true})
    }, {invert = true})

    Game.battle:addChild(checker)
    table.insert(self.objects, checker)
    --]]
end

function CollideTest:update()
    super.update(self)

    if Input.pressed("menu") then
        local burst
        Assets.playSound("bell")
        if self.mode == 0 then
            Game.battle:swapSoul(BouncySoul())
            self.mode = 1
            burst = HeartBurst(-9, -9, {1,(148/255),0})
        else
            Game.battle:swapSoul(BlueSoul())
            self.mode = 0
            burst = HeartBurst(-9, -9, {0,0,1})
        end

        Game.battle.soul.can_doublejump = true
        Game.battle.soul:addChild(burst)
    end

    self.siner = self.siner + DT

    if self.solid then
        self.solid:moveTo(self.start_x + math.sin(self.siner*2) * 60, self.start_y)
    end

    local soul = Game.battle.soul
    --[[
    if self.solid.hitbox:collidesWith(Game.battle.soul) then
        soul:setParent(self.solid)
        soul:flash()
    else
        soul:setParent(Game.battle.soul)
    end
    --]]

end


return CollideTest
