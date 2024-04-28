local item, super = Class(HealItem, "super_mushroom")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Super Shroom"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Biggifies\n& Heals\n40HP"
    -- Shop description
    self.shop = "Cool looking\nbiggifying\nmushroom\nHeals 40HP"
    -- Menu description
    self.description = "A red mushroom with eyes.\nBiggifies the user for this room. +40HP"

    -- Amount healed (HealItem variable)
    self.heal_amount = 40

    -- Default shop price (sell price is halved)
    self.price = 100
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {}
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {
        kris = {
            susie = "Heh, looking good Kris."
        },
        susie = {
            susie = "Let's crush everything!",
            noelle = "Your dream came true!"
        },
        ralsei = "Big hugs for everyone!",
        noelle = "(Will Susie like me more?)",
        brenda = "Mario.",
        dess = "Fuck yea!",
        YOU = {
            susie = "Heh, looking good YOU."
        },
		jamm = "if I was an Italian plumber whose girlfriend was constantly being imprisoned in castles by an evil fire breathing lizard I would simply not take part in recreational go-kart races with aforementioned lizard",
		mario = "Imma feel lightheaded! Wheeee!"
    }
end

function item:onWorldUse(target)
    Game.world:heal(target, self.heal_amount)
    self.map_id = Game.world.map.id
    Game.stage.timer:everyInstant(1/30, function()
        if self.map_id ~= Game.world.map.id then
            for i, party in ipairs(Game.party) do
                party:setFlag("super_mushroom", nil)
            end
            return false
        end
        for i, party in ipairs(Game.party) do
            if target == party then
                party:setFlag("super_mushroom", true)
                if i == 1 then
                    local player = Game.world.player
                    player.sprite:setScale(2)
                    player.sprite.x = -player.actor.width/2
                    player.sprite.y = -player.actor.height
                else
                    local follower = Game.world.followers[i-1]
                    follower.sprite:setScale(2)
                    follower.sprite.x = -follower.actor.width/2
                    follower.sprite.y = -follower.actor.height
                end
                if Game.battle then
                    Game.battle.party[i]:setScale(4)
                end
            end
        end
    end)
    Assets.playSound("mario_powerup")
end

function item:onBattleUse(user, target)
    target:heal(self.heal_amount)
    self.map_id = Game.world.map.id
    Game.stage.timer:everyInstant(1/30, function()
        if self.map_id ~= Game.world.map.id then
            for i, party in ipairs(Game.party) do
                party:setFlag("super_mushroom", nil)
            end
            return false
        end
        if Game.battle then
            for i, battler in ipairs(Game.battle.party) do
                if target == battler then
                    Game.party[i]:setFlag("super_mushroom", true)
                end
                if Game.party[i]:getFlag("super_mushroom") then
                    battler:setScale(4)
                    if i == 1 then
                        local player = Game.world.player
                        player.sprite:setScale(2)
                        player.sprite.x = -player.actor.width/2
                        player.sprite.y = -player.actor.height
                    else
                        local follower = Game.world.followers[i-1]
                        follower.sprite:setScale(2)
                        follower.sprite.x = -follower.actor.width/2
                        follower.sprite.y = -follower.actor.height
                    end
                end
            end
        end
    end)
    Assets.playSound("mario_powerup")
end

return item
