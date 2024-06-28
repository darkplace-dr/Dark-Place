local item, super = Class(Item, "angelring")

function item:init()
    super.init(self)

    -- Display name
    self.name = "AngelRing"

    -- Item type (item, key, weapon, armor)
    self.type = "weapon"
    -- Item icon (for equipment)
    self.icon = "ui/menu/icon/ring"

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A faintly glowing ring with a floating halo.\nCan only be wore by those linked to angels."

    -- Default shop price (sell price is halved)
    self.price = 2000
    -- Whether the item can be sold
    self.can_sell = true
    self.sell_price = 150

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {
        attack = 12,
        magic  = 10,
    }
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = "Holy"
    self.bonus_icon = "ui/menu/icon/ring"

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {
        noelle = true,
        kangel = true
    }

    -- Character reactions
    self.reactions = {
        susie = "Nah, that's too shiny.",
        berdly = "Useless for me!",
        dess = "nah I'm yuor devil",
        mario = {
            mario = "ooooh food :D",
            susie = "DON'T EAT THAT!!",
            noelle = "DON'T EAT THAT!!",
            berdly = "DON'T EAT THAT!!",
            jamm = "DON'T EAT THAT!!",
            brenda = "DON'T EAT THAT!!",
            kangel = "DON'T EAT THAT!!",
            noel = "WHY IS EVERYONE YELLING?!",
            dess = "lol",
        },
        brenda = "A ring... for a ring?",
        noel = "Angel... no thanks...",
        noelle = "It's beautiful...!",
        kangel = "It goes with my outfit!"
    }
end

function item:getReaction(user_id, reactor_id)
    if user_id == "mario" and reactor_id == "mario" then
        local dess_party = Utils.containsValue(Game.party, Game:getPartyMember("dess"))
        if dess_party then
            local yummy = true
            for i,member in ipairs(Game.party) do
                if member.id ~= "dess" or member.id ~= "mario" then
                    yummy = false
                    break
                end
            end
            if yummy then
                print(Game.inventory:removeItem(self))
                Game.world:heal(user_id, 10)
            end
        end
    end
    return super:getReaction(self, user_id, reactor_id)
end

return item