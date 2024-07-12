local BossRushMenu, super = Class(Object)

function BossRushMenu:init()
    super.init(self, SCREEN_WIDTH / 2 - 480 / 2, SCREEN_HEIGHT / 2 - 320 / 2, 480, 320)

    self.parallax_x = 0
    self.parallax_y = 0

    self.draw_children_below = 0

    self.bg = UIBox(0, 0, self.width, self.height)
    self.bg.layer = -1
    self.bg.debug_select = false
    self:addChild(self.bg)

    self.font = Assets.getFont("main")
    self.font_2 = Assets.getFont("plain")

    self.ui_move = Assets.newSound("ui_move")
    self.ui_select = Assets.newSound("ui_select")
    self.ui_cant_select = Assets.newSound("ui_cant_select")
    self.ui_cancel_small = Assets.newSound("ui_cancel_small")

    self.up_sprite = Assets.getTexture("ui/page_arrow_up")
    self.down_sprite = Assets.getTexture("ui/page_arrow_down")
    self.soul = Assets.getTexture("player/heart")
    self.gradient = Assets.getTexture("ui/char_gradient")

    self.currently_selected = 1
    self.page = 1
    self.line_height = 30
    self.item_color_unk = {0.5, 0.5, 0.5}
    self.item_color = {1, 1, 1}

    -- preview is a table. First index is a sprite path, second is the X offset, third is the Y offset.
	-- encounters entries are tables. The first entry is a string of the boss ID, the second is a string of the boss name.
	-- party entries are strings of party member IDs. This is optional. (Remember to check for if you unlocked the member.)
	-- cf is the completion flag. It tells if the rush has been completed.
    -- Each page has room for 8 entries. Any more than that, and you'll either have text overlapping or text going off the UI box.
    self.encounters = {
        -- Page 1
        {
            {
				name = "Baby's First Rush",
				requirements = {"spamgolor_defeated","mimic_defeated","starwalker_defeated","sam_defeated","zero_defeated"},
				encounters = {{"spamgolor","Spamgolor"},{"mimicboss","Mimic"},{"starwalker","Starwalker"},{"sam","Sam"},{"zero","Zero"}},
				grad_color = {20/255, 60/255, 194/255},
				preview = {"world/npcs/spamgolor/idle", 70, 50},
				cf = "baby_rush",
				reward = 500
			},
            {
				name = "Jamm Rush",
				requirements = {"sam_defeated","jamm_closure","booty_finished","pauling_inparty","mario_obtained","!marcy_joined"},
				encounters = {{"sam","Sam"},{"ania_boss","Shade Ania"},{"big_booty","Booty"},{"eggman",Game:getFlag("jamm_rush") and "Eggman" or "???"}},
				party = {"pauling","jamm","mario"},
				grad_color = {92/255, 88/255, 188/255},
				preview = {"battle/enemies/shade_ania/idle", 75, 50},
				cf = "jamm_rush",
				reward = "bigsling"
			},
        },
    }
	
	self.rushes = {}
	
    for i, _ in ipairs(self.encounters) do
	    for n, j in ipairs(self.encounters[i]) do
			for k, v in ipairs(self.encounters[i][n]["requirements"]) do
				if v:sub(1, 1) == "!" then
					if not Game:getFlag(v:sub(2)) then
						table.insert(self.rushes, j)
					end
				else
					if Game:getFlag(v) then
						table.insert(self.rushes, j)
					end
				end
			end
	    end
    end

end

function BossRushMenu:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(self.font)
    love.graphics.printf("Boss Rushes", 0, 0, self.width, "center")

    local entry = self.encounters[self.page][self.currently_selected]
	
	local available = true
    for k, v in ipairs(entry["requirements"]) do
		if v:sub(1, 1) == "!" then
			if Game:getFlag(v:sub(2)) then
				available = false
				break
			end
		else
			if not Game:getFlag(v) then
				available = false
				break
			end
		end
	end
	
    if available then
	    love.graphics.setColor(entry.grad_color)
    end

    love.graphics.draw(self.gradient, 260, 50)

    if available then
	    love.graphics.setColor(1, 1, 1)
    else
        love.graphics.setColor(0, 0, 0)
    end
	
	if Game:getFlag(entry["cf"]) then
		love.graphics.setColor(0, 1, 0)
	else
		love.graphics.setColor(1, 1, 1)
	end
	love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", 260, 50, 200, 140)
	love.graphics.setColor(1, 1, 1)
	
	love.graphics.setFont(self.font_2)
	if entry["reward"] then
		if Game:getFlag(entry["cf"]) then
			love.graphics.printf("REWARD CLAIMED", 260, 318, 200, "left")
		else
			local reward_string = ""
			if type(entry["reward"]) == "number" then
				reward_string = entry["reward"] .. " D$"
			elseif type(entry["reward"]) == "string" then
				local item = Registry.createItem(entry["reward"])
				reward_string = item.name
			end
			love.graphics.printf("REWARD: " .. reward_string, 260, 318, 200, "left")
		end
	end

    if available and entry.preview then
        local preview = entry.preview
        love.graphics.draw(Assets.getTexture(preview[1]), 260 + preview[2], 50 + preview[3], 0, (entry.name == "Omega Spamton" and 1 or 2))
    end

    local y_off = 16

    love.graphics.setFont(self.font_2)
    love.graphics.setColor(1, 0, 0)
    love.graphics.draw(self.soul, 0, y_off + self.line_height * self.currently_selected)
    love.graphics.setColor(1, 1, 1)

    local line_x = 24
    local line_y = y_off + self.line_height * 1
    for m, encounter in ipairs(self.encounters[self.page]) do
		local available = true
		for k, v in ipairs(encounter["requirements"]) do
			if v:sub(1, 1) == "!" then
				if Game:getFlag(v:sub(2)) then
					available = false
					break
				end
			else
				if not Game:getFlag(v) then
					available = false
					break
				end
			end
		end
        if available or Game:getFlag(entry["cf"]) then
            love.graphics.setColor(unpack(self.item_color))
			if not available then
				love.graphics.setColor(unpack(self.item_color_unk))
			end
            love.graphics.print(encounter.name, line_x, line_y)
			if available then
				if m == self.currently_selected then
					local boss_string = ""
					for k, v in ipairs(encounter["encounters"]) do
						boss_string = boss_string .. v[2]
						if k ~= #encounter["encounters"] then
							boss_string = boss_string .. ", "
						end
					end
					love.graphics.printf("Bosses: " .. boss_string, 260, 192, 200, "left")
					if encounter["party"] then
						local party_string = ""
						for k, v in ipairs(encounter["party"]) do
							party_string = party_string .. Game:getPartyMember(v).name
							if k ~= #encounter["party"] then
								party_string = party_string .. ", "
							end
						end
						love.graphics.printf("Party: " .. party_string, 260, 256, 200, "left")
					end
				end
			end
        else
            love.graphics.setColor(unpack(self.item_color_unk))
            love.graphics.print(string.rep("?", utf8.len(encounter.name)), line_x, line_y)
			if m == self.currently_selected then
				love.graphics.printf("NOT UNLOCKED", 260, 192, 200, "center")
			end
        end
        love.graphics.setColor(1, 1, 1)
        line_y = line_y + self.line_height
    end

    love.graphics.setColor(1, 1, 1)
    if self.page > 1 then
        love.graphics.draw(self.up_sprite, 230, -10, 0, 1, 1)
    end
    if self.page < #self.encounters then
        love.graphics.draw(self.down_sprite, 230, 262, 0, 1, 1)
    end

    super.draw(self)
end

function BossRushMenu:onKeyPressed(key, is_repeat)
    if Input.isMenu(key) or Input.isCancel(key) then
        self.ui_cancel_small:stop()
        self.ui_cancel_small:play()
        Game.world:closeMenu()
        return
    end

    if Input.is("up", key) then
        if self.currently_selected > 1 then
            self.currently_selected = self.currently_selected - 1
            self.ui_move:stop()
            self.ui_move:play()
        elseif self.page > 1 then
        self.page = self.page - 1
        self.currently_selected = #self.encounters[self.page]
        self.ui_move:stop()
        self.ui_move:play()
        elseif not is_repeat then
            self.currently_selected = #self.encounters[self.page]
            self.ui_move:stop()
            self.ui_move:play()
        end
    end
    if Input.is("down", key) then
        if self.currently_selected < #self.encounters[self.page] then
            self.currently_selected = self.currently_selected + 1
            self.ui_move:stop()
            self.ui_move:play()
        elseif self.page < #self.encounters then
            self.currently_selected = 1
            self.page = self.page + 1
            self.ui_move:stop()
            self.ui_move:play()
        elseif not is_repeat then
            self.currently_selected = 1
            self.ui_move:stop()
            self.ui_move:play()
        end
    end
    if Input.pressed("confirm") then
        local entry = self.encounters[self.page][self.currently_selected]
		local available = true
		for k, v in ipairs(entry["requirements"]) do
			if v:sub(1, 1) == "!" then
				if Game:getFlag(v:sub(2)) then
					available = false
					break
				end
			else
				if not Game:getFlag(v) then
					available = false
					break
				end
			end
		end
        if available then
            self.ui_select:stop()
            self.ui_select:play()
			local temp = {}
			if entry["party"] then
				for k,v in pairs(Game.party) do
					temp[k] = v.id
				end
				Game.party = {}
				for i=1, #entry["party"] do
					local id = entry["party"][i]
					Game:addPartyMember(id)
				end
				Game.world.player:setActor(Game.party[1].actor)
			end
			Game.current_rush = entry["name"]
            Game.world:closeMenu()
			Game.world:startCutscene(function(cutscene)
				for i, v in ipairs(entry["encounters"]) do
					cutscene:text("* "..#entry["encounters"]-(i-1).." left to go.[wait:10]\n* Up next:[wait:5]"..v[2]..".")
					cutscene:startEncounter(v[1], true)
					while Game.battle do end
				end
				if entry["reward"] then
					if not Game:getFlag(entry["cf"]) then
						if type(entry["reward"]) == "number" then
							Game:setFlag(entry["cf"], true)
							cutscene:text("* Congratulations![wait:10] You win " .. entry["reward"] .. " D$!")
							Game.money = Game.money + entry["reward"]
						elseif type(entry["reward"]) == "string" then
							local item = Registry.createItem(entry["reward"])
							cutscene:text("* Congratulations![wait:10] You win " .. item.name .. "!")
							if Game.inventory:addItem(entry["reward"]) then
								Game:setFlag(entry["cf"], true)
							else
								cutscene:text("* But it didn't fit in your inventory...")
								cutscene:text("* Try clearing out some space,[wait:10] then try again!")
							end
						else
							error("Invalid type won in boss rush " .. entry["name"])
						end
					else
						cutscene:text("* Congratulations![wait:10] You win absolutely nothing!")
					end
				else
					cutscene:text("* Congratulations![wait:10] You win absolutely nothing!")
					Game:setFlag(entry["cf"], true)
				end
				if entry["party"] then
					Game.party = {}
					for i=1, #temp do
						local id = temp[i]
						Game:addPartyMember(id)
					end
					Game.world.player:setActor(Game.party[1].actor)
				end
				Game.current_rush = nil
			end)
        else
            self.ui_cant_select:stop()
            self.ui_cant_select:play()
        end
    end
end

function BossRushMenu:close()
    Game.world.menu = nil
    self:remove()
end

return BossRushMenu
