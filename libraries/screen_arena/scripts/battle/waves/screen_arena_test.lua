local ScreenArenaTest, super = Class(Wave)

function ScreenArenaTest:init()
    super.init(self)
    self.screen_arena = true
    self.time = self.time + 2
end

function ScreenArenaTest:onStart()
    self.timer:after(2, function()
        self.timer:every(1/3, function()
            local x = SCREEN_WIDTH + 20
            local y = Utils.random(Game.battle.arena.top, Game.battle.arena.bottom)

            local bullet = self:spawnBullet("smallbullet", x, y, math.rad(180), 8)

            bullet.remove_offscreen = false
        end)
    end)
end

return ScreenArenaTest