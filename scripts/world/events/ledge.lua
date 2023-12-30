local Ledge, super = Class(Event)

function Ledge:init(data)
    super:init(self, data.x, data.y)

    data.properties = data.properties or {}

    self.collider = Utils.colliderFromShape(self, data)
    
    self.downamount = data.properties["amount"] or 60

    self.solid = true
end

function Ledge:onCollide(chara)
    if chara.is_player and chara.state == "WALK" then
        chara:setFacing("down")

        chara:setState("HOP", chara.x, self.y + self.downamount)
    end
end

return Ledge