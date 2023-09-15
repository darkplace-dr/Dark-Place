local item, super = Class(Item, "sfb_key")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Blue Key"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "key"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = "It looks out\nof this world."
    -- Menu description
    self.description = "A key that open the way to a corrupted world.\nLooks like a key from a popular 16-bits game..."

    -- Default shop price (sell price is halved)
    self.price = 666
    -- Whether the item can be sold
    self.can_sell = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "world"
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
    self.reactions = {}
end

function item:onWorldUse()
    Game.world:startCutscene(function(cutscene)
        Assets.playSound("tada")

        local world_music = false
        if Game.world.music:isPlaying() and Game.world.music.volume > 0 then
            world_music = true
            Game.world.music:pause()
        end

        local leader = Game.world.player
        local key, og_facing
        if leader.actor.id == "YOU" or leader.actor.id == "kris" then
            leader:setSprite("hold_key")
        else
            og_facing = leader.facing
            leader:setFacing("down")
            key = Sprite("world/cutscenes/sfb_key")
            key:setOrigin(0.5, 1)
            key:setPosition(leader.width/2, 0)
            leader:addChild(key)
        end
        Input.clear("confirm")
        cutscene:wait(1/60) -- Wait for a frame so the confirm input from selecting the item doesn't affect the wait condition below
        cutscene:wait(function()
            return Input.pressed("confirm")
        end)
        leader:resetSprite()
        if key then
            leader:setFacing(og_facing)
            key:remove()
        end
        if world_music then
            Game.world.music:resume()
        end
    end)
end

function item:convertToLight(inventory)
    return "light/old_cartridge"
end

function item:getBuyPrice()
    return (self.buy_price or self:getPrice())*Mod:getPartyLove()
end

return item
