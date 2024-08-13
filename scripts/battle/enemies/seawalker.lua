local Seawalker, super = Class(EnemyBattler)

function Seawalker:init()
    super.init(self)

    self.name = "Seawalker"
    self:setActor("seawalker")

    self.path = "enemies/seawalker"
    self.default = ""
    self.sprite:set("wings")

    self.max_health = 6000
    self.health = 6000
    self.attack = 12
    self.defense = 2
    self.money = 420
    self.experience = 420
	self.service_mercy = 0
	
	self.boss = true

    self.spare_points = 0

    self.killable = true
    self.exit_on_defeat = false
    self.auto_spare = true

    self.movearound = true

    self.waves = {
        "starwings_normal",
        "starcomets"
    }

    self.check = "The   original\n            ."

    self.text = {
        "* Sea walker",
        "* Smells like   [color:blue]pissed off[color:reset]",
        "*               this encounter\n is against sea  walker",
        "* this [color:blue]battle[color:reset] is     [color:blue]pissing[color:reset] me\noff..."
    }

    self.low_health_text = "* Sea walker has      hurt"

    self:registerAct("Sea walker", "")
    self:registerAct("Red Buster", "Red\nDamage", "susie", 60)
    self:registerAct("DualHeal", "Heals\neveryone", "ralsei", 50)

    self.text_override = nil
end

function Seawalker:onSpared()
    super.onSpared(self)

    self.sprite:resetSprite()
    Game.battle.music:stop()

    if not Game.battle.cutscene then
        Game.battle:startCutscene("starwalkerb.spare", nil, self)
    end
end

function Seawalker:isXActionShort(battler)
    return true
end

function Seawalker:onActStart(battler, name)
    super.onActStart(self, battler, name)
end

function Seawalker:onAct(battler, name)
    if name == "DualHeal" then
        Game.battle:powerAct("dual_heal", battler, "ralsei")
    elseif name == "Red Buster" then
        Game.battle:powerAct("red_buster", battler, "susie", self)
    elseif name == "Sea walker" then
        self:addMercy(8)
        return "* The Original Seawalker  absorbs the\nACT"
    elseif name == "Standard" then
        self:addMercy(4)
        if battler.chara.id == "ralsei" then
            Game:gameOver(Game.world.player.x, Game.world.player.y)
            return "* Ralsei explodes and dies\n(it got [color:yellow]absorbed[color:reset])"
        elseif battler.chara.id == "susie" then
            return "* Susie more like sussy\n(it got [color:yellow]absorbed[color:reset])"
        elseif battler.chara.id == "bor" then
            return "* Bor got bored\n(it got [color:yellow]absorbed[color:reset])"
        elseif battler.chara.id == "jamm" then
            return "* Mmm strawberry jamm\n(it got [color:yellow]absorbed[color:reset])"
        else
            return "* " .. battler.chara.name .. " did a thing\n(it got [color:yellow]absorbed[color:reset])"
        end
    end
    return super.onAct(self, battler, name)
end

function Seawalker:onShortAct(battler, name)
    if name == "Standard" then
        self:addMercy(4)
        if battler.chara.id == "ralsei" then
            Game:gameOver(Game.world.player.x, Game.world.player.y)
            return "* Ralsei explodes and dies"
        elseif battler.chara.id == "susie" then
            return "* Susie more like sussy"
        elseif battler.chara.id == "bor" then
            return "* Bor got bored"
        elseif battler.chara.id == "jamm" then
            return "* Mmm strawberry jamm"
        else
            return "* " .. battler.chara.name .. " did a thing"
        end
    end
    return nil
end


function Seawalker:getEnemyDialogue()
    if self.text_override then
        local dialogue = self.text_override
        self.text_override = nil
        return dialogue
    end

    local dialogue
    if self.mercy >= 100 then
        dialogue = {
            "walk",
            "sea"
        }
    else
        dialogue = {
            "sea",
            "walker"
        }
    end
    return dialogue[math.random(#dialogue)]
end

function Seawalker:onDefeat(damage, battler)
    if self.encounter.id ~= "starwalker" and self.encounter.id ~= "og_starwalker" and self.encounter.id ~= "seawalker" then
        return super.onDefeatFatal(self, damage, battler)
    end
    self:defeat("KILLED", true)
end

return Seawalker
