local character, super = Class(PartyMember, "frisk")

function character:init()
    super.init(self)

    -- Display name
    self.name = "Frisk"

    -- Actor (handles overworld/battle sprites)
    self:setActor("frisk")
    self:setLightActor("frisk_lw")

    -- Display level (saved to the save file)
    self.level = Game.chapter
    -- Default title / class (saved to the save file)
    if Game.chapter == 1 then
        self.title = "Fallen Human\nArrived from a\ndiffrent world."
    else
        self.title = "Fallen Human\nArrived from a\ndiffrent world."
    end

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = 2
    -- The color of this character's soul (optional, defaults to red)
    --self.soul_color = {1, 0, 0}

    -- Whether the party member can act / use spells
    self.has_act = true
    self.has_spells = true

    -- Whether the party member can use their X-Action
    self.has_xact = true
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "F-Action"

    -- Current health (saved to the save file)
    if Game.chapter == 1 then
        self.health = 90
    else
        self.health = 90
    end

    -- Base stats (saved to the save file)
    if Game.chapter == 1 then
        self.stats = {
            health = 90,
            attack = 10,
            defense = 2,
            magic = 0
        }
    else
        self.stats = {
            health = 90,
            attack = 10,
            defense = 2,
            magic = 0
        }
    end
    -- Max stats from level-ups
    if Game.chapter == 1 then
        self.max_stats = {
            health = 120
        }
    else
        self.max_stats = {
            health = 120
        }
    end

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/rapier"

    -- Equipment (saved to the save file)
    self:setWeapon("wood_rapier")
    if Game.chapter >= 2 then
   --     self:setArmor(1, "amber_card")
    --    self:setArmor(2, "amber_card")
    end

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "ut_weapons/stick"
    self.lw_armor_default = "ut_armors/bandage"





    -- Character color (for action box outline and hp bar)
    self.color = {170/255, 1, 0}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = {170/255, 1, 0}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = {170/255, 1, 0}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = {85/255, 1, 0}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = {170/255, 1, 0}

    -- Head icon in the equip / power menu
    self.menu_icon = "party/frisk/head"
    -- Path to head icons used in battle
    self.head_icons = "party/frisk/icon"
    -- Name sprite
    self.name_sprite = "party/frisk/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/cut"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
    -- Pitch of the attack sound
    self.attack_pitch = 1

    -- Battle position offset (optional)
    self.battle_offset = {-2, -1}
    -- Head icon position offset (optional)
    self.head_icon_offset = nil
    -- Menu icon position offset (optional)
    self.menu_icon_offset = nil

    -- Message shown on gameover (optional)
    self.gameover_message = nil
end

function character:onLevelUp(level)
    self:increaseStat("health", 2)
    if level % 10 == 0 then
        self:increaseStat("attack", 1)
    end
end

function character:onPowerSelect(menu)
    if Utils.random() < ((Game.chapter == 1) and 0.02 or 0.04) then
        menu.kris_dog = true
    else
        menu.kris_dog = false
    end
end

function character:drawPowerStat(index, x, y, menu)
    if index == 1 and menu.kris_dog then
        local frames = Assets.getFrames("misc/dog_sleep")
        local frame = math.floor(Kristal.getTime()) % #frames + 1
        love.graphics.print("Dog:", x, y)
        love.graphics.draw(frames[frame], x+120, y+5, 0, 2, 2)
        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        love.graphics.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)

        love.graphics.draw(icon, x+90, y+6, 0, 2, 2)
        if Game.chapter >= 2 then
            love.graphics.draw(icon, x+110, y+6, 0, 2, 2)
        end
        return true
    end
end



return character