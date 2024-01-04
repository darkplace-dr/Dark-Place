local DarkShadowController, super = Class(Event, "darkshadow")

function DarkShadowController:init(data)
    super.init(self)

    data = data or {}
    local properties = data.properties or {}
	
	self.alpha = properties["alpha"]
	self.dontusehighlight = properties["dontusehighlight"]
	self.scale = properties["scale"]
	self.highlight = properties["highlight"]
end

function DarkShadowController:update()
    super.update(self)

    if not self.stage then return end

    for _,chara in ipairs(self.stage:getObjects(Character)) do
        if not chara.no_shadow and not chara:getFX("shadow") then
            chara:addFX(ShadowFX(self.alpha, self.dontusehighlight, self.scale, self.highlight), "shadow")
        end
    end
end

return DarkShadowController