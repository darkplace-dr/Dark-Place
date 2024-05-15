local Basic, super = Class(Wave)

function Basic:init()
	super.init(self)
    self.time = 17
	
    self:setArenaPosition(240, 160)
	
    self.variant = 3
    self.is_cutscene = true
	
    self.attack_timer = 0
    self.siner = Utils.random(100)
    self.con = 0
	
    self.movecon = 0
    self.movetimer = 0
	
    self.arm_cannon_spr = Assets.getTexture("battle/bullets/sneo/arm_cannon")
    self.arm_cannon_scale_x = 2
    self.arm_cannon_angle = 170
    self.arm_cannon_origin_x = 7.5
	
    self.angle_final = 170
	
    self.eggcount = 20
    self.savex = 0
    self.firstshot = 1
    self.timervariance = 30
    self.pipiscount = 0
    self.speedvar = 2
    self.maxpipis = 10

    self.sneo = Game.battle:getEnemyBattler("sneo")
end

function Basic:draw()
    super.draw(self)
	
    self.siner = self.siner + 0.25 * DTMULT
	
    local xx = SCREEN_WIDTH - 10
    local yy = (SCREEN_HEIGHT - 230) + (math.sin((self.siner / 6)) * 21)
    local shake = 0
	
    if self.arm_cannon_spr == Assets.getTexture("battle/bullets/sneo/arm_cannon_pipis") then
        shake = -4 + Utils.random(8)
    end
	
    if self.movecon == 0 and self.sneo.x == 818 then
        self.movetimer = self.movetimer + DTMULT
        xx = Utils.lerp((SCREEN_WIDTH + 70), (SCREEN_WIDTH - 10), (self.movetimer / 10))
        if self.movetimer == 10 then
            self.movetimer = 0
            self.movecon = 1
        end
    end

    if self.movecon == 2 then
        self.movetimer = self.movetimer + DTMULT
        xx = Utils.lerp((SCREEN_WIDTH - 10), (SCREEN_WIDTH + 70), (self.movetimer / 10))
        if self.movetimer == 10 then
        end
    end
	
	if Game.battle.wave_timer > 16 then
	    self.movecon = 2
    end
	
    if self.variant == 3 and self.movecon == 1 then
        if self.con == 0 then
            self.attack_timer = self.attack_timer + DTMULT
            if self.attack_timer >= 1 then
                self.wall = self:addChild(PipisWall(Game.battle.arena.x + 200, Game.battle.arena.bottom))
                self.wall.type = 1
                self.con = 1
                self.attack_timer = 0
            end
        end
        if self.con == 1 then
            xx = (SCREEN_WIDTH - 10)
            for i = 1, 3 do
                if (Utils.random(10) < 6) then
                    bul = self:spawnBullet("sneo/pipis", (xx + 5) + (math.sin(self.arm_cannon_angle) * 50), yy + (math.cos(self.arm_cannon_angle + 270) * 50))
                    bul.type = 2
                    bul.physics.gravity = (0.2 + (Utils.random(3) / 100))
                    bul.physics.speed_y = (-6 - Utils.random(2))
                    bul.physics.speed_x = (-1.6 - Utils.random(3))
                    bul.layer = (self.layer - 1)
                else
                    bul = self:spawnBullet("sneo/sneobomb_pipis", (xx + 5) + (math.sin(self.arm_cannon_angle) * 50), yy + (math.cos(self.arm_cannon_angle + 270) * 50))
                    bul.physics.gravity = (0.2 + (Utils.random(3) / 100))
                    bul.physics.speed_y = (-6 - Utils.random(2))
                    bul.physics.speed_x = (-1.8 - Utils.random(1.5))
                    bul.layer = (self.layer - 1)
                end
            end
            self.arm_cannon_spr = Assets.getTexture("battle/bullets/sneo/arm_cannon")
            self.arm_cannon_origin_x = 7.5
            self.angle_final = (180 + Utils.random(-50))
            for i = 0, 3 do
                bul = self:spawnBullet(obj_sneo_armcannon_smoke, (xx + 5) + (math.sin(self.arm_cannon_angle + 270) * 50), yy + (math.cos(self.arm_cannon_angle + 270) * 50))
                bul.layer = (self.layer - 2)
            end
            self.con = 2
        end
        if self.con == 2 then
            self.attack_timer = self.attack_timer + DTMULT
            if self.attack_timer < 11 then
                self.arm_cannon_angle = Utils.lerp(self.arm_cannon_angle, self.angle_final, (self.attack_timer / 10))
            end
            if self.attack_timer < (self.timervariance - 15) and self.eggcount > 0.4 then
                self.arm_cannon_scale_x = Utils.lerp(1.8, 2.5, (self.attack_timer / (self.timervariance - 15)))
            end
            if self.attack_timer >= (self.timervariance - 15) and self.eggcount > 0.4 then
                self.arm_cannon_spr = Assets.getTexture("battle/bullets/sneo/arm_cannon_pipis")
                self.arm_cannon_scale_x = 2
                self.arm_cannon_origin_x = 11.5
            end
            if self.attack_timer >= self.timervariance then
                self.eggcount = self.eggcount - 0.4 * DTMULT
                self.timervariance = (60 + Utils.random(15))
                self.con = 1
                self.attack_timer = 0
            end
        end
    end
	
    if self.variant == 2 or self.variant == 3 and self.sneo.x == 818 then
        Draw.draw(Assets.getTexture("npcs/sneo/wing_l"), (xx - 20), ((yy - 40) + 20), math.rad(-20), 2, 2)
        Draw.draw(self.arm_cannon_spr, xx, ((yy + 11) + (shake / 2)), math.rad(self.arm_cannon_angle + shake), self.arm_cannon_scale_x, 2, self.arm_cannon_origin_x, 0)
        Draw.draw(Assets.getTexture("npcs/sneo/body"), (xx - 10), ((yy - 40) + 20), 0, 2, 2)
        Draw.draw(Assets.getTexture("npcs/sneo/head_2"), (xx + 26), yy, 0, 2, 2)
    end
end

function Basic:onStart()
	Game.battle:swapSoul(YellowSoul())
    self.sneo:setMode("move_back")
end

function Basic:onEnd()
    self.sneo:setMode("normal")
    Game.battle.wave_timer = 0
end

return Basic