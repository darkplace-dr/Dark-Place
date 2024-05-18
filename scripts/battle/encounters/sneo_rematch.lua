local SNEORematch, super = Class(Encounter)

function SNEORematch:init()
    super.init(self)

    self.sneo = self:addEnemy("sneo")

    self.text = "* Time to be a BIG SHOT once more!"

    self.music = "deltarune/spamton_neo_mix_ex_wip"

    self.background = true

	self.default_xactions = false
	
	self.flee = false

    self.boss_rush = false
	
    if Game:getFlag("sneo_defeated") == true then
        self.boss_rush = true
    end
end

function SNEORematch:beforeStateChange(old, new)
    if new == "ENEMYDIALOGUE" then
        local cutscene = Game.battle:startCutscene("sneo_rematch.dialogue_test")
        cutscene:after(function()
            Game.battle:setState("DIALOGUEEND")
        end)
    end
end

function SNEORematch:onBattleInit()
    super.onBattleInit(self)
    if self.boss_rush == true then
        Game.battle.dojo_bg = DojoBG({1, 1, 1})
        Game.battle:addChild(Game.battle.dojo_bg)
    else
        Game.battle.sneo_bg = SpamtonBG()
        Game.battle:addChild(Game.battle.sneo_bg)
    end
end

function SNEORematch:onBattleStart(battler)
    --Game:setFlag("f1", true)
    for _,battler in ipairs(Game.battle.party) do
        if battler.chara.id == "susie" then
	        Game.battle:registerXAction("susie", "Snap")
	        Game.battle:registerXAction("susie", "AutoAim", "Homing\nbullets", 80)
        else
	        Game.battle:registerXAction(battler.chara.id, "Snap")
        end
    end
end

function SNEORematch:getPartyPosition(index)
    if #Game.party == 4 then
	    if index == 1 then -- if it's the first party member (in this case, kris)
		    return 103, 136 -- just an example please do not do this number
		elseif index == 2 then -- if it's the first party member (in this case, kris)
		    return 111, 188 -- just an example please do not do this number
		elseif index == 3 then -- if it's the first party member (in this case, kris)
		    return 105, 249 -- just an example please do not do this number
		elseif index == 4 then -- if it's the first party member (in this case, kris)
		    return 97, 305 -- just an example please do not do this number
	    else
		    return super.getPartyPosition(self, index)
		end
    elseif #Game.party == 2 then
	    if index == 1 then -- if it's the first party member (in this case, kris)
		    return 103, 172 -- just an example please do not do this number
	    else
		    return super.getPartyPosition(self, index)
		end
    elseif #Game.party == 1 then
	    if index == 1 then -- if it's the first party member (in this case, kris)
		    return 103, 218 -- just an example please do not do this number
	    else
		    return super.getPartyPosition(self, index)
		end
	else
	    if index == 1 then -- if it's the first party member (in this case, kris)
		    return 103, 136 -- just an example please do not do this number
		else
		    return super.getPartyPosition(self, index)
		end
	end
end

return SNEORematch
