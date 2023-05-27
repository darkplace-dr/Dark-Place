local CloudsBG, super = Class(Object)

function CloudsBG:init()
    super.init(self, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)

    self.parallax_x = 0
    self.parallax_y = 0

    local backdrop = Sprite("objects/cloudworld/backdrop", 0, 0)
    backdrop:setScale(2)
    self:addChild(backdrop)

    local clouds = Sprite("objects/cloudworld/cloud_big", 0, 0)
    clouds:setWrap(true)
    clouds.physics.speed_x = 0.2
    clouds:setScale(2)
    clouds.physics.speed_y = 0.1
    clouds:addFX(ShaderFX(Mod.shaders["wave"], {
        ["wave_sine"] = function() return Kristal.getTime() * 100 end,
        ["wave_mag"] = 2,
        ["wave_height"] = 6,
        ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT}
    }))
    self:addChild(clouds)

    clouds.layer = 10


    --[[
    local clouds = Sprite("objects/cloudworld/clouds", 0, 0)
    clouds:setScale(2)
    clouds.visible = true
    self:addChild(clouds)
    clouds.layer = 10
    clouds:addFX(ShaderFX(Mod.shaders["wave"], {
        ["wave_sine"] = function() return Kristal.getTime() * 100 end,
        ["wave_mag"] = 1,
        ["wave_height"] = 7,
        ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT}
    }))

    clouds:setWrap(true)
    clouds.physics.speed_x = 0.1
    clouds.physics.speed_y = 0.05
    ]]

--[[]]
    --Game.world.timer:every(1, function ()
        
            
            --[[]
            


            for i= 1,20 do
                

                local clouds = Sprite("objects/cloudworld/cloud_b", love.math.random(-50,900), love.math.random(-50,900))
                clouds:setScale(2)
                clouds.visible = true
                self:addChild(clouds)
                clouds.layer = 10
                clouds:addFX(ShaderFX(Mod.shaders["wave"], {
                    ["wave_sine"] = function() return Kristal.getTime() * 100 end,
                    ["wave_mag"] = 4,
                    ["wave_height"] = 16,
                    ["texsize"] = {SCREEN_WIDTH, SCREEN_HEIGHT}
                }))

            
                clouds:setWrap(false)
                --local rannum = love.math.random(1,2)

                --if rannum == 1 then
                    clouds.physics.speed_x = love.math.random(0.2,0.3)
                    clouds.physics.speed_y = 0.3
                --elseif rannum == 2 then
                --    clouds.physics.speed_x = love.math.random(-0.2,-0.6)
                --    clouds.physics.speed_y = love.math.random(-0.1,-0.3)
                --end


            end



            --]]
    


    --end)



end

return CloudsBG