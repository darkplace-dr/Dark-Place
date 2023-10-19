local character, super = Class(PartyMember, "freddy")

function character:init()
    super.init(self)

    -- Display name
    self.name = "Freddy"

    -- Actor (handles overworld/battle sprites)
    self:setActor("freddy")

    -- Display level (saved to the save file)
    self.level = Game.chapter
    -- Default title / class (saved to the save file)
    if Game.chapter == 1 then
        self.title = "Freddy\nThe Bear."
    else
        self.title = "Freddy\nThe Bear Bot."
    end

    -- Determines which character the soul comes from (higher number = higher priority)
    self.soul_priority = 0
    -- The color of this character's soul (optional, defaults to red)
    self.soul_color = {1, 0, 0}

    -- Whether the party member can act / use spells
    self.has_act = false
    self.has_spells = false

    -- Whether the party member can use their X-Action
    self.has_xact = true
    -- X-Action name (displayed in this character's spell menu)
    self.xact_name = "F-Action"

    -- Current health (saved to the save file)
    if Game.chapter == 1 then
        self.health = 100
    else
        self.health = 100
    end

    -- Base stats (saved to the save file)
    if Game.chapter == 1 then
        self.stats = {
            health = 100,
            attack = 30,
            defense = 10,
            speed = 10, 
            --magic = 0
        }
    else
        self.stats = {
            health = 100,
            attack = 30,
            defense = 10,
            speed = 10, 
            --magic = 0
        }
    end
    -- Max stats from level-ups
    if Game.chapter == 1 then
        self.max_stats = {
            health = 1000
        }
    else
        self.max_stats = {
            health = 1000

        }
    end

    -- Weapon icon in equip menu
    self.weapon_icon = "ui/menu/equip/sword"

    -- Equipment (saved to the save file)
    --self:setWeapon("wood_blade")


    -- Default light world equipment item IDs (saves current equipment)
    --self.lw_weapon_default = "light/pencil"
    --self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {190/255, 100/255, 40/255}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = {190/255, 100/255, 40/255}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = {190/255, 100/255, 40/255}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = {190/255, 100/255, 40/255}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = {190/255, 100/255, 40/255}

    -- Head icon in the equip / power menu
    self.menu_icon = "party/freddy/head"
    -- Path to head icons used in battle
    self.head_icons = "party/freddy/icon"
    -- Name sprite
    --self.name_sprite = "party/kris/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/cut"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
    -- Pitch of the attack sound
    self.attack_pitch = 50/30

    -- Battle position offset (optional)
    self.battle_offset = {2, 1}
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



return character