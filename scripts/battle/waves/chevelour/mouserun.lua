local run_away, super = Class(Wave)

function run_away:init()
    super:init(self)
    self.time = -1
    self.path_selections = math.random(5,10)
end

function run_away:onStart()
    -- Every 0.33 seconds...
    self.timer:script(function(wait)
        local chevelour = Game.battle.enemies[1]
        chevelour:setLayer(BATTLE_LAYERS["bullets"])
        chevelour.collider = Hitbox(chevelour, chevelour.x+10, chevelour.y+10, chevelour.width-10, chevelour.height-10)
        wait(0.5)
        chevelour:setSprite("warning")
        Assets.playSound("squeak")
        wait(0.2)
        Assets.playSound("squeak")
        wait(.5)
        chevelour:setAnimation("skate")
        self.timer:tween(1.6, chevelour, {x=-60})
        wait(0.5)
        self.timer:everyInstant(1/30, function()
            local bullet = self:spawnBullet("chevelour/mouse", (SCREEN_WIDTH+15)+Utils.random(6, 6*4), chevelour.y+Utils.random(-30, 30))
            bullet.physics.direction = math.rad(180)
            bullet.physics.speed = Utils.random(19, 21)
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
        self.timer:everyInstant(0.5, function()
            if self.finished_path then
                self.finished_path = false
                if self.path_selections>0 then
                    local path = Utils.pick(self.pathes)
                    chevelour:setPosition(path[1], path[2])
                    chevelour.sprite.alpha = 1
                    self.timer:tween(1.3, chevelour, {x=path[3], y=path[4]}, nil, function() chevelour.sprite.alpha = 0 end)
                    self.timer:after(0.5, function()
                        self.timer:everyInstant(1/30, function()
                            local bullet = self:spawnBullet("chevelour/mouse", path[1]+Utils.random(6, 6*4), path[2]+Utils.random(-30, 30))
                            bullet.tp = bullet.tp /2
                            bullet.physics.direction = Utils.angle(bullet.x, bullet.y, path[3] or path[1], path[4])
                            bullet.physics.speed = Utils.random(19, 21)
                        end, 20)
                        self.timer:after(((1/30)*20)+0.5, function()
                            self.finished_path = true
                            self.path_selections = self.path_selections - 1
                        end)
                    end)
                else
                    chevelour:setPosition(SCREEN_WIDTH+20, 216)
                    chevelour.sprite.alpha = 1
                    self.timer:tween(1.5, chevelour, {x=550, y=216}, nil, function()
                        chevelour:setSprite("idle")
                        self.finished = true
                    end)
                end
            end
        end)
    end)
end

function run_away:update()
    -- Code here gets called every frame

    super:update(self)
end

return run_away