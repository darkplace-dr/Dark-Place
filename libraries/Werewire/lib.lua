local Lib = {}

function Lib:init()
    Utils.hook(Battle, "spawnEnemyTextbox", function(orig, self, enemy, ...)
        if enemy and enemy.id == "werewire" then
            local x, y = enemy.sprite:getRelativePos(0, enemy.sprite.height/2, self)
            if enemy.dialogue_offset then
                x, y = x + enemy.dialogue_offset[1], y + enemy.dialogue_offset[2]
            end
            local textbox = WerewireTextbox(x, y)
            self:addChild(textbox)
            return textbox
        else
            return orig(self, enemy, ...)
        end
    end)
end

return Lib