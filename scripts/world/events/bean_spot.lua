local BeanSpot, super = Class(Event, "beanspot")

function BeanSpot:init(data)
    super.init(self, data.center_x, data.center_y, data.width, data.height)
	
	self.name = data.properties["name"]
	self.flag_inc = data.properties["inc_flag"]

    self:setOrigin(0.5, 0.5)
    self:setSprite("world/events/bean_spot")
end

function BeanSpot:onInteract(chara, dir)
	Game.world:startCutscene("_main.bean_spot", self)
end

return BeanSpot