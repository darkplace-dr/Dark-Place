local OGStarwalker, super = Class(EnemyBattler)

function OGStarwalker:init()
    super.init(self)

    self.name = "Starwalker"
    self:setActor("og_starwalker")

    self.path = "enemies/ogstarwalker"
    self.default = ""
    self.sprite:set("wings")

    self.max_health = 6000
    self.health = 6000
    self.attack = 12
    self.defense = 2
    self.money = 420
    self.experience = Mod:isInRematchMode() and 0 or 0

    self.usedWalkerTimes = 0

    self.spare_points = 0

    self.exit_on_defeat = false
    self.auto_spare = true

    self.movearound = true

    self.waves = {
        "starwings",
        "starwings_b",
        "starwings_normal"
        --"solidtest"
    }

    self.check = "The   original\n            ..."

    self.text = {
        "* Star walker",
        "* Smells like   [color:yellow]pissed off[color:reset]",
        "*               this encounter\n is against star  walker",
        "* this [color:yellow]battle[color:reset] is     [color:yellow]pissing[color:reset] me\noff...",
        "* You are     [color:yellow]pissing[color:reset] me\noff..."
    }

    self.low_health_text = "* Star walker has      hurt"

    self:registerAct("Walker", "")
    self:registerAct("Red Buster", "Red\nDamage", "susie", 60)
    self:registerAct("DualHeal", "Heals\neveryone", "ralsei", 50)

    self.text_override = nil
end

function OGStarwalker:onSpared()
    super.onSpared(self)

    self.sprite:resetSprite()
    Game.battle.music:stop()
end

function OGStarwalker:isXActionShort(battler)
    return true
end

function OGStarwalker:onActStart(battler, name)
    super.onActStart(self, battler, name)
end

function OGStarwalker:onAct(battler, name)
    if name == "DualHeal" then
        Game.battle:powerAct("dual_heal", battler, "ralsei")
    elseif name == "Red Buster" then
        Game.battle:powerAct("red_buster", battler, "susie", self)
    elseif name == "Walker" then
        if self.usedWalkerTimes == 0 then
            self:addMercy(8)
            self.usedWalkerTimes = 1
        elseif self.usedWalkerTimes == 1 then
            self:addMercy(16)
            self.usedWalkerTimes = 2
        else
            self:addMercy(32)
        end
        return "* The Original Starwalker  absorbs the\nACT"
    elseif name == "Standard" then
        self:addMercy(4)
        if battler.chara.id == "ralsei" then
            Game:gameOver(Game.world.player.x, Game.world.player.y)
            return "* Ralsei explodes and dies\n(it got [color:yellow]absorbed[color:reset])"
        elseif battler.chara.id == "susie" then
            return "* Susie more like sussy\n(it got [color:yellow]absorbed[color:reset])"
        elseif battler.chara.id == "bor" then
            return "* Bor got bored\n(it got [color:yellow]absorbed[color:reset])"
        else
            return "* " .. battler.chara.name .. " did a thing\n(it got [color:yellow]absorbed[color:reset])"
        end
    end
    return super.onAct(self, battler, name)
end

function OGStarwalker:onShortAct(battler, name)
    if name == "Standard" then
        self:addMercy(4)
        if battler.chara.id == "ralsei" then
            Game:gameOver(Game.world.player.x, Game.world.player.y)
            return "* Ralsei explodes and dies"
        elseif battler.chara.id == "susie" then
            return "* Susie more like sussy"
        elseif battler.chara.id == "bor" then
            return "* Bor got bored"
        else
            return "* " .. battler.chara.name .. " did a thing"
        end
    end
    return nil
end


function OGStarwalker:getEnemyDialogue()
    if self.text_override then
        local dialogue = self.text_override
        self.text_override = nil
        return dialogue
    end

    local dialogue
    if self.mercy >= 100 then
        dialogue = {
            "walk",
            "star"
        }
    else
        dialogue = {
            "star",
            "walker"
        }
    end
    return dialogue[math.random(#dialogue)]
end

function OGStarwalker:onDefeat(damage, battler)
    
    if not Game.battle.cutscene then
        Game.battle:startCutscene("starwalkerb.die", battler, self)
    end
    --self:onDefeatFatal(damage, battler)
    
end

return OGStarwalker