function Mod:initBulborb()
    self.bulborb_reaction = Sprite("ui/live_bulborb_reaction")
    self:resetBulborb()
    -- "", APPEARING, IDLE, VANISHING
    self.bulborb_state = ""
end

function Mod:resetBulborb()
    self.bulborb_reaction:setScale(Game:getFlag("bulborb_scale", 0.3))
    self.bulborb_reaction.alpha = 1
    self:repositionBulborb()
end
function Mod:repositionBulborb()
    local pos = Game:getFlag("bulborb_position", 2)
    if pos == 1 then
        self.bulborb_reaction:setOrigin(0, 0)
        self.bulborb_reaction.x = 0
        self.bulborb_reaction.y = 0
    elseif pos == 2 then
        self.bulborb_reaction:setOrigin(1, 0)
        self.bulborb_reaction.x = SCREEN_WIDTH
        self.bulborb_reaction.y = 0
    elseif pos == 3 then
        self.bulborb_reaction:setOrigin(0, 1)
        self.bulborb_reaction.x = 0
        self.bulborb_reaction.y = SCREEN_HEIGHT
    elseif pos == 4 then
        self.bulborb_reaction:setOrigin(1, 1)
        self.bulborb_reaction.x = SCREEN_WIDTH
        self.bulborb_reaction.y = SCREEN_HEIGHT
    elseif pos == 5 then
        self.bulborb_reaction:setOrigin(0.5, 0.5)
        self.bulborb_reaction.x = SCREEN_WIDTH/2
        self.bulborb_reaction.y = SCREEN_HEIGHT/2
    end
end

function Mod:updateBulborb()
    if not self.bulborb_reaction then return end

    -- Just wanna make sure the internet checkpoint thing that Char added
    -- doesn't get its mood ruined by a Live Bulborb Reaction
    local can_show = Game.world.map.id ~= "field"
    if not can_show then
        self.bulborb_reaction:remove()
    end

    if can_show and not TextInput.active and Input.pressed("b") then
        if self.bulborb_state == "" then
            self.bulborb_state = "APPEARING"

            self:resetBulborb()
            Game.stage:addChild(self.bulborb_reaction)

            Assets.stopSound("vineboom_reversed")
            Assets.stopAndPlaySound("vineboom")
            if Game.state == "OVERWORLD" then
                Game.world:shakeCamera(4)
            elseif Game.state == "BATTLE" then
                Game.battle:shakeCamera(4)
            end
            self.bulborb_reaction:flash()

            Game.world.timer:after(0.5, function()
                self.bulborb_state = "IDLE"
            end)
        elseif self.bulborb_state == "IDLE" then
            self.bulborb_state = "VANISHING"

            self.bulborb_reaction:fadeOutAndRemove(0.5)

            Assets.stopSound("vineboom")
            Assets.stopAndPlaySound("vineboom_reversed")
        end
    end

    if self.bulborb_reaction:isRemoved() then
        self.bulborb_state = ""
    end
end