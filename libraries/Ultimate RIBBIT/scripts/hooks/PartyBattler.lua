local PartyBattler, super = Class("PartyBattler", true)

function PartyBattler:init(chara, x, y)
    super.init(self, chara, x, y)

    self.death_siner = 0.1
end

function PartyBattler:update()

    if self.is_down and self.chara.ribbit then

        if self.death_flash then
            self.death_flash.scale_x = self.death_flash.scale_x + 0.03 * DTMULT
            self.death_flash.scale_y = self.death_flash.scale_y + 0.03 * DTMULT
        end

        self.death_siner = self.death_siner + DTMULT / 1.5

        local siner2 = math.cos(self.death_siner * .09) * 4

        self.overlay_sprite:setOriginExact(0, siner2)

    end

    super.update(self)
end

function PartyBattler:down()
   
    local x, y = self.chara.actor:getOffset("battle/defeat")

    if self.chara.ribbit then
        Assets.stopAndPlaySound("dead")

        self.death_flash = Sprite(self.actor:getSpritePath() .. "/battle/defeat", x, y)
        --self.death_flash:setOrigin(0.5, 0.5)
        self:addChild(self.death_flash)
        self.death_flash:fadeOutAndRemove(0.25)
    end

    super.down(self)
end

function PartyBattler:revive()
    super.revive(self)
    self.overlay_sprite:setOrigin(0, 0)
end

return PartyBattler