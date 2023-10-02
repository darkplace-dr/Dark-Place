local Werewire, super = Class(EnemyBattler, "werewire")

function Werewire:init(id)
    super:init(self)

    -- Enemy name
    self.name = "Werewire"
    -- Sets the actor, which handles the enemy's sprites
    self:setActor("werewire")

    self.enemy_id = id or 1

    -- Enemy health
    self.max_health = 240
    self.health = 240
    -- Enemy attack (determines bullet damage)
    self.attack = 5
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = 79

    self:setTired(true)

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 20

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "werewire/attack"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "..."
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "Controlled by the Queen's wire, it's sleepwalking through a nightmare!"

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* Werewire crackles incomprehensibly.",
        "* Werewire shuffles menacingly.",
        "* Werewire dusts sparks off its shoulders.",
        "* The atmosphere is electric.",
        "* Smells like ozone."
    }
    -- Text displayed at the bottom of the screen when the enemy is at full mercy
    self.spareable_text = "* Werewire's wire is loose!"

    self:registerShortAct("JiggleJiggle")

    self:registerAct("ThrowWire", "", {"susie"})
end

function Werewire:spare(pacify)
    self:defeat(pacify and "PACIFIED" or "SPARED", false)

    local anim = WerewireSpareAnim(self.width/2, self.height, function() self:remove() end)
    anim:setScale(0.5, 0.5)
    self.sprite.visible = false
    self.overlay_sprite.visible = false
    self:addChild(anim)
end

function Werewire:onActStart(battler, name)
    if name == "JiggleJiggle" then
        battler:setActSprite("acts/werewire/wiggle/kris", -2, -7, 4/30, true)
    else
        super:onActStart(self, battler, name)
    end
end

function Werewire:onAct(battler, name)
    if name == "JiggleJiggle" then
        self:addMercy(50)
        return "* You jiggled your body. The wire loosened in turn!"

    elseif name == "ThrowWire" then
        Game.battle:startActCutscene("werewire/throw_wire")
        return

    elseif name == "Standard" then
        if battler.chara.id == "susie" then
            self:addMercy(25)
            return "* Susie yanked on the wire! It loosened a little bit."

        elseif battler.chara.id == "ralsei" then
            self:addMercy(25)
            return "* Ralsei sang a snake-charming song to the wire! It loosened a little bit."

        elseif battler.chara.id == "noelle" then
            self:addMercy(50)
            return "* Noelle pulled out the plug like a fairy light!"

        end

    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super:onAct(self, battler, name)
end

function Werewire:isXActionShort(battler)
    return true
end

function Werewire:onShortAct(battler, name)
    if name == "JiggleJiggle" then
        self:addMercy(50)
        return "* You jiggled your body!"

    elseif name == "Standard" then
        if battler.chara.id == "susie" then
            self:addMercy(25)
            return "* Susie yanked the wire!"

        elseif battler.chara.id == "ralsei" then
            self:addMercy(25)
            return "* Ralsei charmed the wire!"

        elseif battler.chara.id == "noelle" then
            self:addMercy(50)
            return "* Noelle pulled on the plug!"

        end

    end

    return super:onShortAct(self, battler, name)
end

function Werewire:getNextWaves()
    if self.wave_override then
        return super:getNextWaves(self)
    end

    if #Game.battle:getActiveEnemies() > 1 then
        return {"werewire/attack"}
    else
        return {"werewire/hang"}
    end
end

function Werewire:spawnSpeechBubble(...)
    local x, y = self.sprite:getRelativePos(0, self.sprite.height/2, Game.battle)
    if self.dialogue_offset then
        x, y = x + self.dialogue_offset[1], y + self.dialogue_offset[2]
    end
    local textbox = WerewireTextbox(x, y)
    Game.battle:addChild(textbox)
    return textbox
end

return Werewire