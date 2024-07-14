local DarkMenu, super = Class(DarkMenu)

function DarkMenu:addButtons()
	if Game:getFlag("tutorial_terry_1") and Game.world.map.id:sub(1,9) == "cardworld" then
		-- CARDS
		self:addButton({
			["state"]          = "CARDMENU",
			["sprite"]         = Assets.getTexture("ui/menu/btn/card"),
			["hovered_sprite"] = Assets.getTexture("ui/menu/btn/card_h"),
			["desc_sprite"]    = Assets.getTexture("ui/menu/desc/cards"),
			["callback"]       = function()
				self.box = DarkItemMenu() -- Temporary, until I make a menu
				self.box.layer = 1
				self:addChild(self.box)
		
				self.ui_select:stop()
				self.ui_select:play()
			end
		})

		-- EQUIP
		self:addButton({
			["state"]          = "EQUIPMENU",
			["sprite"]         = Assets.getTexture("ui/menu/btn/equip"),
			["hovered_sprite"] = Assets.getTexture("ui/menu/btn/equip_h"),
			["desc_sprite"]    = Assets.getTexture("ui/menu/desc/equip"),
			["callback"]       = function()
				self.box = DarkEquipMenu()
				self.box.layer = 1
				self:addChild(self.box)
		
				self.ui_select:stop()
				self.ui_select:play()
			end
		})

		-- POWER
		self:addButton({
			["state"]          = "POWERMENU",
			["sprite"]         = Assets.getTexture("ui/menu/btn/power"),
			["hovered_sprite"] = Assets.getTexture("ui/menu/btn/power_h"),
			["desc_sprite"]    = Assets.getTexture("ui/menu/desc/power"),
			["callback"]       = function()
				self.box = DarkPowerMenu()
				self.box.layer = 1
				self:addChild(self.box)
		
				self.ui_select:stop()
				self.ui_select:play()
			end
		})

		-- CONFIG
		self:addButton({
			["state"]          = "CONFIGMENU",
			["sprite"]         = Assets.getTexture("ui/menu/btn/config"),
			["hovered_sprite"] = Assets.getTexture("ui/menu/btn/config_h"),
			["desc_sprite"]    = Assets.getTexture("ui/menu/desc/config"),
			["callback"]       = function()
				self.box = DarkConfigMenu()
				self.box.layer = -1
				self:addChild(self.box)
		
				self.ui_select:stop()
				self.ui_select:play()
			end
		})
	else
		super.addButtons(self)
	end
end

return DarkMenu