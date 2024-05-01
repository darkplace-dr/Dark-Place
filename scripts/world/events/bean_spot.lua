local BeanSpot, super = Class(Event, "beanspot")

function BeanSpot:init(data)
    super.init(self, data.center_x, data.center_y, data.width, data.height)

	self.name = data.properties["name"]
	self.flag_inc = data.properties["inc_flag"]

    self:setOrigin(0.5, 0.5)
    self:setSprite("world/events/bean_spot")

    Game.world.timer:after(1/30, function ()
        self.layer = 0.2 -- I don't know why, but the layer gets reset back to 0.4 somewhere after the init, so setting it to 0.2 is done a frame later
    end)
end

function BeanSpot:getDebugInfo()
    local info = super.getDebugInfo(self)
    table.insert(info, "Bean Type: " .. self.name .. " (" .. self.flag_inc .. ")")
    return info
end

function BeanSpot:onInteract(chara, dir)
	Game.world:startCutscene("_main.bean_spot", self)
    return true
end

return BeanSpot