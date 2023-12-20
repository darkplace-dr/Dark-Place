-- Based on the unlockable "Prism Sword"
local ColorSlash, super = Class(Wave)

function ColorSlash:init()
    super.init(self)
    self.rgb = {0,0,0}
    
end

function ColorSlash:onStart()
    self.time = -1
    self.user = self:getAttackers()[1]
    self.order = {}
    for i = 1, self.user.difficulty+3 do self.order[i] = Utils.pick{"Blue", "Orange"} end
    local currtell = 1
    local currslash = 1

    Assets.playSound("noise")
    Game.fader:fadeIn(nil, {speed = 0.3, color = {1, 1, 1}, alpha = 1})

    self.timer:after((0.5 - 10/30), function ()
        self.timer:every(10/30, function ()
        if currtell <= #self.order then
            if currtell == #self.order then
            Assets.playSound("halberd_flash", 1, 0.8)
            else
            Assets.playSound("halberd_flash")
            end
            self.user.sprite:set("drawsword/"..self.order[currtell]:lower())
            currtell = currtell + 1
        elseif currtell == #self.order + 1 then
            self.user.sprite:set("drawsword/finish", function ()
                self.user.sprite:set("drawsword/sheath")
            end)
            currtell = currtell + 1
        end
        end)
    
    self.timer:after((1 + (10/30 * (#self.order-1))), function ()
        self.timer:every(10/30, function ()
            if currslash <= #self.order then

                local bullet = self:spawnBullet("zero/colorslash", 330, 170, math.rad(180), 0, self.order[currslash])
                self.rgb[1] = bullet.color[1]
                self.rgb[2] = bullet.color[2]
                self.rgb[3] = bullet.color[3]
                currslash = currslash + 1
            else
                self.time = 1
            end
        end)
    end)



    end)
    
end


function ColorSlash:onEnd()
    self.user.sprite:set("idle")
    super:onEnd()
end

function ColorSlash:update()
    -- Code here gets called every frame
    Game.battle.arena:setBackgroundColor(self.rgb)
    self.rgb[1] = Utils.approach(self.rgb[1], 0, DTMULT/8)
    self.rgb[2] = Utils.approach(self.rgb[2], 0, DTMULT/8)
    self.rgb[3] = Utils.approach(self.rgb[3], 0, DTMULT/8)

    super.update(self)
end

return ColorSlash