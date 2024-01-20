local Ledge, super = Class(Event)

function Ledge:init(data)
    super:init(self, data.x, data.y)

    data.properties = data.properties or {}

    self.collider = Utils.colliderFromShape(self, data)
    
    self.x_axis = data.properties["x"] or false

    self.downamount = data.properties["amount"] or 60

    self.solid = true
end

function Ledge:onCollide(chara)
    if chara.is_player and chara.state == "WALK" then
        if not self.x_axis then
            chara:setFacing("down")
            chara:setState("HOP", chara.x, self.y + self.downamount)
        else
            if self.downamount < 0 then
                chara:setFacing("left")
            else
                chara:setFacing("right")
            end
            chara:setState("HOP", self.x + self.downamount, chara.y)
        end
    end
end

return Ledge