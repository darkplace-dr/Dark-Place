local id = "shadowmen"
local actor, super = Class(Actor, id)

function actor:init()
    super.init(self)
    self.name = Kristal.getLibConfig("shadowmen", "name")

    -- Width and height for this actor, used to determine its center
    self.width = 54
    self.height = 56

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
	local offset = self.height * .75
	local xoffset = self.width * .25
	
    self.hitbox = {xoffset, offset, self.width - (xoffset * 2), self.height - offset}
	
    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "npcs/" .. id
    self.default = "idle"
	
    self.animations = {
        ["idle"] = {id, 0.15, true},
        ["hurt"] = {"hurt", 0.5, true},
		["play"] = {"play", 0.075, true},
		["shoots"] = {"shoots", 0.5, true},
		["prepare"] = {"prepare", 0.2, true},
		["pullsocks"] = {"pullsocks", 0.2, true},
		["scream"] = {"scream", 0.2, true},
        ["spared"] = {"spared", 0, false},
	}	
	
    self.offsets = {
        ["play"] = {-18, 0},
        ["prepare"] = {0, -8},
		["scream"] = {9, -7},
		["hurt"] = {9, -7},
	}
	
	self.timer = 0
end

function actor:createSprite()
	return ShadowmenActor(self)
end

function actor:preSetAnimation(sprite, anim, ...)
	if anim == 'shoots' then
		sprite.gun.visible = true
	elseif anim == 'scream' then
		Assets.playSound("shadowmen_scream")
	else
		if sprite.gun then
			sprite.gun.visible = false
		end
	end
end

return actor