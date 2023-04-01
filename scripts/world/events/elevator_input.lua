local elevator_input, super = Class(Interactable)

function elevator_input:init(data)
	super:init(self, data)

	local properties = data.properties or {}

	-- ["transition"] would be set to the transition object's ID
	self.transition = Game.world.map:getEvent(properties.transition)

	self.door_l = Sprite("world/elevator_dt_frontdoor_l", 270, 352)
	self.door_l:setScale(2)
	self.door_l:setLayer(0.3)
	Game.world:addChild(self.door_l)

	self.door_r = Sprite("world/elevator_dt_frontdoor_r", 360, 352)
	self.door_r:setScale(2)
	self.door_r:setLayer(0.3)
	Game.world:addChild(self.door_r)

	self.door_between = Rectangle(270 + self.door_l.width*2, 360, 74, 4)
	self.door_between:setLayer(0.3)
	self.door_between:setColor(0, 0, 0)
	Game.world:addChild(self.door_between)

	self.maps = Utils.parsePropertyList("map", properties)
	self.maps_name = {}
	for i=1, #self.maps do
		self.maps_name[i] = self.maps[i]
		if Registry.getMapData(self.maps[i]).properties and Registry.getMapData(self.maps[i]).properties.name then
			self.maps_name[i] = Registry.getMapData(self.maps[i]).properties.name
		end
	end
end

function elevator_input:onInteract()
	Game.world:startCutscene(function(cutscene)
		if #self.maps <= 0 then
			cutscene:text("* It seems to be out of order.")
			return
		end

		cutscene:text("* Where will you ride the elevator to?")
		local map = cutscene:choicer(self.maps_name)

		-- TODO: VFX

		self.transition.target["map"] = self.maps[map]
    end)
end

return elevator_input