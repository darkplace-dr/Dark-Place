local Basic, super = Class(Wave)

function Basic:init()
	super:init(self)
	
	self.time = -1
	self:setArenaSize(240, 110)
	self:setArenaPosition(300, 175)
	
    self.type = 1

    self.debug_font = Assets.getFont("sans")
    self.debug_render = false
end

function Basic:onStart()
	Game.battle:swapSoul(YellowSoul())
    local arena = Game.battle.arena
	
    self.debug_render = true
	
    if self.type == 1 then
        self.phonehand_master = self:spawnBullet("sneo/phonehand_master", arena.x + 40 + arena.width / 2, arena.y)
        self.phonehand_master.difficulty = 0
    elseif self.type == 2 then
        self.phonehand_master = self:spawnBullet("sneo/phonehand_master", arena.x + 40 + arena.width / 2, arena.y)
        self.phonehand_master.difficulty = 2
    end
end

function Basic:onEnd()
    self.debug_render = false
end

function Basic:draw()
    super.draw(self)
	
    if self.debug_render == true then
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.setFont(self.debug_font)
		
        local dbg1 = string.format(
            [[difficulty = %.2f
alpha = %.2f
hp = %d
            ]],
            self.phonehand_master.difficulty, 
            self.phonehand_master.alpha, 
            self.phonehand_master.shot_health
        )
		
        local dbg2 = string.format(
            [[
            x_pos = %d
            y_pos = %d
            joint_x_top = %d
            joint_y_top = %d
            ]],
            self.phonehand_master.x,
            self.phonehand_master.y,
            self.phonehand_master.phonehand_top.x,
            self.phonehand_master.phonehand_top.y
        )

        love.graphics.printf("--PHONEHAND DEBUG--", 10, 380, SCREEN_WIDTH*2, "left", 0, 0.5, 0.5)
        love.graphics.printf(dbg1, 10, 400, SCREEN_WIDTH*2, "left", 0, 0.5, 0.5)
        love.graphics.printf(dbg2, 150, 400, SCREEN_WIDTH*2, "left", 0, 0.5, 0.5)
    end
end

return Basic