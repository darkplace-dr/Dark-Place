local ChronosSoul, super = Class(Soul)

function ChronosSoul:init(x, y)
    super.init(self, x, y)
    
    -- Default color is cyan {0,1,1}, but feel free to make it whatever you want.
    --self.color = {0,1,1}
    -- Here's orange, if you want it.
    -- self.color = {1,(148/255),0}

    --[[ None of these are relevant in Dark Place
    -- In Deltatraveler, this soul moves at half speed (2). Remove this line or set speed to 4 if you don't want that.
    self.speed = 2
    -- Disables focus. Why would you want to move even slower?
    self.allow_focus = false
    --]]

    self.outline = Sprite("player/heart_slow")
    self.outline:setOrigin(0.5, 0.5)
    self.outline.alpha = 0
    self:addChild(self.outline)

    self.afterimage_delay = 5


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
    -- Soul VFX
    if not self.transitioning and Input.down("a") and Game:getTension() > 0 then
    self.outline.alpha = Utils.approach(self.outline.alpha, 1, DTMULT / 4)
    if self.afterimage_delay == 5 then
        local afterimage = AfterImage(self.outline, 0.5)
        self:addChild(afterimage)
        self.afterimage_delay = 0
        Game:removeTension(0.5)
    else
        self.afterimage_delay = self.afterimage_delay + 1
    end
    else
    self.outline.alpha = Utils.approach(self.outline.alpha, 0, DTMULT / 4)
    end
    outlinefx:setAlpha(self.outline.alpha - 0.2)
    if Input.pressed("a") and Game:getTension() <= 0 then
        Assets.playSound("ui_cant_select", 2)
    end
end

return ChronosSoul