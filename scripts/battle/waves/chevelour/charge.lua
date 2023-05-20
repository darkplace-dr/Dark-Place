local Charge, super = Class(Wave)

function Charge:init()
    super:init(self)

    self.time = 8
    self:setArenaSize(150)
end

function Charge:onStart()
    -- Every 0.33 seconds...
    self.timer:script(function(wait)
        local chevelour = Game.battle.enemies[1]
        chevelour:setLayer(BATTLE_LAYERS["bullets"])
        chevelour.collider = Hitbox(chevelour, 0, 0, chevelour.width, chevelour.height)
        wait(0.5)
        chevelour:setSprite("warning")
        Assets.playSound("squeak")
        wait(.5)
        chevelour:setAnimation("skate")
        self.timer:tween(1.6, chevelour, {x=-60})
        wait(0.5)
        self.timer:everyInstant(1/30, function()
            local bullet = self:spawnBullet("charge")
            bullet.physics.direction = math.rad(180)
            bullet.physics.speed = Utils.random(25)
        end, 40)
        wait(((1/30)*40)+0.3)
        self.pathes = {
            {-20, -20, SCREEN_WIDTH+20, SCREEN_HEIGHT+20},
            {Utils.random(Game.battle.arena.left, Game.battle.arena.right), 0, nil, SCREEN_HEIGHT+50},
            {-20, SCREEN_HEIGHT/4, SCREEN_WIDTH+20, SCREEN_HEIGHT/3},
            {-20, SCREEN_HEIGHT-75, SCREEN_WIDTH+20, 100},
            {-20, Game.battle.arena.top, SCREEN_WIDTH+20, Game.battle.arena.bottom},
            {-20, Game.battle.arena.bottom, SCREEN_WIDTH+20, Game.battle.arena.top}
        }
        self.finished_path = true
        chevelour:setPosition(SCREEN_WIDTH+20, 216)
            chevelour.sprite.alpha = 1
            self.timer:tween(1.5, chevelour, {x=550, y=216}, nil, function()
                chevelour:setSprite("idle")
                self.finished = true
            end)
        end)
    end

function Charge:update()
    -- Code here gets called every frame

    super:update(self)
end


return Charge