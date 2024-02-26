deltacrackLib = {}
local lib = deltacrackLib

function lib:postInit(new_file)
    PALETTE["blue_tension_back"] = { 13 / 255, 13 / 255, 114 / 255, 1 }
    PALETTE["blue_tension_decrease"] = { 1, 0, 0, 1 }
    PALETTE["blue_tension_fill"] = { 89 / 255, 150 / 255, 1, 1 }
    PALETTE["blue_tension_max"] = { 135 / 255, 219 / 255, 1, 1 }
    PALETTE["blue_tension_maxtext"] = { 1, 1, 0, 1 }
    PALETTE["blue_tension_desc"] = { 255 / 255, 160 / 255, 64 / 255, 1 }
end

function lib:init()

    Utils.hook(EnemyBattler, "executeFlash", function(orig, self, color)
        color = color or {1, 0, 0}

        local recolor = self:addFX(RecolorFX())
        Game.battle.timer:during(8/30, function()
            recolor.color = Utils.lerp(recolor.color, color, 0.12 * DTMULT)
        end, function()
            Game.battle.timer:during(8/30, function()
                recolor.color = Utils.lerp(recolor.color, {1, 1, 1}, 0.16 * DTMULT)
            end, function()
                self:removeFX(recolor)
            end)
        end)
    end)
    Utils.hook(EnemyBattler, "getNameColorsExecutable", function(orig, self)
        local result = {}
        if self.mercy >= 75 and self.health <= (self.max_health/2) then
            table.insert(result, {1, 0, 0})
        end
        if self.tired then
            table.insert(result, {0, 0.7, 1})
        end
        return result
    end)
    --[[
    Utils.hook(DarkPowerMenu, "getSpells", function(orig, self)
        local spells = {}
        local party = self.party:getSelected()
        if party:hasAct() then
            table.insert(spells, Registry.createSpell("_act"))
        end
        if party.id == "goob" then
            table.insert(spells, Registry.createSpell("_execute"))
            table.insert(spells, Registry.createSpell("_conversion"))
        end
        for _,spell in ipairs(party:getSpells()) do
            table.insert(spells, spell)
        end
        return spells
    end)
    --]]
    Utils.hook(EnemyBattler, "incinerate", function(orig, self)
        self:recruitMessage("incinerated")
    
        self.hurt_timer = -1

        Assets.playSound("deathnoise")

        local sprite = self:getActiveSprite()

        sprite.visible = false
        sprite:stopShake()

        local death_x, death_y = sprite:getRelativePos(0, 0, self)
        local death = FatalEffect(sprite:getTexture(), death_x, death_y, function() self:remove() end)
        death:setColor(sprite:getDrawColor())
        death:setScale(sprite:getScale())
        self:addChild(death)
    
        Game.battle.money = Game.battle.money + 24
        self:defeat("KILLED", true)
    end)
    
end

function lib:switchRalsei(style)
    local ralsei = Game.world:getCharacter("ralsei")
    local actor = ralsei.actor
    local party = ralsei:getPartyMember()
    local rstyle = Game:getFlag("r_style", 2)
    if style == 1 then
        actor.path = "party/ralsei/dark_ch1"
        actor.portrait_path = "face/ralsei_hat"
        if party then
            party.menu_icon = "party/ralsei/head_ch1"
            party.head_icon_offset = {3,0}
        end
        actor:initChapter1()
        Game:setFlag("r_style", 1)
        ralsei:resetSprite()
    elseif style == 2 then
        actor.path = "party/ralsei/dark"
        actor.portrait_path = "face/ralsei"
        if party then
            party.menu_icon = "party/ralsei/head"
            party.head_icon_offset = {0,0}
        end
        actor:initChapter2()
        Game:setFlag("r_style", 2)
        ralsei:resetSprite()
    end
end

--[[
function lib:setActorPath(_actor, style)
    if _actor == "lancer" then
        local lancer = Game.world:getCharacter("lancer")
        local actor = lancer.actor
        local party = lancer:getPartyMember()
        local rstyle = Game:getFlag("r_style", 2)
        if style == "normal" then
            actor.portrait_path = "face/lancer_hat"
            actor.default = "walk"
            Game:setFlag("lancer_path", "normal")
            lancer:resetSprite()
        elseif style == "mustache" then
            actor.portrait_path = "face/lancer"
            actor.default = "walk_mustache"
            Game:setFlag("lancer_path", "mustache")
            lancer:resetSprite()
        end
    end
end
--]]

function lib:setActorDefault(_actor, default)
    if _actor == "ralsei" then
        local ralsei = Game.world:getCharacter("ralsei")
        local actor = ralsei.actor
        local rstyle = Game:getFlag("r_default", "normal")
        if default == "normal" then
            actor.default = default
            Game:setFlag("r_default", default)
            ralsei:resetSprite()
        elseif default == "unhappy" then
            actor.default = default
            Game:setFlag("r_default", default)
            ralsei:resetSprite()
        end
    elseif _actor == "synthlave" then
        local synthlave = Game.world:getCharacter("synthlave")
        local actor = synthlave.actor
        local rstyle = Game:getFlag("sl_default", "normal")
        if default == "normal" then
            actor.default = default
            Game:setFlag("sl_default", default)
            synthlave:resetSprite()
        elseif default == "hood" then
            actor.default = default
            Game:setFlag("sl_default", default)
            synthlave:resetSprite()
        end
    end
end

return lib