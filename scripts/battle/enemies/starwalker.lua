local Starwalker, super = Class(EnemyBattler)

function Starwalker:init()
    super.init(self)

    self.name = "Starwalker"
    self:setActor("starwalker")

    self.path = "enemies/starwalker"
    self.default = ""
    self.sprite:set("wings")

    self.max_health = 6000
    self.health = 6000
    self.attack = 12
    self.defense = 2
    self.money = 420

    self.spare_points = 0

    self.exit_on_defeat = false
    self.auto_spare = true

    self.movearound = true

    self.waves = {
        "starwings_normal"
    }

    self.check = "The   original\n            ."

    self.text = {
        "* Star walker",
        "* Smells like   [color:yellow]pissed off[color:reset]",
        "*               this encounter\n is against star  walker",
        "* this [color:yellow]battle[color:reset] is     [color:yellow]pissing[color:reset] me\noff...",
        "* Smells like a subtle DeltaRaid reference."
    }

    self.low_health_text = "* Star walker has      hurt"

    self:registerAct("Star walker", "")
    self:registerAct("Red Buster", "Red\nDamage", "susie", 60)
    self:registerAct("DualHeal", "Heals\neveryone", "ralsei", 50)

    self.text_override = nil
end

function Starwalker:onSpared()
    super.onSpared(self)

    self.sprite:resetSprite()
    Game.battle.music:stop()
end

function Starwalker:isXActionShort(battler)
    return true
end

function Starwalker:onActStart(battler, name)
    super.onActStart(self, battler, name)
end

function Starwalker:onAct(battler, name)
    if name == "DualHeal" then
        Game.battle:powerAct("dual_heal", battler, "ralsei")
    elseif name == "Red Buster" then
        Game.battle:powerAct("red_buster", battler, "susie", self)
    elseif name == "Star walker" then
        self:addMercy(8)
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

function Starwalker:onShortAct(battler, name)
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


function Starwalker:getEnemyDialogue()
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

function Starwalker:onDefeat(damage, battler)

    -- All of this is commented because Love2D is being a bitch and giving me errors that make no sense
    -- Pls fix if you can :heart:

    --self.movearound = false
    --Game.battle:startCutscene("starwalker.die", battler, Starwalker)
    --[[]
    Game.battle.startCutscene(function(cutscene, battler, enemy)

		Game.battle.music:stop()
		cutscene:wait(2)
		if cutscene:getCharacter("susie") then
			cutscene:getCharacter("susie"):setSprite("shock_right")
		end
		Assets.playSound("sussurprise")
		--cutscene:setAnimation(Game.world.player, "battle/attack_ready" or "battle/right")
		cutscene:slideTo(Game.world.player, enemy.x - 20, enemy.y, 0.2)
		cutscene:wait(0.2)
		Assets.playSound("slash")
		--cutscene:setAnimation(Game.world.player, "battle/attack" or "battle/right")
		enemy:statusMessage("damage", 999, color or (battler and {battler.chara:getDamageColor()}))
		enemy:hurt(999999999, battler, enemy.onDefeatFatal)
		cutscene:wait(0.5)
		Game.world.player:setSprite("right_1")

		cutscene:fadeOut(1)

		cutscene:wait(1)

		Game.battle:setState("TRANSITIONOUT")
		Game.battle.encounter:onBattleEnd()

		cutscene:wait(0.5)

		cutscene:fadeIn(0.5)

		enemy.done_state = "KILLED"

        local done_state = enemy.done_state
        
        if done_state == "VIOLENCED" or done_state == "KILLED" or done_state == "FROZEN" then
            cutscene:wait(1)
            cutscene:text("* Hey,[wait:5] uh.", "neutral", "susie")
            cutscene:text("* I know they were in our way,[wait:5] but...", "annoyed_down", "susie")
            susie:setFacing("up")
            cutscene:text("* What happened to the ACTing thing?", "neutral", "susie")
            cutscene:text("* ...", "annoyed_down", "susie")
            Assets.playSound("ominous")
            cutscene:wait(1.5)
            Game:setFlag("weird", true)
            Game.world.music:play("cybercity_alt")
            Game.world.player:setFacing("down")
        end

        event.sprite:resetSprite()

        cutscene:interpolateFollowers()
        cutscene:attachFollowers()

        event.interacted = false

	end)
    --]]
    self:onDefeatFatal(damage, battler)
end

return Starwalker
