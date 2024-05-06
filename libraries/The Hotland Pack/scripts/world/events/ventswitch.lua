local VentSwitch, super = Class(Event)

function VentSwitch:init(x,y)
    super.init(self,x,y)

    self:setSprite("world/events/ventswitch")

end

function VentSwitch:onEnter(player)
    if player == Game.world.player and (not player.jumping) then
        self.sprite:setFrame(2)
        Assets.playSound("noise")

        local vents = Game.world.map:getEvents("ventlauncher")
        for i, vent in ipairs(vents) do
            if vent.switch_state > 0 then
                vent.off = not vent.off
                vent.visible = not vent.visible
                vent.solid = not vent.solid
            end
        end

    end
end

function VentSwitch:onCollide(player)
    if player == Game.world.player and player.jumping and self.sprite.frame ~= 2 then
        Game.world.timer:after(1/30, function ()
            if player.jump_progress == 3 then
                self.sprite:setFrame(2)
                Assets.playSound("noise")
        
                local vents = Game.world.map:getEvents("ventlauncher")
                for i, vent in ipairs(vents) do
                    if vent.switch_state > 0 then
                        vent.off = not vent.off
                        vent.visible = not vent.visible
                        vent.solid = not vent.solid
                    end
                end
                local legacy = Kristal.getLibConfig("hotland-pack", "legacy_vents")
                if not legacy then
                    player.jump_progress = 0
                    Game.world.timer:after(5/30, function ()
                        player.sprite:resetSprite()
                        player.jumping = false
                    end)
                end

            end
        end)
    end
end

function VentSwitch:onExit(player)
    if player == Game.world.player then
        self.sprite:setFrame(1)
    end
end

return VentSwitch