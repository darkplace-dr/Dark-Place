local elevatorInput, super = Class(Interactable)

function elevatorInput:init(data)
	super:init(self, data)

	properties = data.properties or {}

	self.transition = nil

	self.door_l = Sprite("world/elevator_dt_frontdoor_l", 270, 352)
	self.door_l:setScale(2)
	self.door_l:setLayer(0.3)
	Game.world:addChild(self.door_l)

	self.door_r = Sprite("world/elevator_dt_frontdoor_r", 360, 352)
	self.door_r:setScale(2)
	self.door_r:setLayer(0.3)
	Game.world:addChild(self.door_r)

	self.door_between = Rectangle(270+self.door_l.width*2, 360, 74, 4)
	self.door_between:setLayer(0.3)
	self.door_between:setColor(0, 0, 0)
	Game.world:addChild(self.door_between)

	self.maps = Utils.parsePropertyList("map", properties)
	self.maps_name = {}
	for i=1, #self.maps do
		if Registry.getMapData(self.maps[i]).properties and Registry.getMapData(self.maps[i]).properties.name then
			self.maps_name[i] =  Registry.getMapData(self.maps[i]).properties.name
		else
			self.maps_name[i] =  self.maps[i]
		end
	end
end

function elevatorInput:update()
	if not self.transition then
		for i, t in ipairs(Game.stage:getObjects(Transition)) do
			if t.id == "elevatorTransition" then
				self.transition = t
				break
			end
		end
	end
end

function elevatorInput:onInteract()
	cutscene = self.world:startCutscene(function(cutscene)
		if #self.maps>0 then
			cutscene:text("* Where will you ride the elevator to?")
			cutscene:choicer(self.maps_name)
			self.transition.target["map"] = self.maps[cutscene.choice]
		else
			cutscene:text("* It seems to be out of order.")
		end
    end)
end

return elevatorInput