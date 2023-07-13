function Mod:initBulborb()
    self.enabled = 0
    self.vanishing = false
    self.appearing = false
    self.reaction = LiveBulborbReaction()
    self.reaction:setScale(Game:getFlag("bulborb_scale"))
    if Game:getFlag("bulborb_position") == 1 then
        self.reaction:setOrigin(0, 0)
        self.reaction.x = 0
        self.reaction.y = 0
    elseif Game:getFlag("bulborb_position") == 2 then
        self.reaction:setOrigin(1, 0)
        self.reaction.x = SCREEN_WIDTH
        self.reaction.y = 0
    elseif Game:getFlag("bulborb_position") == 3 then
        self.reaction:setOrigin(0, 1)
        self.reaction.x = 0
        self.reaction.y = SCREEN_HEIGHT
    elseif Game:getFlag("bulborb_position") == 4 then
        self.reaction:setOrigin(1, 1)
        self.reaction.x = SCREEN_WIDTH
        self.reaction.y = SCREEN_HEIGHT
    end
    self.reaction.layer = 1000
end

function Mod:updateBulborb()
    if Input.pressed("b") and self.enabled == 0 and self.appearing == false then
        Assets.stopSound("vineboom_reversed")
        Assets.stopAndPlaySound("vineboom")
        Game.stage:addChild(self.reaction)
        self.reaction:flash()
        Game.world:shakeCamera()
        self.appearing = true
        Game.world.timer:after(0.5, function()
            self.enabled = 1
            self.appearing = false
        end)
        if Game.state == "BATTLE" then
            Game.battle.timer:after(0.5, function()
                self.enabled = 1
                self.appearing = false
            end)
        end
    elseif Input.pressed("b") and self.enabled == 1 and self.vanishing == false then
        Assets.stopSound("vineboom")
        Assets.stopAndPlaySound("vineboom_reversed")
        self.vanishing = true
        self.reaction:fadeOutAndRemove(0.5)
    end
    if self.reaction.alpha == 0 then
        self.enabled = 0
        self.vanishing = false
        self.reaction.alpha = 1
    end
end