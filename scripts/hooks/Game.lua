---@class Game
---@field minigame MinigameHandler

Utils.hook(Game, "gameOver", function(orig, self, x, y, sf)
    if Game:getFlag("fun", 0) ~= 18 --[[0xE+0xA]] and not sf then
        orig(self, x, y)
        return
    else
        Mod:rollFun()
    end

    Kristal.hideBorder(0)

    self.state = "GAMEOVER"

    if self.battle   then self.battle  :remove() end
    if self.world    then self.world   :remove() end
    if self.shop     then self.shop    :remove() end
    if self.gameover then self.gameover:remove() end

    self.gameover = GameOverSegaForever(sf == "bearers" and true or nil)
    self.stage:addChild(self.gameover)
end)

return Game