local wii_preview = {}

-- What speed should the frame animation be at? (Only matters if frame animation for the channel icon)
wii_preview.icon_speed = 1/5
wii_preview.virtual = true

function wii_preview:iconInit(mod_id, is_maintenance)
    -- Code here gets called when the channels are loaded
	-- Don't forget to return your data table; this will be used for draw and update!
	local mod_data = Kristal.Mods.getMod(mod_id)
	local data = {}
    data.particles = {}
    data.particle_timer = 0
    data.particle_tex = love.graphics.newImage(mod_data.path .. "/preview/star.png")
    data.overlay = love.graphics.newImage(mod_data.path .. "/assets/sprites/wii_over.png")
	return data
end

function wii_preview:iconUpdate(data, timer, is_maintenance)
    -- Code here gets called every frame, before any draws
    -- (0,0) is at the top left of the channel, so the bottom right is (125, 96)
	-- Don't forget to return your data table!

    local to_remove = {}
    for _,particle in ipairs(data.particles) do
        particle.radius = particle.radius - DT * 2
        particle.y = particle.y - particle.speed * (DTMULT)

        if particle.radius <= 0 then
            table.insert(to_remove, particle)
        end
    end

    for _,particle in ipairs(to_remove) do
        Utils.removeFromTable(data.particles, particle)
    end

    data.particle_timer = data.particle_timer + DT
    if data.particle_timer >= 1.2 then
        data.particle_timer = 0
        local radius = Utils.random(12)
        table.insert(data.particles, {
            radius = radius, max_radius = radius,
            x = Utils.random(125), y = 96 + radius,
            speed = Utils.random(0.5, 1)
        })
    end
	return data
end

function wii_preview:iconDraw(data, timer, is_maintenance)
    -- Code here gets drawn to the icon every frame
    -- (0,0) is at the top left of the channel, so the bottom right is (125, 96)
	-- You don't need to return your data table this time!
	
	if not is_maintenance then
		for _,particle in ipairs(data.particles) do
			local alpha = (particle.radius / particle.max_radius)

			love.graphics.setColor(1, 1, 1, alpha)
			love.graphics.draw(data.particle_tex, particle.x, particle.y, particle.radius/2, 0.5, 0.5, 5, 5)
		end
		love.graphics.setColor(1, 1, 1, 1)
		love.graphics.draw(data.overlay, 69, 54, 0, 1, 1, 40.5, 34.5)
	end
end

return wii_preview