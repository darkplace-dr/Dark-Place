local character, super = Class(PartyMember, "lancer")

function character:init()
    super.init(self)

    -- Display name
    self.name = "Lancer"

    -- Actor (handles overworld/battle sprites)
    self:setActor("lancer")

    -- Display level (saved to the save file)
    self.level = Game.chapter
    -- Default title / class (saved to the save file)
    if Game.chapter == 1 then
        self.title = "Dark Prince\nDark-World being.\nHas no friends."
    else
        self.title = "King of Spades\nDark-World being.\nRules his kingdom."
    end

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = 1
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = {1, 0, 0}

    -- Whether the party member can act / use spells
    self.has_act = false
    self.has_spells = true

    -- Whether the party member can use their X-Action
    self.has_xact = true
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "L-Action"
    
    -- Spells
    self:addSpell("spadeshoot")
	self:addSpell("heal_prayer")

    -- Current health (saved to the save file)
    self.health = 100

    -- Base stats (saved to the save file)
    self.stats = {
        health = 100,
        attack = 12,
        defense = 3,
        magic = 9
    }
    -- Max stats from level-ups
    self.max_stats = {
        health = 176
    }

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/spade"

    -- Equipment (saved to the save file)
    self:setWeapon("spade")

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {84/255, 130/255, 187/255}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = {95/255, 147/255, 211/255}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = {84/255, 130/255, 187/255}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = {49/255, 92/255, 145/255}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = {95/255, 147/255, 211/255}

    -- Head icon in the equip / power menu
    self.menu_icon = "party/lancer/head"
    -- Path to head icons used in battle
    self.head_icons = "party/lancer/icon"
    -- Name sprite
    self.name_sprite = "party/lancer/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/cut"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
    -- Pitch of the attack sound
    self.attack_pitch = 1

    -- Battle position offset (optional)
    self.battle_offset = {2, 1}
    -- Head icon position offset (optional)
    self.head_icon_offset = {2, -1}
    -- Menu icon position offset (optional)
    self.menu_icon_offset = nil

    -- Message shown on gameover (optional)
    self.gameover_message = nil

    -- Character flags (saved to the save file)
    self.flags = {
        ["spades_thrown"] = 0
    }
end

function character:getTitle()
    if self:checkWeapon("cardblaster") then
        return "LV"..self.level.." Spade Knight\nInflicts pain to\nbecome stronger."
    elseif self:getFlag("spades_thrown", 0) > 0 then
        return "LV"..self.level.." Spade Shooter\nImpales the enemy."
    else
        return "LV1 "..self.title
    end
end

function character:getGameOverMessage(main)
    return {
        "U-umm... ".. main.name ..", are you OK?",
        "C-Come on! We... still have stuff to do!"
    }
end

function character:onLevelUp(level)
    self:increaseStat("health", 4)
    if level % 4 == 0 then
        self:increaseStat("attack", 1)
        self:increaseStat("magic", 1)
    end
end

function character:drawPowerStat(index, x, y, menu)
    if index == 1 then
        
        local icon = Assets.getTexture("ui/menu/icon/spade")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)

        love.graphics.print("Royal Status", x, y, 0, 0.6, 1)
        if Game.chapter == 1 then
            love.graphics.print("Prince", x+130, y, 0, 0.7, 1)
        else
            love.graphics.print("King", x+130, y)
        end

        return true
		
    elseif index == 2 then
        
        local icon = Assets.getTexture("ui/menu/icon/demon")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)

        love.graphics.print("Bad Guy", x, y, 0, 1, 1)
        if Game.chapter == 1 then
            love.graphics.print("Yes", x+130, y)
        else
            love.graphics.print("Maybe", x+130, y, 0, 0.8, 1)
        end

        return true

    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)
        return true
    end
end

return character