local Sousborg, super = Class(LightEncounter)

function Sousborg:init()
    super:init(self)

    self.text = "* Sousborg is ready to put your\nculinary skills to the test!"

    if not Game:getFlag("steamworks_kills") then
        Game:setFlag("steamworks_kills", 0)
    end

    if Game:getFlag("steamworks_kills") >= 13 then
        self.music = "undertale_yellow/genobattle_yellow"
    else
        self.music = "undertale_yellow/heatwave_approaching"
    end

    self:addEnemy("sousborg", 329, 244)

    self.background_image = "ui/lightbattle/backgrounds/battle_steamworks"

    self.can_flee = false

end

function Sousborg:beforeStateChange(old, new)
    local sousborg = Game.battle:getEnemyBattler("sousborg")
    if old == "ENEMYSELECT" and new == "MENUSELECT" and sousborg.sparing_stage > 0 and sousborg.sparing_stage < 4 then
        --[[if sousborg.sparing_stage == 1 then
            local dialogue = {"Do you have what\nit takes to be\namong ze greats?", "Tell me, how does\none cook zis\nbrittle spheroid?"}
            local bubble = SpeechBubble(dialogue, 413, 123, {style = "uty_2", right=true})
            Game.battle:addChild(bubble)
            bubble:setCallback(function()
                bubble:remove()
            end)
        elseif sousborg.sparing_stage == 2 then
            local dialogue = {"What ez ze next\nstep, hm?", "Only master chefs\nknow ze secret\nto perfect-e-on!"}
            local bubble = SpeechBubble(dialogue, 413, 123, {style = "uty_2", right=true})
            Game.battle:addChild(bubble)
            bubble:setCallback(function()
                bubble:remove()
            end)
        elseif sousborg.sparing_stage == 3 then
            local dialogue = {"Almost zere!", "Ze final step\nez...?"}
            local bubble = SpeechBubble(dialogue, 413, 123, {style = "uty_2", right=true})
            Game.battle:addChild(bubble)
            bubble:setCallback(function()
                bubble:remove()
            end)
        end]] -- need to figure out how to lock and unlock movement in the menu before adding that
    end
end

return Sousborg