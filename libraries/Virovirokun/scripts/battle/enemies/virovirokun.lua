local Virovirokun, super = Class(EnemyBattler)

function Virovirokun:init()
    super.init(self)

    self.name = "Virovirokun"
    self:setActor("virovirokun")

    self.path = "enemies/virovirokun"
    self.default = "idle"

    self.max_health = 240
    self.health = 240
    self.attack = 8
    self.defense = 0
    self.money = 84

    self.spare_points = 20

    self.waves = {
        "virovirokun/needle",
        "virovirokun/invader"
    }

    self.check = "This sick virus\nneeds affordable healthcare."

    self.text = {
        "* Virovirokun is sweating\nsuspiciously.",
        "* Virovirokun uses a text\ndocument as a tissue.",
        "* Virovirokun is poking round\nthings with a spear.",
        "* Virovirokun is beeping a\ncriminal tune."
    }

    self.low_health_text = "* Virovirokun looks extra sick."

    self:registerAct("TakeCare")

    if #Game.party > 1 then
        self:registerAct("TakeCareX", "", "all")
    end

    -- Unused Deltarune act
    if Kristal.getLibConfig("virovirokun", "enable_cook") then
        self:registerActFor("ralsei", "Cook")
        self:registerActFor("susie", "Cook")

        local act_leader = Game:getActLeader()
        if act_leader then
            self:registerActFor(act_leader.id, "R-Cook", "", {"ralsei"})
            self:registerActFor(act_leader.id, "S-Cook", "", {"susie"})
        end
    end

    -- Custom Kristal act, made for testing
    if Kristal.getLibConfig("virovirokun", "enable_quarantine") then
        self:registerShortAct("Quarantine", "Make\nenemy\nTIRED")
    end

    self.dialogue_override = nil

    self.noelle_fallen = false
    self.noelle_last_x = 0
end

function Virovirokun:isXActionShort(battler)
    return true
end

function Virovirokun:onActStart(battler, name)
    local sprite_lookup = Kristal.getLibConfig("virovirokun", "take_care_sprites", true)
    local offset_lookup = Kristal.getLibConfig("virovirokun", "take_care_offsets", true)

    local function getSpriteAndOffset(id)
        local selected_sprite = sprite_lookup[id] or ("enemies/virovirokun/take_care/"..id)
        if type(selected_sprite) == "table" then
            selected_sprite = Utils.pick(sprite_lookup[id])
        end
        local selected_offset = offset_lookup[id] or {0, 0}
        return selected_sprite, selected_offset[1], selected_offset[2]
    end

    if name == "TakeCare" then
        battler:setActSprite(getSpriteAndOffset(battler.chara.id))
    elseif name == "TakeCareX" then
        for _,ibattler in ipairs(Game.battle.party) do
            ibattler:setActSprite(getSpriteAndOffset(ibattler.chara.id))
            if ibattler.chara.id == "noelle" then
                Game.battle.timer:script(function(wait)
                    local _, ox, oy = getSpriteAndOffset(battler.chara.id)
                    wait(1)
                    ibattler:setCustomSprite("enemies/virovirokun/take_care/noelle_fall_1", ox, oy)
                    Assets.playSound("noise")
                    ibattler.sprite:shake(5, 0, 1, 1/30)
                    wait(20/30)
                    ibattler:setCustomSprite("enemies/virovirokun/take_care/noelle_fall_2", ox, oy)
                    self.noelle_last_x = ibattler.x
                    ibattler.physics.speed_x = 6
                    ibattler.physics.friction = 0.75
                    Assets.playSound("splat", 0.6, 0.8)
                    wait(1)
                    self.noelle_fallen = true
                end)
            end
        end
    else
        super.onActStart(self, battler, name)
    end
end

function Virovirokun:onShortAct(battler, name)
    if name == "Quarantine" then
        if battler.chara.id == "kris" then
            return "* You told Virovirokun to stay home."
        else
            return "* " .. battler.chara:getName() .. " told Virovirokun to stay home."
        end
    elseif name == "Standard" then
        self:addMercy(50)
        if battler.chara.id == "noelle" then
            return "* Noelle offered a cold compress!"
        elseif battler.chara.id == "susie" then
            return "* Susie encouraged evil!"
        elseif battler.chara.id == "ralsei" then
            return "* Ralsei tried to rehabilitate!"
        end
    end
    return nil
end


function Virovirokun:onAct(battler, name)
    if name == "TakeCare" then
        self:addMercy(100)
        return "* You treated Virovirokun with\ncare! It's no longer\ninfectious!"
    elseif name == "Quarantine" then
        self:setTired(true)
        self.dialogue_override = "Fine..."
        return "* You told Virovirokun to stay home.\nVirovirokun became [color:blue]TIRED[color:reset]..."
    elseif name == "TakeCareX" then
        for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
            if enemy.id == "virovirokun" then
                enemy:addMercy(100)
            else
                enemy:addMercy(50)
            end
        end
        Game.battle:startActCutscene(function(cutscene)
            local has_noelle = false
            for _,party in ipairs(Game.battle.party) do
                if party.chara.id == "noelle" then
                    has_noelle = true
                    break
                end
            end
            if has_noelle and (#Game.battle.party == 2) then
                cutscene:text("* You and Noelle showed the enemy tender loving care!")
            else
                cutscene:text("* Everyone treated the enemy with\ntender loving care!! All the\nenemies felt great!!")
            end

            if not has_noelle then
                return
            end

            cutscene:wait(function() return self.noelle_fallen end)
            self.noelle_fallen = false

            local noelle = Game.battle:getPartyBattler("noelle")
            noelle.x = self.noelle_last_x

            for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
                if enemy.id == "virovirokun" then
                    enemy.dialogue_override = "Nice"
                end
            end
        end)
        return
    elseif name == "R-Cook" then
        Game.battle:startActCutscene("virovirokun", "cook_ralsei")
        return
    elseif name == "S-Cook" then
        Game.battle:startActCutscene("virovirokun", "cook_susie")
        return
    elseif name == "Cook" then
        if battler.chara.id == "ralsei" then
            Game.battle:startActCutscene("virovirokun", "cook_ralsei")
        elseif battler.chara.id == "susie" then
            Game.battle:startActCutscene("virovirokun", "cook_susie")
        else
            self:addMercy(20)
            return "* "..battler.chara:getName().." cooked up a cure!"
        end
        return
    elseif name == "Standard" then
        self:addMercy(50)
        if battler.chara.id == "noelle" then
            return "* Noelle offered a cold compress!"
        elseif battler.chara.id == "susie" then
            Game.battle:startActCutscene(function(cutscene)
                cutscene:text("* Susie commiserated with the enemy!")
                cutscene:text("* Stick it to the man,\ndude.", "smile", "susie")
                cutscene:text("* Even if that means\ncloning yourself, or\nwhatever.", "smile", "susie")
            end)
            return
        elseif battler.chara.id == "ralsei" then
            Game.battle:startActCutscene(function(cutscene)
                cutscene:text("* Ralsei tried to steer the enemy\ndown the right path.")
                cutscene:text("* Not everybody knows\nthis, but...", "smile", "ralsei")
                cutscene:text("* Crimes are bad. ... Did\nyou know that?",  "blush_smile", "ralsei")
            end)
            return
        end
    end
    return super.onAct(self, battler, name)
end

function Virovirokun:getEnemyDialogue()
    if self.dialogue_override then
        local dialogue = self.dialogue_override
        self.dialogue_override = nil
        return dialogue
    end

    local dialogue
    if self.mercy >= 100 then
        dialogue = {
            "Just what the\ndoctor ordered!",
            "Kindness is\ncontagious!"
        }
    else
        dialogue = {
            "Don't let\nthis bug ya!",
            "Happy new\nyear 1997!",
            "I've got a love\nletter for you.",
            "I'm the fever,\nI'm the chill."
        }
    end
    return dialogue[math.random(#dialogue)]
end

return Virovirokun