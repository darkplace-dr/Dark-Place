local item, super = Class(Item, "punchcard")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Punch Card"
    -- Name displayed when used in battle (optional)
    self.use_name = nil

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = ""
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "This card packs a kick! Sometimes a punch.\nIt might be broken, but that's just a hunch."

    -- Default shop price (sell price is halved)
    self.price = 1000
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "none"
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
    self.reactions = {}
end

function item:onWorldUse()
    Mod.punch_speedrun = true
    Game.world:startCutscene(function(cutscene)

        local card = Sprite("objects/punchcard_ribbit", 328, 270)
        card:setScale(2)
        card:setOrigin(0.5, 0.5)
        card:setLayer(9999)
        card.parallax_x = 0
        card.parallax_y = 0

        local leader = Game.world.player
		
        if leader.actor.id == "YOU" or leader.actor.id == "robo_susie" or leader.actor.id == "noyno" then
            card:setSprite("objects/punchcard_ribbit")
            Game.world:addChild(card)
        else
            card:setSprite("objects/punchcard_ut")
            Game.world:addChild(card)
        end

        Input.clear("confirm")
        cutscene:enableMovement()
        Mod.glitch_timer = Game.world.timer:after((1/60)*4, function() cutscene:disableMovement() end)
        cutscene:wait(1/60) -- Wait for a frame so the confirm input from selecting the item doesn't affect the wait condition below
        cutscene:wait(function()
            return Input.pressed("confirm")
        end)
        if card then
            card:remove()
        end
        Mod.punch_speedrun = false
    end)
    return false
end

return item
