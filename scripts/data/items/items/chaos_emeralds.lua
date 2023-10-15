-- Instead of Item, create a HealItem, a convenient class for consumable healing items
local item, super = Class(Item, "chaos_emeralds")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Emeralds"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Chaos\nEnergy"
    -- Shop description
    self.shop = "Chaos\nEnergy"
    -- Menu description
    self.description = "For 50% TP, you can turn super for the battle!"

    -- Amount healed (HealItem variable)
    self.heal_amount = 1

    -- Default shop price (sell price is halved)
    self.price = 0
    -- Whether the item can be sold
    self.can_sell = false
	
	self.refundable = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "party"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "battle"
    -- Item this item will get turned into when consumed
    self.result_item = "chaos_emeralds"
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

function item:getBattleText(user, target)
	if Game.battle.superpower then
		return "* They won't do you any more good for now."
	end
    return "* "..user.chara:getName().." used the Chaos Emeralds!"
end

function item:onBattleUse(user, target)
	if Game.tension >= 50 then
		if not Game.battle.superpower then
			print("Super Kris")
			
			Assets.playSound("super", 1, 1)
			
			local fade_rect = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
			fade_rect:setColor(1, 1, 1, 0)
			fade_rect.layer = BATTLE_LAYERS["above_battlers"]
			Game.battle:addChild(fade_rect)
			
			Game.battle.timer:tween(0.25, fade_rect, {alpha = 1}, "linear", function()
				Game.battle.superpower = true
				Game.battle.timer:tween(0.25, fade_rect, {alpha = 0}, "linear", function()
					fade_rect:remove()
					Game.battle.music:play("undefeatable")
				end)
			end)
		end
	end
end

function item:onToss()
    Game.world:showText("* The Chaos Emeralds can't be thrown away.")
    return false
end

return item