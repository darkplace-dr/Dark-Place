local DojoEncounter, super = Class(Encounter, "DojoEncounter")


--makes a spotlight for a particular battler, using it's actor.spotlight data.
--returns the new spotlight and stores it in battler.spotlight
function DojoEncounter.makeSpotlight(battler, isBattlerChild)
    local spotlight
    local x,y
    if(isBattlerChild) then
        x,y = battler:getOriginExact()
    else
        x,y = battler:getPosition()
    end
    local rescale = 1/(isBattlerChild and (battler:getScale()) or 1)

    if(battler.actor.spotlight) then
        spotlight = Spotlight(x, y, battler.actor.spotlight)
    else
        --geusstimated from deltarune let's plays
        spotlight = Spotlight(x, y, {
            width = 80*rescale,
            beam_height = 200*rescale,
            base_color = {0.5,0.5,0.5,1},
            top_color = {1,1,1,0.0},
            bottom_color = {1,1,1,0.25}
        })
    end
    spotlight:setLayer(battler:getLayer() - 0.1)
    --if we parent this to the battlers, the lights might go on top of the battlers
    if(isBattlerChild) then
        battler:addChild(spotlight)
    else
        Game.battle:addChild(spotlight)
    end
    battler.spotlight = spotlight
    return spotlight
end

--deltarune dojo spawns lights AFTER the fun gang do their little dance
function DojoEncounter:onStateChange(old, new)
    super.onStateChange(self, old, new)
    if(old == "INTRO" and not (old == new)) then
        for _, enemy in ipairs(Game.battle.enemies) do
            if enemy.spotlight then
                --but it's ok here, since the enemy battler's spotlight needs to move with it, and usually only 1 enemy gets one
                DojoEncounter.makeSpotlight(enemy, true)
            end
        end

        for _, battler in ipairs(Game.battle.party) do
            DojoEncounter.makeSpotlight(battler)
        end
        self.spotlights_ready = true
    end
end

--why is it ever so slightly different
function DojoEncounter:getPartyPosition(index)
    local x, y = 0, 0
    if #Game.battle.party == 1 then
        x = 80
        y = 140
    elseif #Game.battle.party == 2 then
        x = 80
        y = 100 + (80 * (index - 1))
    elseif #Game.battle.party == 3 then
        x = 80
        y = 50 + (80 * (index - 1))
    end

    local battler = Game.battle.party[index]
    local ox, oy = battler.chara:getBattleOffset()

    if index == 1 then
        x = x + 12
    elseif index == 3 then
        x = x - 12
    end
    x = x + (battler.actor:getWidth()/2 + ox) * 2 
    y = y + (battler.actor:getHeight()  + oy) * 2
    return x, y
end

return DojoEncounter