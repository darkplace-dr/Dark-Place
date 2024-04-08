local actor, super = Class("noelle_lw", true)

function actor:init()
    super.init(self)

    -- Table of sprite animations
    Utils.merge(self.animations, {
        -- Battle animations
        ["battle/idle"]         = {"battle/idle", 0.2, true},

        ["battle/attack"]       = {"battle/attack", 1/15, false},
        ["battle/act"]          = {"battle/act", 1/15, false},
        ["battle/spell"]        = {"battle/spell", 1/15, false, next="battle/idle"},
        ["battle/item"]         = {"battle/item", 1/12, false, next="battle/idle"},
        ["battle/spare"]        = {"battle/spell", 1/15, false, next="battle/idle"},

        ["battle/attack_ready"] = {"battle/attackready", 0.2, true},
        ["battle/act_ready"]    = {"battle/actready", 0.2, true},
        ["battle/spell_ready"]  = {"battle/spellready", 0.2, true},
        ["battle/item_ready"]   = {"battle/itemready", 0.2, true},
        ["battle/defend_ready"] = {"battle/defend", 1/15, false},

        ["battle/act_end"]      = {"battle/actend", 1/15, false, next="battle/idle"},

        ["battle/hurt"]         = {"battle/hurt", 1/15, false, temp=true, duration=0.5},
        ["battle/defeat"]       = {"battle/defeat", 1/15, false},

        ["battle/transition"]   = {"battle/intro", 1/15, false},
        ["battle/victory"]      = {"battle/victory", 1/10, false},
    }, false)

    -- Alternate animations to use for Noelle weird mode (false to disable the animation)
    self.animations_alt = {
        -- Battle animations
        ["battle/idle"]         = {"battle_alt/idle", 0.2, true},

        ["battle/attack"]       = {"battle/spell", 1/15, false, next="battle/idle"},

        ["battle/attack_ready"] = {"battle/idle", 0.2, true},
        ["battle/defend_ready"] = {"battle_alt/defend", 1/15, false},

        ["battle/hurt"]         = {"battle_alt/hurt", 1/15, false, temp=true, duration=0.5},

        ["battle/transition"]   = {"battle_alt/intro", 1/15, false},
        ["battle/victory"]      = {"battle_alt/pray", 5/30, true},
    }

    -- Tables of sprites to change into in mirrors
    Utils.merge(self.mirror_sprites, {

        ["walk_alt/down"] = "walk_alt/up",
        ["walk_alt/up"] = "walk_alt/down",
        ["walk_alt/left"] = "walk_alt/left",
        ["walk_alt/right"] = "walk_alt/right",
    }, false)

    -- Table of sprite offsets (indexed by sprite name)
    Utils.merge(self.offsets, {

        -- Battle offsets
        ["battle/idle"] = {-3, 0},

        ["battle/attack"] = {-8, 0},
        ["battle/attackready"] = {0, 0},
        ["battle/act"] = {0, 0},
        ["battle/actend"] = {0, 0},
        ["battle/actready"] = {0, 0},
        ["battle/spell"] = {-3, 0},
        ["battle/spellready"] = {0, 0},
        ["battle/item"] = {-2, 0},
        ["battle/itemready"] = {0, 0},
        ["battle/defend"] = {-9, 0},

        ["battle/defeat"] = {0, 0},
        ["battle/hurt"] = {-9, 0},

        ["battle/intro"] = {-11, -7},
        ["battle/victory"] = {0, 0},

        ["battle_alt/idle"] = {-3, 0},
        ["battle_alt/defend"] = {-3, -6},
        ["battle_alt/hurt"] = {-3, 0},
        ["battle_alt/intro"] = {-11, -7},
        ["battle_alt/float"] = {-11, -7},
        ["battle_alt/pray"] = {-3, 0},
        ["battle_alt/spell_special"] = {-5, -1},
    }, false)
end

function actor:getAnimation(anim)
    -- If the weird route flag is set and an alt animation is defined, use it instead
    if Game:getPartyMember("noelle"):getFlag("weird", false) and self.animations_alt[anim] ~= nil then
        return self.animations_alt[anim] or nil
    else
        return super.getAnimation(self, anim)
    end
end

function actor:onSetAnimation(sprite, anim, keep_anim)
    if anim[1] == "battle_alt/pray" then
        local background = SnowglobeEffect(0, 0, false)
        local foreground = SnowglobeEffect(0, 0, true)
        sprite.parent:addChild(background)
        sprite.parent:addChild(foreground)
        background.layer = sprite.layer - 1
        foreground.layer = sprite.layer + 1
        background:setScale(0.5)
        foreground:setScale(0.5)
    end
end

return actor