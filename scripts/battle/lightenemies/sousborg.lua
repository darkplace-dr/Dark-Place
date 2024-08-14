local Sousborg, super = Class(LightEnemyBattler)

function Sousborg:init()
    super:init(self)

    self.name = "Sousborg"
    self:setActor("sousborgenemy")

    self.max_health = 180
    self.health = 180
    self.attack = 12
    self.defense = 12
    self.money = 30
    self.experience = 0

    self.dialogue_bubble = "uty_2"
    self.dialogue_offset = {-70, 10}

    self.waves = {
        "basic"
    }

    self.dialogue = {
        "If you can't\nstand ze heat...\ngood!",
        "Natural\ningredients!\nNever\nsubstitute!",
        "A bit of zis...\na bit of zat...",
        "C'est croquant,\nc'est fondant...",
        "Réjouis-toi!\nI am only going\nto bring you to a\nlight boil!",
        "Longue vie au\nroi, courte vie\nà l'humain!",
        "Your complexion...\nun poulet cru.\nSome food will\nhelp!"
    }

    self.low_health_dialogue = {
        "D../inner _:wiLl\nbe <r-Ready .>\nSoon.",
        "Sw/>.eet _or\nSAVory?"
    }

    self.check = "ATK 12 DEF 12\n* A recipe for disaster."

    self.text = {
        "* Looks like you're on the\nchopping block!",
        "* Sousborg is juggling cleavers.",
        "* Sousborg cooks you some\nspaghetti![wait:5] ...without water.",
        "* Smells like...[wait:5] food?[wait:5] Nice!",
        "* Sousborg preheats his next\nattack.",
        "* Sousborg stares down a frozen\nTV dinner with great malice."
    }

    self.spareable_text = "* Sousborg bows to your culinary\nmastery!"
    self.low_health_text = {
        "* Sousborg pours onion powder on\nhis wounds.",
        "* Sousborg is leaking oil.\nVegetable oil."
    }

    self.low_health = false
    self.sparing_stage = 1

    self:registerAct("Crack")
    self:registerAct("Criticize")

    --self:registerAct("Boil")
    --self:registerAct("Fry")
    --self:registerAct("Bake")

    --self:registerAct("Refrigerate")
    --self:registerAct("Pet")
    --self:registerAct("Season")

    --self.gauge_size = {250, 20}

    self.damage_offset = {0, 80}
end

function Sousborg:getDamageVoice()
    return "hurt_robot"
end

function Sousborg:onAct(battler, name)
    if name == "Crack" then
        if self.low_health == true then
            return "* You toss Sousborg's cooking\ninto the garbage."
        else
            self.dialogue_override = "Ah yes! Just a\nlight tap on ze\nedge!"
            self:addMercy(35)
            self.sparing_stage = 2
            self:removeAct("Crack")
            self:removeAct("Criticize")
            self:registerAct("Boil")
            self:registerAct("Fry")
            self:registerAct("Bake")
            return "* You tell Sousborg to take the\negg and crack it over a pan."
        end
    elseif name == "Criticize" then
        if self.low_health == true then
            return "* You wash Sousborg's oil off of\nyour hands."
        else
            local rnd = math.random(1, 2)
            if rnd == 1 then
                self.dialogue_override = "Underground?\nUndercooked!\nWhat ez ze issue?"
            else
                self.dialogue_override = "Quelle\nimpolitesse!"
            end
            return "* You accuse Sousborg of\nundercooking his food."
        end
    elseif name == "Boil" then
        local rnd = math.random(1, 2)
        if rnd == 1 then
            self.dialogue_override = "Water? Pah!\nI cannot touch such\na zing!"
        else
            self.dialogue_override = "No! Ze egg ez\nalready out of\nits casing!"
        end
        return "* You tell Sousborg to fill the\npan with water and turn up the\nheat."
    elseif name == "Fry" then
        self.dialogue_override = "Oui! Turn up\nze heat!"
        self:addMercy(35)
        self.sparing_stage = 3
        self:removeAct("Boil")
        self:removeAct("Fry")
        self:removeAct("Bake")
        self:registerAct("Refrigerate")
        self:registerAct("Pet")
        self:registerAct("Season")
        return "* You tell Sousborg to heat the\nstove until the egg begins to\nsizzle."
    elseif name == "Bake" then
        local rnd = math.random(1, 2)
        if rnd == 1 then
            self.dialogue_override = "What ez going on\ninside your tiny\nhead? Non!"
        else
            self.dialogue_override = "We are not making\npie! Get it\ntogezer!"
        end
        return "* You tell Sousborg to throw that\npuppy into the oven!"
    elseif name == "Refrigerate" then
        local rnd = math.random(1, 2)
        if rnd == 1 then
            self.dialogue_override = "Ze meal ez not\neven done and\nyou want\nleftovers?"
        else
            self.dialogue_override = "Hopeless!\nUnprofessional!"
        end
        return "* You tell Sousborg to wrap the\negg in plastic and let it chill\nout."
    elseif name == "Pet" then
        local rnd = math.random(1, 2)
        if rnd == 1 then
            self.dialogue_override = "It accomplished\ngiving me joy...\nbut I cannot eat\njoy!"
        else
            self.dialogue_override = "Ze egg is not\nalive! Well...\nnot anymore :/"
        end
        return "* You tell Sousborg to pet the\negg. He does. This accomplished\nnothing."
    elseif name == "Season" then
        self.dialogue_override = "Of course!\nI must sow ze\nseeds of flavour!"
        self:addMercy(35)
        self.sparing_stage = 4
        self:removeAct("Refrigerate")
        self:removeAct("Pet")
        self:removeAct("Season")
        return "* You tell Sousborg to grab some\npepper and sprinkle it over the\negg."
    elseif name == "Standard" then
        if self.low_health == true then
            return "* "..battler.chara:getName().." washes Sousborg's oil off of\ntheir hands."
        else
            self.dialogue_override = "To cle//a--I\nmean help all\nGerms conquer\nthe land!!"
			if battler.chara.id == "jamm" and Game:getFlag("marcy_joined") then
				return "* Jamm and Marcy offer to give Sousborg a scrub. They seem offended."
			end
            return "* "..battler.chara:getName().." offers to give Sousborg\na scrub. They seem offended."
        end
    end

    return super:onAct(self, battler, name)
end

function Sousborg:onDefeat(damage, battler)
    self.hurt_timer = -1
    local sprite = self:getActiveSprite()
    sprite:stopShake()
    self:defeat("KILLED", true)

    if Game:getFlag("steamworks_kills") == nil then
        Game:setFlag("steamworks_kills", 1)
    else
        Game:setFlag("steamworks_kills", Game:getFlag("steamworks_kills") + 1)
    end

    Game.battle.timer:after(0.8, function()
        Assets.playSound("ut_explosion")
        self:remove()
    end)
end

function Sousborg:getEncounterText()
    local has_spareable_text = self.spareable_text and self:canSpare()

    if self.low_health_text and self.health <= (self.max_health * self.low_health_percentage) then
        return Utils.pick(self.low_health_text)

    elseif has_spareable_text then
        return self.spareable_text
    end

    return Utils.pick(self.text)
end

function Sousborg:getEnemyDialogue()
    if self.dialogue_override then
        local dialogue = self.dialogue_override
        self.dialogue_override = nil
        return dialogue
    end
    if self.low_health_dialogue and self.health <= (self.max_health * self.low_health_percentage) then
        return Utils.pick(self.low_health_dialogue)
    end
    return Utils.pick(self.dialogue)
end

function Sousborg:onHurtEnd()
    self:getActiveSprite():stopShake()
    if self.health > 0 or not self.exit_on_defeat then
        self:toggleOverlay(false, true)
    end
    if self.low_health == false and self.health <= (self.max_health * self.low_health_percentage) then
        if self.sparing_stage == 2 then
            self.sparing_stage = 0
            self:removeAct("Boil")
            self:removeAct("Fry")
            self:removeAct("Bake")
        elseif self.sparing_stage == 3 then
            self.sparing_stage = 0
            self:removeAct("Refrigerate")
            self:removeAct("Pet")
            self:removeAct("Season")
        end
        self.low_health = true
        self:setActor("sousborgenemy_hurt")
    end
end

function Sousborg:getNextWaves()
    if self:canSpare() then
        return nil
    end
    return super.getNextWaves(self)
end

function Sousborg:onHurt(damage, battler)
    self:toggleOverlay(true)
    if Game.battle.tension_bar.visible then
        Game:giveTension(battler.tp_gain or 0)
    end
    battler.tp_gain = 0
    if self.actor.use_light_battler_sprite then
        if not self:getActiveSprite():setAnimation("lightbattle_hurt") then
            self:toggleOverlay(false)
        end
    else
        if not self:getActiveSprite():setAnimation("hurt") then
            self:toggleOverlay(false)
        end
    end

    self:getActiveSprite():shake(9, 0, 0.5, 2/30)

    local sound = self:getDamageVoice()
    if sound and type(sound) == "string" and not self:getActiveSprite().frozen then
        local thesound = Assets.stopAndPlaySound(sound)
        thesound:setPitch(0.5)
    end

    if self.health <= (self.max_health * self.tired_percentage) then
        self:setTired(true)
    end

    if self.health <= (self.max_health * self.spare_percentage) then
        self.mercy = 100
    end
end

return Sousborg