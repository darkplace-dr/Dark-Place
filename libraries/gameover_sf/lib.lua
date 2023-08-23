local lib = {}

function lib:init()
    if Kristal.getLibConfig("gameover_sf", "replaces_original") then
        ---@diagnostic disable-next-line: redefined-local
        Utils.hook(Game, "gameOver", function(_, self, x, y)
            Kristal.hideBorder(0)

            self.state = "GAMEOVER"

            if self.battle   then self.battle  :remove() end
            if self.world    then self.world   :remove() end
            if self.shop     then self.shop    :remove() end
            if self.gameover then self.gameover:remove() end

            self.gameover = GameOverSegaForever()
            self.stage:addChild(self.gameover)
        end)
    end
end

return lib