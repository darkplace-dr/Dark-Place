local ShadowMen, super = Class(Encounter)

function ShadowMen:init()
    super.init(self)

    self.text = "* The shawdowmen blends into the battle!"

    self.music = "battle"
    self.background = true

    self.shadows = {
        self:addEnemy("shadowmen"),
        self:addEnemy("shadowmen")
    }
end

function ShadowMen:onStateChange(old, new)
    if old == "INTRO" then
        Game.battle.music:setPitch(0.7)
    end
end

function ShadowMen:onReturnToWorld(events)
    Game:setFlag("shadowmen_violence", Game.battle.used_violence)
    if self.shadows[1].done_state == "FROZEN" and self.shadows[2].done_state == "FROZEN" then
        Game:setFlag("shadowmen_special_end", "FROZEN")
        for i,event in ipairs(events) do
            local statue = FrozenEnemy(event.actor, event.x, event.y, {encounter = self})
            statue.sprite.frozen = true
            statue.sprite.freeze_progress = 1
            statue.layer = event.layer
            Game.world:addChild(statue)
            event:remove()
            event.sprite:remove()
        end
    elseif self.shadows[1].done_state == "KILLED" and self.shadows[2].done_state == "KILLED" then
        Game:setFlag("shadowmen_special_end", "KILLED")
        for i,event in ipairs(events) do
            event:remove()
            event.sprite:remove()
        end
    end
end

return ShadowMen