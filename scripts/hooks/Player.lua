---@class Player
local Player, super = Class("Player", true)

function Player:update()
    -- Holding run with the Pizza Toque equipped (or if the file name is "PEPPINO") will cause a gradual increase in speed.
    toque_equipped = false
    for _,party in ipairs(Game.party) do
        if party:checkArmor("pizza_toque") then toque_equipped = true end
    end
    local player_name = Game.save_name:upper()
    if Game.world.map.id ~= "everhall" and Game.world.map.id ~= "everhall_entry" and toque_equipped == true or player_name == "PEPPINO" then
        if self.run_timer > 60 then
            self.walk_speed = self.walk_speed + DT
        elseif self.walk_speed > 4 then
            self.walk_speed = 4
        end
    end

    super.update(self)
	
	if Kristal.getLibConfig("pickup_lib", "disable_hold_run") and self.holding then
		running = false
		self.run_timer = 0
	end

    -- Hitting a wall at a speed of 10 or higher will do a small collision effect
    if toque_equipped == true or player_name == "PEPPINO" then
        if self.last_collided_x or self.last_collided_y then
            if self.walk_speed >= 10 then
                Game.world.player:shake(4, 0)
                Assets.playSound("wing")
            end
        end
    end

    --haha backroom go brrrrrrr
    if self.walk_speed >= 60 then
	Game.world:mapTransition("backrooms/entrance")
    end
        

    --[[
    Old code that will either explode the player or do 20 damage to the party depending on their speed when hitting a wall.
    if toque_equipped == true or player_name == "PEPPINO" then
        if self.last_collided_x or self.last_collided_y then
                if self.walk_speed >= 16 then
                    self:explode()
                    Game.world.music:stop()

                    Game.stage.timer:after(2, function()
                        local rect = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                        rect:setColor(0, 0, 0)
                        rect:setLayer(100000)
                        rect.alpha = 0
                        Game.stage:addChild(rect)

                        Game.stage.timer:tween(2, rect, {alpha = 1}, "linear", function()
                            rect:remove()
                            Game:gameOver(0, 0)
                            Game.gameover.soul:remove()
                            Game.gameover.soul = nil
                            Game.gameover.screenshot = nil
                            Game.gameover.timer = 150
                            Game.gameover.current_stage = 4
                        end)
                    end)
                elseif self.walk_speed >= 10 then
                    Game.world:hurtParty(20)
                end
            end
        end)
    end
    --]]

end

function Player:interact()
	if self.holding then return false end
	
    return super:interact(self)
end

return Player
