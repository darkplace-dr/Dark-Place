
--[[
This soul is part of an incomplete fight. It's subject to change at any time.
You're free to use this soul if you want, but I would advise not doing so until the fight it's meant for is finished.
This comment will be removed once that happens.
- Agent 7
--]]

local ChronosSoul, super = Class(Soul)

function ChronosSoul:init(x, y)
    super.init(self, x, y)


    self.outline = Sprite("player/heart_slow")
    self.outline:setOrigin(0.5, 0.5)
    self.outline.alpha = 0
    self:addChild(self.outline)

    self.afterimage_delay = 5
    self.drain_rate = 10        -- Number of frames to wait between each 
    self.drain_timer = 0


    self.leader = Game.battle.party[1]
    outlinefx = BattleOutlineFX()
    outlinefx:setAlpha(0)

    if self.leader:getFX("outlinefx") then
        self.leader:removeFX("outlinefx")
    end
    if Game.stage:getFX("vhs") then
        Game.stage:removeFX("vhs")
    end

    self.leader:addFX(outlinefx, "outlinefx")
    vhsfx = Game.stage:addFX(VHSFilter(), "vhs")
    vhsfx.timescale = 2 -- I dunno if this even works.

end

function ChronosSoul:update()
    super.update(self)
    if self.transitioning then
        Game.stage.timescale = 1
    end
    -- Cut timescale in half when holding A and not out of TP
    if not self.transitioning and Input.down("a") and Game:getTension() > 0 then
        Game.stage.timescale = Utils.approach(Game.stage.timescale, 0.5, DTMULT / 4)
        Game.battle.music.pitch = Utils.approach(Game.battle.music.pitch, 0.5, DTMULT / 4)
        Game.battle.encounter.timebulletmult = Utils.approach(Game.battle.encounter.timebulletmult, 2, DTMULT / 4)
        vhsfx.active = true
    else
        Game.stage.timescale = Utils.approach(Game.stage.timescale, 1, DTMULT / 4)
        Game.battle.music.pitch = Utils.approach(Game.battle.music.pitch, 1, DTMULT / 4)
        Game.battle.encounter.timebulletmult = Utils.approach(Game.battle.encounter.timebulletmult, 1, DTMULT / 4)
        vhsfx.active = false
    end

    -- Remove 1 TP for every drain_rate frames of slowdown active
    if not self.transitioning and Input.down("a") and Game:getTension() > 0 then
        if self.drain_timer == self.drain_rate then
            Game:removeTension(1)
        else
            self.drain_timer = self.drain_timer + 1
        end
    end

    -- Error sound if trying to use slowdown when out of TP
    if Input.pressed("a") and Game:getTension() <= 0 then
        Assets.playSound("ui_cant_select", 2)
    end

    -- Soul VFX
    if not self.transitioning and Input.down("a") and Game:getTension() > 0 then
    self.outline.alpha = Utils.approach(self.outline.alpha, 1, DTMULT / 4)
    if self.afterimage_delay == 5 then
        local afterimage = AfterImage(self.outline, 0.5)
        self:addChild(afterimage)
        self.afterimage_delay = 0
    else
        self.afterimage_delay = self.afterimage_delay + 1
    end
    else
    self.outline.alpha = Utils.approach(self.outline.alpha, 0, DTMULT / 4)
    end
    outlinefx:setAlpha(self.outline.alpha - 0.2)
end

return ChronosSoul