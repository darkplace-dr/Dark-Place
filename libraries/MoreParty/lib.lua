local Lib = {}

function Lib:init()
	Utils.hook(ActionBoxDisplay, 'draw', function(orig, self)
		if #Game.party <= 3 then orig(self) return end
		
		local parent = self.parent
		
		if Game.battle.current_selecting == self.actbox.index then
			love.graphics.setColor(self.actbox.battler.chara:getColor())
		else
			love.graphics.setColor(PALETTE["action_strip"], 1)
		end

		love.graphics.setLineWidth(2)
		love.graphics.line(2, Game:getConfig("oldUIPositions") and 2 or 1, parent.realWidth, Game:getConfig("oldUIPositions") and 2 or 1)

		love.graphics.setLineWidth(2)
		
		if Game.battle.current_selecting == self.actbox.index then
			love.graphics.line(1  , 0, 1,   36)
		end

		love.graphics.setColor(PALETTE["action_fill"])
		love.graphics.rectangle("fill", 2, Game:getConfig("oldUIPositions") and 3 or 2, parent.realWidth - 2, Game:getConfig("oldUIPositions") and 34 or 35)

		do
         local x = parent.realWidth
			if Game.battle.current_selecting == self.actbox.index then
				love.graphics.setColor(self.actbox.battler.chara:getColor())
            love.graphics.line(x, 0, x, 37)
			end
		end
		
		love.graphics.setColor(PALETTE["action_health_bg"])
		love.graphics.rectangle("fill", 118, 22 - self.actbox.data_offset, 39, 9)

		local health = (self.actbox.battler.chara.health / self.actbox.battler.chara:getStat("health")) * 39

		if health > 0 then
			love.graphics.setColor(self.actbox.battler.chara:getColor())
			love.graphics.rectangle("fill", 118, 22 - self.actbox.data_offset, math.ceil(health), 9)
		end

    local color = PALETTE["action_health_text"]
    if health <= 0 then
        color = PALETTE["action_health_text_down"]
    elseif (self.actbox.battler.chara:getHealth() <= (self.actbox.battler.chara:getStat("health") / 4)) then
        color = PALETTE["action_health_text_low"]
    else
        color = PALETTE["action_health_text"]
    end

		local health_offset = 0
		health_offset = (#tostring(self.actbox.battler.chara.health) - 1) * 8

		
		local x = parent.hp_sprite.x
		local string_width = self.font:getWidth(tostring(self.actbox.battler.chara:getStat("health")))
		
    love.graphics.setColor(color)
    love.graphics.setFont(self.font)
		love.graphics.print(self.actbox.battler.chara.health, 113 - health_offset, 9 - self.actbox.data_offset)
    love.graphics.setColor(PALETTE["action_health_text"])
		love.graphics.print("/", 121, 9 - self.actbox.data_offset)
    love.graphics.setColor(color)
		love.graphics.print(self.actbox.battler.chara:getStat("health"), 159 - string_width, 9 - self.actbox.data_offset)
      
      love.graphics.translate(-10, 0)
      
		Object.draw(self)
	end)
	
	Utils.hook(ActionBox, "drawActionBox", function(orig, self)
		if #Game.party <= 3 then orig(self) return end
		
		if Game.battle.current_selecting == self.index then
			love.graphics.setColor(self.battler.chara:getColor())
			love.graphics.setLineWidth(2)
			love.graphics.line(1  , 2, 1,   37)
			love.graphics.line(self.realWidth, 2, self.realWidth, 37)
			love.graphics.line(0  , 6, self.realWidth, 6 )
		end
		
		love.graphics.setColor(1, 1, 1, 1)
	end)
	
	Utils.hook(ActionBox, "drawSelectionMatrix", function(orig, self)
		if #Game.party <= 3 then orig(self) return end
		
		-- Draw the background of the selection matrix
		love.graphics.setColor(0, 0, 0, 1)
		love.graphics.rectangle("fill", 2, 2, self.realWidth, 35)

		if Game.battle.current_selecting == self.index then
   local r,g,b,a = self.battler.chara:getColor()

			for i = 0, 11 do
				local siner = self.selection_siner + (i * (10 * math.pi))

				love.graphics.setLineWidth(2)
				love.graphics.setColor(r, g, b, a * math.sin(siner / 60))
				if math.cos(siner / 60) < 0 then
					love.graphics.line(
						1 - (math.sin(siner / 60) * 30) + 30, 
						0,
						1 - (math.sin(siner / 60) * 30) + 30, 
						37
					)
						
					love.graphics.line(
						self.realWidth + (math.sin(siner / 60) * 30) - 30, 
						0, 
						self.realWidth + (math.sin(siner / 60) * 30) - 30, 
						37
					)
				end
			end

			love.graphics.setColor(1, 1, 1, 1)
		end
	end)
	
	Utils.hook(ActionBox, "update", function(orig, self)
		orig(self)
		
		if #Game.battle.party ~= 4 then return end
		
		local hp_sprite = self.hp_sprite
		
		if hp_sprite.x + 16 >= self.realWidth then
			hp_sprite.visible = false
		end
		
		local name_sprite = self.name_sprite
		
		if name_sprite and name_sprite.x + name_sprite.width >= self.realWidth then
			name_sprite.visible = false
		end
		local btn_types = {"fight", "act", "magic", "item", "spare", "defend"}
			
		if not self.battler.chara:hasAct() then Utils.removeFromTable(btn_types, "act") end
		if not self.battler.chara:hasSpells() then Utils.removeFromTable(btn_types, "magic") end

		for lib_id,_ in pairs(Mod.libs) do
			btn_types = Kristal.libCall(lib_id, "getActionButtons", self.battler, btn_types) or btn_types
		end
		btn_types = Kristal.modCall("getActionButtons", self.battler, btn_types) or btn_types

		local x = 16
		
		for i,v in ipairs(self.buttons) do
			v.visible = (Game.battle.current_selecting == self.index)
			v.x = x
			
			x = x + 32
		end
	end)
	
	Utils.hook(ActionBox, "init", function(orig, self, ...)
		orig(self, ...)

		if #Game.battle.party <= 3 then return end
		
		for i,v in ipairs(self.buttons) do
			v.visible = false
		end
	end)
	
	
	Utils.hook(ActionBox, "draw", function(orig, self, ...)
		orig(self, ...)
				
		if #Game.battle.party <= 4 then return end
			
		local buttons = self.buttons
		
		for i = 1, #buttons do
			local v = buttons[i]
			
			if v.hovered then
				love.graphics.push('all')
				love.graphics.translate(math.floor(self.realWidth * .5) - 16, v.y * .5)
				v:draw()
				
				local y = 26 * .5
				local prev = buttons[i - 1]
				
				-- if prev == nil then
					-- prev = buttons[#buttons]
				-- end
				
				if prev then
					love.graphics.push('all')
					love.graphics.scale(0.5, 0.5)
					love.graphics.translate(-34, y)
					prev:draw()
					love.graphics.pop()
				end
			
				local nex = buttons[i + 1]
				
				-- if nex == nil then
					-- nex = buttons[1]
				-- end
				
				if nex then
					love.graphics.push('all')
					love.graphics.scale(0.5, 0.5)
					love.graphics.translate(34 + (34 * .5) + (34 * .5), y)
					nex:draw()
					love.graphics.pop()
				end
				
				love.graphics.pop()
			end
		end
	end)
	
	Utils.hook(AttackBox, 'update', function(orig, self, ...)
      if #Game.battle.party <= 3 then return orig(self, ...) end
		
      if Game.battle.cancel_attack then
          self.fade_rect.alpha = Utils.approach(self.fade_rect.alpha, 1, DTMULT/20)
      end

      if not self.attacked then
          self.bolt:move(-AttackBox.BOLTSPEED * DTMULT, 0)

          self.afterimage_timer = self.afterimage_timer + DTMULT/2
          while math.floor(self.afterimage_timer) > self.afterimage_count do
              self.afterimage_count = self.afterimage_count + 1
              local afterimg = AttackBar(self.bolt_start_x - (self.afterimage_count * AttackBox.BOLTSPEED * 2), 0, 6, self.realHeight)
              afterimg.layer = 3
              afterimg.alpha = 0.4
              afterimg:fadeOutSpeedAndRemove()
              self:addChild(afterimg)
          end
      end

      if not Game.battle.cancel_attack and Input.pressed("confirm") then
          self.flash = 1
      else
          self.flash = Utils.approach(self.flash, 0, DTMULT/5)
      end

      Object.update(self)
	end)
	
	Utils.hook(AttackBox, 'draw', function(orig, self, ...)
		if #Game.party <= 3 then orig(self, ...) return end
		
		local target_color = {self.battler.chara:getAttackBarColor()}
		local box_color = {self.battler.chara:getAttackBoxColor()}

		if self.flash > 0 then
			box_color = Utils.lerp(box_color, {1, 1, 1}, self.flash)
		end

		love.graphics.setLineWidth(2)
		love.graphics.setLineStyle("rough")

		local h = (self.realHeight or 38) - 2
		
		love.graphics.setColor(box_color)
		love.graphics.rectangle("line", 80, 1, (15 * AttackBox.BOLTSPEED) + 3, h)
		love.graphics.setColor(target_color)
		love.graphics.rectangle("line", 83, 1, 8, h)

		love.graphics.setLineWidth(1)

		Object.draw(self)
	end)
	
	Utils.hook(BattleUI, "drawState", function(orig, self, ...)
		if #Game.party <= 3 then return orig(self, ...) end
		
		if not (Game.battle.state == "ATTACKING" or self.attacking) then
			return orig(self, ...)
		end
		
		local y = 40
		local h = (115 / #Game.battle.party)
		
		for _ = 1, (#Game.battle.party - 1) do
			love.graphics.setColor(PALETTE["battle_attack_lines"])
         y = y + h
         local b = 0
         if _ == 1 then
            b = 1
         end
			love.graphics.rectangle("fill", 79, y - b, 224, 2)
		end
	end)
	
	Utils.hook(BattleUI, "beginAttack", function(orig, self, ...)
		orig(self, ...)
		
		if #Game.party <= 3 then return end
		
		local h = (115 / #Game.battle.party)
		
		for k,v in ipairs(self.attack_boxes) do
			-- v.head_sprite:remove()
         v.head_sprite.height = h + 4
			v.bolt.height = h
			v.fade_rect.height = v.bolt.height
			v.realHeight = v.bolt.height
         local b
         local name = Game:getPartyMember(v.battler.chara.id)
         for i, z in ipairs(Game.party) do
           if z == name then
             b = i
             break -- break out of the loop once a match is found
           end
         end
			-- v:setScale(scale)
			v.y = 40 + (h * (b - 1))
		end
	end)
	
	Utils.hook(BattleUI, "init", function(orig, self, ...)
		orig(self, ...)
		
		if #Game.party <= 3 then return end
		
		local x = 0
		-- local w = ((108 * .5) + 212) * 2
		local realW = ((SCREEN_WIDTH - 1) / #Game.party)
		
		for k,v in ipairs(self.action_boxes) do
			v.x = x
			v.realWidth = realW
			x = x + realW
		end
	end)
	
	Utils.hook(Encounter, "getPartyPosition", function(orig, self, index)
		if #Game.battle.party <= 3 then
			return orig(self, index)
		end
		
		local x, y = 0, 0
		x = 80
		y = (140 / #Game.battle.party) + (((SCREEN_HEIGHT * .5) / #Game.battle.party) * (index - 1))

		local battler = Game.battle.party[index]
		local ox, oy = battler.chara:getBattleOffset()
		x = x + (battler.actor:getWidth()/2 + ox) * 2
		y = y + (battler.actor:getHeight()  + oy) * 2
		return x, y
	end)
	
	Utils.hook(Battle, "init", function(orig, self, ...)
		orig(self, ...)

		if #Game.party <= 3 then return end
		
		for i = 4, #Game.party do
			local party_member = Game.party[i]

			local found = false
			
			for _,follower in ipairs(Game.world.followers) do
				if follower.visible and follower.actor.id == party_member:getActor().id then
					local chara_x, chara_y = follower:getScreenPos()
					local chara_battler = PartyBattler(party_member, chara_x, chara_y)
					chara_battler:setAnimation("battle/transition")
					self:addChild(chara_battler)
					table.insert(self.party, chara_battler)
					table.insert(self.party_beginning_positions, {chara_x, chara_y})
					self.party_world_characters[party_member.id] = follower

					follower.visible = false

					found = true
					break
				end
			end
			
			if not found then
				local chara_battler = PartyBattler(party_member, SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
				chara_battler:setAnimation("transition")
				self:addChild(chara_battler)
				table.insert(self.party, chara_battler)
				table.insert(self.party_beginning_positions, {chara_battler.x, chara_battler.y})
			end
		end
	end)
   
   Utils.hook(DarkPowerMenu, 'init', function(orig, self, ...)
		orig(self, ...)
		if #Game.party <= 3 then return end
      
      self.party:setPosition(-15, 48)
   end)
   
   Utils.hook(DarkEquipMenu, 'init', function(orig, self, ...)
		orig(self, ...)
		if #Game.party <= 3 then return end
      
      self.party:setPosition(-15, 48)
   end)
   
   Utils.hook(OverworldActionBox, 'draw', function(orig, self)
		if #Game.party <= 3 then orig(self) return end
      
      local parent = self.parent
      
		local x = 0
		-- local w = ((108 * .5) + 212) * 2
		local realW = (SCREEN_WIDTH / #Game.party)
		
		for k,v in ipairs(parent.action_boxes) do
			v.x = x
			v.realWidth = realW
			x = x + realW
		end
      
		local string_width = self.font:getWidth(tostring(self.chara:getStat("health")))
		
		-- Draw the line at the top
      
      if self.selected then
          love.graphics.setColor(self.chara:getColor())
      else
          love.graphics.setColor(PALETTE["action_strip"])
      end

      love.graphics.setLineWidth(2)
      love.graphics.line(0, 1, 213, 1)
      
      -- Draw health
      love.graphics.setColor(PALETTE["action_health_bg"])
      love.graphics.rectangle("fill", 118, 24, 39, 9)

      local health = (self.chara.health / self.chara:getStat("health")) * 39

      if health > 0 then
          love.graphics.setColor(self.chara:getColor())
          love.graphics.rectangle("fill", 118, 24, math.ceil(health), 9)
      end

      local color = PALETTE["action_health_text"]
      if health <= 0 then
          color = PALETTE["action_health_text_down"]
      elseif (self.chara:getHealth() <= (self.chara:getStat("health") / 4)) then
          color = PALETTE["action_health_text_low"]
      else
          color = PALETTE["action_health_text"]
      end

      local health_offset = 0
      health_offset = (#tostring(self.chara.health) - 1) * 8


      love.graphics.setColor(color)
      love.graphics.setFont(self.font)
      love.graphics.print(self.chara.health, 113 - health_offset, 11)
      love.graphics.setColor(PALETTE["action_health_text"])
      love.graphics.print("/", 121, 11)
      love.graphics.setColor(color)
      love.graphics.print(self.chara:getStat("health"), 159 - string_width, 11)

      -- Draw name text if there's no sprite
      if not self.name_sprite then
          local font = Assets.getFont("name")
          love.graphics.setFont(font)
          love.graphics.setColor(1, 1, 1, 1)

          local name = self.chara:getName():upper()
          local spacing = 5 - name:len()

          local off = 0
          for i = 1, name:len() do
              local letter = name:sub(i, i)
              love.graphics.print(letter, 51 + off, 16 - 1)
              off = off + font:getWidth(letter) + spacing
          end
      end

      local reaction_x = -1

      if self.x == 0 then -- lazy check for leftmost party member
          reaction_x = 3
      end

      love.graphics.setFont(self.main_font)
      love.graphics.setColor(1, 1, 1, self.reaction_alpha / 6)
      love.graphics.print(self.reaction_text, reaction_x, 43, 0, 0.5, 0.5)
      
      love.graphics.translate(-10, 0)

		Object.draw(self)
	end)
   
   Utils.hook(Shop, 'draw', function(orig, self)
		if #Game.party <= 3 then orig(self) return end
      
      self:drawBackground()

      Object.draw(self)

      love.graphics.setFont(self.font)
      if self.state == "MAINMENU" then
          love.graphics.setColor(COLORS.white)
          for i = 1, #self.menu_options do
              love.graphics.print(self.menu_options[i][1], 480, 220 + (i * 40))
          end
          love.graphics.setColor(Game:getSoulColor())
          love.graphics.draw(self.heart_sprite, 450, 230 + (self.main_current_selecting * 40))
      elseif self.state == "BUYMENU" then

          while self.current_selecting - self.item_offset > 5 do
              self.item_offset = self.item_offset + 1
          end

          while self.current_selecting - self.item_offset < 1 do
              self.item_offset = self.item_offset - 1
          end

          if self.item_offset + 5 > #self.items + 1 then
              if #self.items + 1 > 5 then
                  self.item_offset = self.item_offset - 1
              end
          end

          if #self.items + 1 == 5 then
              self.item_offset = 0
          end

          -- Item type (item, key, weapon, armor)
          for i = 1 + self.item_offset, self.item_offset + math.max(4, math.min(5, #self.items)) do
              if i == math.max(4, #self.items) + 1 then break end
              local y = 220 + ((i - self.item_offset) * 40)
              local item = self.items[i]
              if not item then
                  -- If the item is null, add some empty space
                  love.graphics.setColor(COLORS.dkgray)
                  love.graphics.print("--------", 60, y)
              elseif item.options["stock"] and (item.options["stock"] <= 0) then
                  -- If we've depleted the stock, show a "sold out" message
                  love.graphics.setColor(COLORS.gray)
                  love.graphics.print("--SOLD OUT--", 60, y)
              else
                  love.graphics.setColor(item.options["color"])
                  love.graphics.print(item.options["name"], 60, y)
                  if not self.hide_price then
                      love.graphics.setColor(COLORS.white)
                      love.graphics.print(string.format(self.currency_text, item.options["price"] or 0), 60 + 240, y)
                  end
              end
          end
          love.graphics.setColor(COLORS.white)
          if self.item_offset == math.max(4, #self.items) - 4 then
              love.graphics.print("Exit", 60, 220 + (math.max(4, #self.items) + 1 - self.item_offset) * 40)
          end
          love.graphics.setColor(Game:getSoulColor())
          if not self.buy_confirming then
              love.graphics.draw(self.heart_sprite, 30, 230 + ((self.current_selecting - self.item_offset) * 40))
          else
              love.graphics.draw(self.heart_sprite, 30 + 420, 230 + 80 + 10 + (self.current_selecting_choice * 30))
              love.graphics.setColor(COLORS.white)
              local lines = Utils.split(string.format(self.buy_confirmation_text, string.format(self.currency_text, self.items[self.current_selecting].options["price"] or 0)), "\n")
              for i = 1, #lines do
                  love.graphics.print(lines[i], 60 + 400, 420 - 160 + ((i - 1) * 30))
              end
              love.graphics.print("Yes", 60 + 420, 420 - 80)
              love.graphics.print("No",  60 + 420, 420 - 80 + 30)
          end
          love.graphics.setColor(COLORS.white)

          if (self.current_selecting <= #self.items) then
              local current_item = self.items[self.current_selecting]
              local box_left, box_top = self.info_box:getBorder()

              local left = self.info_box.x - self.info_box.width - (box_left / 2) * 1.5
              local top = self.info_box.y - self.info_box.height - (box_top / 2) * 1.5
              local width = self.info_box.width + box_left * 1.5
              local height = self.info_box.height + box_top * 1.5

              Draw.pushScissor()
              Draw.scissor(left, top, width, height)

              love.graphics.setColor(COLORS.white)
              love.graphics.print(current_item.options["description"], left + 32, top + 20)

              if current_item.item.type == "armor" or current_item.item.type == "weapon" then
                  for i = 1, #Game.party do
                      local offset_x = 0
                      local offset_y = 0
                      -- TODO: more than 3 party member support (Now supports 4)
                      if i == 1 then
                          offset_x = 0
                          offset_y = 0
                      elseif i == 2 then
                          offset_x = 100
                          offset_y = 0
                      elseif i == 3 then
                          offset_x = 0
                          offset_y = 45
                      elseif i == 4 then
                          offset_x = 100
                          offset_y = 45
                      end
                      local party_member = Game.party[i]
                      local can_equip = party_member:canEquip(current_item.item)
                      local head_path = ""

                      love.graphics.setFont(self.plain_font)
                      love.graphics.setColor(COLORS.white)

                      if can_equip then
                          head_path = Assets.getTexture(party_member:getHeadIcons() .. "/head")
                          if current_item.item.type == "armor" then
                              love.graphics.draw(self.stat_icons["defense_1"], offset_x + 470, offset_y + 127 + top)
                              love.graphics.draw(self.stat_icons["defense_2"], offset_x + 470, offset_y + 147 + top)

                              for j = 1, 2 do
                                  self:drawBonuses(party_member, party_member:getArmor(j), current_item.options["bonuses"], "defense", offset_x + 470 + 21, offset_y + 127 + ((j - 1) * 20) + top)
                              end

                          elseif current_item.item.type == "weapon" then
                              love.graphics.draw(self.stat_icons["attack"], offset_x + 470, offset_y + 127 + top)
                              love.graphics.draw(self.stat_icons["magic" ], offset_x + 470, offset_y + 147 + top)
                              self:drawBonuses(party_member, party_member:getWeapon(), current_item.options["bonuses"], "attack", offset_x + 470 + 21, offset_y + 127 + top)
                              self:drawBonuses(party_member, party_member:getWeapon(), current_item.options["bonuses"], "magic",  offset_x + 470 + 21, offset_y + 147 + top)
                          end
                      else
                          head_path = Assets.getTexture(party_member:getHeadIcons() .. "/head_error")
                      end

                      love.graphics.draw(head_path, offset_x + 426, offset_y + 132 + top)
                  end
              end

              Draw.popScissor()

              love.graphics.setColor(COLORS.white)

              if not self.hide_storage_text then
                  love.graphics.setFont(self.plain_font)

                  local current_storage = Game.inventory:getDefaultStorage(current_item.item)
                  local space = Game.inventory:getFreeSpace(current_storage)

                  if space <= 0 then
                      love.graphics.print("NO SPACE", 521, 430)
                  else
                      love.graphics.print("Space:" .. space, 521, 430)
                  end
              end
          end
      elseif self.state == "SELLMENU" then
          love.graphics.setColor(Game:getSoulColor())
          love.graphics.draw(self.heart_sprite, 50, 230 + (self.sell_current_selecting * 40))
          love.graphics.setColor(COLORS.white)
          love.graphics.setFont(self.font)
          for i, v in ipairs(self.sell_options) do
              love.graphics.print(v[1], 80, 220 + (i * 40))
          end
          love.graphics.print("Return", 80, 220 + ((#self.sell_options + 1) * 40))
      elseif self.state == "SELLING" then
          if self.item_current_selecting - self.item_offset > 5 then
              self.item_offset = self.item_offset + 1
          end

          if self.item_current_selecting - self.item_offset < 1 then
              self.item_offset = self.item_offset - 1
          end

          local inventory = Game.inventory:getStorage(self.state_reason[2])

          if inventory and inventory.sorted then
              if self.item_offset + 5 > #inventory then
                  if #inventory > 5 then
                      self.item_offset = self.item_offset - 1
                  end
              end
              if #inventory == 5 then
                  self.item_offset = 0
              end
          end

          love.graphics.setColor(Game:getSoulColor())

          love.graphics.draw(self.heart_sprite, 30, 230 + ((self.item_current_selecting - self.item_offset) * 40))
          if self.sell_confirming then
              love.graphics.draw(self.heart_sprite, 30 + 420, 230 + 80 + 10 + (self.current_selecting_choice * 30))
              love.graphics.setColor(COLORS.white)
              local lines = Utils.split(string.format(self.sell_confirmation_text, string.format(self.currency_text, inventory[self.item_current_selecting]:getSellPrice())), "\n")
              for i = 1, #lines do
                  love.graphics.print(lines[i], 60 + 400, 420 - 160 + ((i - 1) * 30))
              end
              love.graphics.print("Yes", 60 + 420, 420 - 80)
              love.graphics.print("No",  60 + 420, 420 - 80 + 30)
          end

          love.graphics.setColor(COLORS.white)

          if inventory then
              for i = 1 + self.item_offset, self.item_offset + math.min(5, inventory.max) do
                  local item = inventory[i]
                  love.graphics.setFont(self.font)

                  if item then
                      love.graphics.setColor(COLORS.white)
                      love.graphics.print(item:getName(), 60, 220 + ((i - self.item_offset) * 40))
                      if item:isSellable() then
                          love.graphics.print(string.format(self.currency_text, item:getSellPrice()), 60 + 240, 220 + ((i - self.item_offset) * 40))
                      end
                  else
                      love.graphics.setColor(COLORS.dkgray)
                      love.graphics.print("--------", 60, 220 + ((i - self.item_offset) * 40))
                  end
              end

              local max = inventory.max
              if inventory.sorted then
                  max = #inventory
              end

              love.graphics.setColor(COLORS.white)

              if max > 5 then

                  for i = 1, max do
                      local percentage = (i - 1) / (max - 1)
                      local height = 129

                      local draw_location = percentage * height

                      local tocheck = self.item_current_selecting
                      if self.sell_confirming then
                          tocheck = self.current_selecting_choice
                      end

                      if i == tocheck then
                          love.graphics.rectangle("fill", 372, 292 + draw_location, 9, 9)
                      elseif inventory.sorted then
                          love.graphics.rectangle("fill", 372 + 3, 292 + 3 + draw_location, 3, 3)
                      end
                  end

                  -- Draw arrows
                  if not self.sell_confirming then
                      local sine_off = math.sin((Kristal.getTime()*30)/6) * 3
                      if self.item_offset + 4 < (max - 1) then
                          love.graphics.draw(self.arrow_sprite, 370, 149 + sine_off + 291)
                      end
                      if self.item_offset > 0 then
                          love.graphics.draw(self.arrow_sprite, 370, 14 - sine_off + 291 - 25, 0, 1, -1)
                      end
                  end
              end
          else
              love.graphics.print("Invalid storage", 60, 220 + (1 * 40))
          end
      elseif self.state == "TALKMENU" then
          love.graphics.setColor(Game:getSoulColor())
          love.graphics.draw(self.heart_sprite, 50, 230 + (self.current_selecting * 40))
          love.graphics.setColor(COLORS.white)
          love.graphics.setFont(self.font)
          for i = 1, math.max(4, #self.talks) do
              local v = self.talks[i]
              if v then
                  love.graphics.setColor(v[2].color)
                  love.graphics.print(v[1], 80, 220 + (i * 40))
              else
                  love.graphics.setColor(COLORS.dkgray)
                  love.graphics.print("--------", 80, 220 + (i * 40))
              end
          end
          love.graphics.setColor(COLORS.white)
          love.graphics.print("Exit", 80, 220 + ((math.max(4, #self.talks) + 1) * 40))
      end

      if self.state == "MAINMENU" or
         self.state == "BUYMENU"  or
         self.state == "SELLMENU" or
         self.state == "SELLING"  or
         self.state == "TALKMENU" then
          love.graphics.setColor(COLORS.white)
          love.graphics.setFont(self.font)
          love.graphics.print(string.format(self.currency_text, self:getMoney()), 440, 420)
      end

      love.graphics.setColor(0, 0, 0, self.fade_alpha)
      love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
     end)
	
	print("Loaded MoreParty")
end

return Lib

-- Debug Stuff

-- local keysString = ""
-- for key, value in pairs(parent) do
  -- keysString = keysString .. key .. " "
-- end
-- error(keysString)