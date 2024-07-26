---@class PincerEncounter : Encounter
---@overload fun(...) : Encounter
local PincerEncounter, super = Class(Encounter)

function PincerEncounter:init()
    super:init(self)
	
	self.left = {}
	self.right = {}
	
	self.PINCER = true -- DON'T CHANGE THIS
	self.flee = false -- I can't promise full Better Battles support but I at least got this
end

function PincerEncounter:getPartyPosition(index)
    local x, y = SCREEN_WIDTH/2, 0
    if #Game.battle.party == 1 then
        y = 140
    elseif #Game.battle.party == 2 then
        y = 100 + (80 * (index - 1))
    elseif #Game.battle.party == 3 then
        y = 50 + (80 * (index - 1))
    elseif #Game.battle.party == 4 then -- We MUST have MoreParty.
		if not Kristal.getLibConfig("moreparty", "classic_mode") then
			y = 20 + (70 * (index - 1))
		else
			local column = 0
			local reset = 0
			local middle = 0
			local classic = 2
			if #Game.battle.party > classic then
				if index <= classic then
					column = 80
				else
					reset = classic
					middle = (classic * 2 - #Game.battle.party) * 40
				end
			end
			x = 280 + column
			y = 100 + (50 / classic) + ((SCREEN_HEIGHT * 0.5) / classic) * (index - 1 - reset) + middle
			
			local battler = Game.battle.party[index]
			local ox, oy = battler.chara:getBattleOffset()
			y = y - (battler.actor:getHeight()  + oy) * 2
		end
	else
        local column = 0
        local reset = 0
        local middle = 0
        local classic = (Kristal.getLibConfig("moreparty", "classic_mode") and 3 or 4)
        if #Game.battle.party > classic then
            if index <= classic then
                column = 80
            else
                reset = classic
                middle = (classic * 2 - #Game.battle.party) * ((Kristal.getLibConfig("moreparty", "classic_mode") and 40 or 35))
            end
        end
        x = 280 + column
        y = (((not Kristal.getLibConfig("moreparty", "classic_mode") and #Game.battle.party <= 4) and 120 or 50) / classic) + ((SCREEN_HEIGHT * 0.5) / classic) * (index - 1 - reset) + middle
    end

    local battler = Game.battle.party[index]
    local ox, oy = battler.chara:getBattleOffset()
    y = y + (battler.actor:getHeight()  + oy) * 2
    return x, y
end

function PincerEncounter:addEnemy(enemy, left, x, y, ...)
    local enemy_obj
    if type(enemy) == "string" then
        enemy_obj = Registry.createEnemy(enemy, ...)
    else
        enemy_obj = enemy
    end
    local enemies = self.queued_enemy_spawns
    local enemies_index = enemies
    local transition = false

	if left then
		table.insert(self.left, enemy_obj)
		enemy_obj.left = true
	else
		table.insert(self.right, enemy_obj)
		enemy_obj.left = false
	end
    
    
    if Game.battle and Game.state == "BATTLE" then
        enemies = Game.battle.enemies
        enemies_index = Game.battle.enemies_index
        transition = Game.battle.state == "TRANSITION"
    end
    if transition then
        enemy_obj:setPosition(SCREEN_WIDTH + 200, y)
    end
    if x and y then
        enemy_obj.target_x = x
        enemy_obj.target_y = y
        if not transition then
            enemy_obj:setPosition(x, y)
        end
    else
        for _,enemy in ipairs(enemies) do
			if enemy.left and left then
				enemy.target_x = enemy.target_x + 10
				enemy.target_y = enemy.target_y - 45
				if not transition then
					enemy.x = enemy.x + 10
					enemy.y = enemy.y - 45
				end
			elseif not enemy.left and not left then
				enemy.target_x = enemy.target_x - 10
				enemy.target_y = enemy.target_y - 45
				if not transition then
					enemy.x = enemy.x - 10
					enemy.y = enemy.y - 45
				end
			end
        end
        local x, y = 0, 0
		if left then
			x, y = 90 - (10 * #self.left), 200 + (45 * #self.left)
			enemy_obj.sprite.flip_x = true
		else
			x, y = 550 + (10 * #self.right), 200 + (45 * #self.right)
		end
        enemy_obj.target_x = x
        enemy_obj.target_y = y
        if not transition then
            enemy_obj:setPosition(x, y)
        end
    end
    enemy_obj.encounter = self
    table.insert(enemies, enemy_obj)
    table.insert(enemies_index, enemy_obj)
    if Game.battle and Game.state == "BATTLE" then
        Game.battle:addChild(enemy_obj)
    end
    return enemy_obj
end

function PincerEncounter:contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

return PincerEncounter