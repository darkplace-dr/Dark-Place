local SusieNoyno, super = Class(Encounter)

function SusieNoyno:init()
    super.init(self)

    self.text = "* Susie and Noyno block the way!"

    self.music = "vs_susie_and_noyno"

    self.background = false

    self.sus = self:addEnemy("robo_susie", 530, 154)
    self.noy = self:addEnemy("noyno", 540, 270)
end

function SusieNoyno:onReturnToWorld(events)
    -- check whether the enemies were killed
    if Game.battle.killed then
        -- run this code for each event in the table
        for _,event in ipairs(events) do
            for _,event in ipairs(event:getGroupedEnemies(true)) do
                -- set a 'dont_load' flag to true for the event,
                -- which is a special flag that will prevent the event from loading
                event:setFlag("dont_load", true)
            end
        end
    end
end

function SusieNoyno:onStateChange(old, new)
    if new == "INTRO" then
        self.sus:setAnimation("battle/intro")
        self.sus.sprite.flip_x = true
        self.noy:setAnimation("battle/intro")
        self.noy.sprite.flip_x = true
    elseif new == "ACTIONSELECT" then
        self.sus:setAnimation("battle/idle")
        self.noy:setAnimation("battle/idle")
    elseif new == "VICTORY" then
        self.sus:setAnimation("battle/victory")
        self.noy:setAnimation("battle/victory")
    end
end

return SusieNoyno