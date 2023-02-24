local Grounder, super = Class(Encounter)

function Grounder:init()
    super:init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Grounder drew near!"

    -- Battle music ("battle" is rude buster)
    self.music = "battle_repainted"
    -- Enables the purple grid battle background
    self.background = true

    -- Add the enemy to the encounter
    self:addEnemy("grounder")
end

-- TODO: Glowshard functions in enemies
function Grounder:onGlowshardUse(user)
    local lines = ""
    for _, enemy in ipairs(Game.battle.enemies) do
        lines = lines .. "* " .. enemy.name .. " became enraptured!\n"
        enemy:addMercy(100)
    end
    local inventory = Game.inventory:getStorage("item")
    for index,item in ipairs(inventory) do
        if item.id == "glowshard" then
            Game.inventory:removeItem("item", index)
            break
        end
    end
    return {
        "* "..user.chara.name.." used the GLOWSHARD!",
        lines,
        "* The GLOWSHARD disappeared!"
    }
end

-- TODO: Manual functions in enemies
function Grounder:onManualUse(user)
    local lines = ""
    for _, enemy in ipairs(Game.battle.enemies) do
        if enemy.id == "grounder" then
            lines = lines .. "* " .. enemy.name .. " was [color:blue]bored to tears[color:reset]!\n"
            enemy:setAnimation("tired")
            enemy:setTired(true)
            enemy.text_override = "Hey can\nyou read\nit more fast?"
        end
    end
    return {
        "* "..user.chara.name.." read the MANUAL!",
        lines
    }
end

function Grounder:onBattleInit()
	super:onBattleInit(self)
	Game.battle.repainted_bg = RepaintedBG({1, 1, 1})
	Game.battle:addChild(Game.battle.repainted_bg)
end

return Grounder