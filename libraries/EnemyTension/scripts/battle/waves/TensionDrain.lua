local TensionDrain, super = Class(Wave)
function TensionDrain:init()
    super:init(self)
    self.user = self:getAttackers()[1]
    --[[ Unimportant stuff from when this was part of the mirror fight.
    self.user.defense = 0
    self.user.state = "idle"
    -- For kris, this is in front of their hand when pointing in the act animation.
    ]]
    self.init_x = self.user.x - 35
    self.init_y = self.user.y - 50  

end

function TensionDrain:onStart()
    --[[
    self.user.state = "act"
    self.user.sprite:set("battle/act") -- Mirror Kris used their act animation for this wave.
    --]]
    self.enemySoul = self:spawnBullet("EnemySoul", self.init_x, self.init_y, angle, speed)

end

function TensionDrain:update()
    super:update(self)
end


function TensionDrain:onEnd()
    super:onEnd(self)
    --self.user.sprite:set("idle")
    
end

return TensionDrain