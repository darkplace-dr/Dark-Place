local DarkPartyMenu, super = Class(Object)

function DarkPartyMenu:init(debug)
    super.init(self, 82, 112, 477, 277)

    self.draw_children_below = 0

    self.font = Assets.getFont("main")

    self.ui_move = Assets.newSound("ui_move")
    self.ui_select = Assets.newSound("ui_select")
    self.ui_cant_select = Assets.newSound("ui_cant_select")
    self.ui_cancel_small = Assets.newSound("ui_cancel_small")

    self.heart_sprite = Assets.getTexture("player/heart")

	self.parallax_x = 0
    self.parallax_y = 0
    self.layer = WORLD_LAYERS["ui"]

    self.bg = UIBox(0, 0, self.width, self.height)
    self.bg.layer = -1
    self.bg.debug_select = false
    self:addChild(self.bg)

    -- MAIN, SELECT
    self.state = "MAIN"

    self.selected_x = 1
	self.selected_y = 1
	
	self.selected_party = 1
	
	self.list = {
		{"kris", "susie", "noelle", "berdly", "ostarwalker", "YOU", "robo_susie", "noyno", "pauling", "eusei"},
		{"frisk2", "dess", "alseri", "brenda", "jamm", "bor", "dumbie", "iphone", "mario", "ceroba"},
		{"clover", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown"},
	}
	
	self.listreference = Game:getFlag("party", {"YOU", "susie"})
	
	for i,list in ipairs(self.list) do
		for i2,entry in ipairs(list) do
			if not debug then
				if not self:hasValue(self.listreference, entry) then
					self.list[i][i2] = "unknown"
				end
			end
		end
	end
end

function DarkPartyMenu:hasValue(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function DarkPartyMenu:close()
    Game.world.menu = nil
    self:remove()
end

function DarkPartyMenu:onKeyPressed(key)
	if self.state == "MAIN" then
		if Input.pressed("right") then
			if self.selected_party < Game:getFlag("party_max") and self.selected_party <= #Game.party then
                self.ui_move:stop()
                self.ui_move:play()
                self.selected_party = self.selected_party + 1
			end
		end
		if Input.pressed("left") then
			if self.selected_party > 1 then
                self.ui_move:stop()
                self.ui_move:play()
				self.selected_party = self.selected_party - 1
			end
		end
		if Input.pressed("confirm") then
			if not Game:getFlag("party_lock_" .. self.selected_party) then
                self.ui_select:stop()
                self.ui_select:play()
				self.state = "SELECT"
			end
		end
		if Input.pressed("cancel") then
            self.ui_cancel_small:stop()
            self.ui_cancel_small:play()
            Game.world:closeMenu()
            return
        end
		if Input.pressed("menu") then
			if self.selected_party == 1 or Game.party[self.selected_party] == nil or self.selected_party < #Game.party then
				self.ui_cant_select:stop()
				self.ui_cant_select:play()
			else
				self.ui_cancel_small:stop()
            	self.ui_cancel_small:play()
				if Game.world.followers[self.selected_party-1] then
					Game.world.followers[self.selected_party-1]:remove()
                end
				Game.party[self.selected_party] = nil
			end
		end
		if Input.pressed("v") then
			-- Step 1: Set the list
			local temp = {}
			for k,v in pairs(Game:getFlag("party", {"YOU", "susie"})) do
				temp[k] = v
			end
		
			-- Step 2: Remove every party member
			Game.party = {}
			
			-- Step 3: Set all available slots to random
			local val = math.min(#self.listreference, Game:getFlag("party_max"))
			local indexes = Utils.pickMultiple(temp, val)
			for i=1, #indexes do
				local id = indexes[i]
				Game:addPartyMember(id)
			end
			
			-- Step 4: Set all followers
            for i, follower in ipairs(Game.world.followers) do
                follower:remove()
            end
			Game.world.player:setActor(Game.party[1].actor)
			for k,v in pairs(Game.party) do
				if k > 1 then
					Game.world:spawnFollower(v:getActor())
				end
			end
			Game.world.player:alignFollowers()
			Game.world:attachFollowersImmediate()
		end
	elseif self.state == "SELECT" then
		if Input.pressed("confirm") then
			if self.list[self.selected_y][self.selected_x] ~= "unknown" then
				for index,party in pairs(Game.party) do
					if party.id == self.list[self.selected_y][self.selected_x] then
                        self.ui_cant_select:stop()
                        self.ui_cant_select:play()
                        return
                    end
				end
				Game.party[self.selected_party] = Game:getPartyMember(self.list[self.selected_y][self.selected_x])
				Game:setFlag(self.list[self.selected_y][self.selected_x].."_party", true)
				--[[for k,v in pairs(Game.world.healthbar.action_boxes) do
					v:remove()
				end]]
				if self.selected_party > 1 then
					if Game.world.followers[self.selected_party-1] then
						Game.world.followers[self.selected_party-1]:setActor(Game.party[self.selected_party]:getActor())
					else
						local follower = Game.world:spawnFollower(self.list[self.selected_y][self.selected_x])
						follower:setActor(Game.party[self.selected_party]:getActor())
						follower:setFacing("down")
					end
				else
					Game.world.player:setActor(Game.party[1]:getActor())
				end
                self.ui_select:stop()
                self.ui_select:play()
				--Game.world.menu:updateSelectedBoxes()
				self.state = "MAIN"
				self.selected_x = 1
				self.selected_y = 1
			else
                self.ui_cant_select:stop()
                self.ui_cant_select:play()
			end
		end
		if Input.pressed("right") then
			if self.selected_x < 10 then
                self.ui_move:stop()
                self.ui_move:play()
				self.selected_x = self.selected_x + 1
			end
		end
		if Input.pressed("left") then
			if self.selected_x > 1 then
                self.ui_move:stop()
                self.ui_move:play()
				self.selected_x = self.selected_x - 1
			end
		end
		if Input.pressed("down") then
			if self.selected_y < 2 then
                self.ui_move:stop()
                self.ui_move:play()
				self.selected_y = self.selected_y + 1
			end
		end
		if Input.pressed("up") then
			if self.selected_y > 1 then
                self.ui_move:stop()
                self.ui_move:play()
				self.selected_y = self.selected_y - 1
			end
		end
		if Input.pressed("cancel") then
            self.ui_cancel_small:stop()
            self.ui_cancel_small:play()
			self.state = "MAIN"
			self.selected_x = 1
			self.selected_y = 1
        end
	end
end

function DarkPartyMenu:update()
    for i = 1, #self.list do
        for index,party in pairs(self.list[i]) do
            if party ~= "unknown" then
                Game:setFlag(party.."_party", false)
            end
        end
    end
    for index,party in pairs(Game.party) do
        Game:setFlag(party.id.."_party", true)
    end
    super.update(self)
end

function DarkPartyMenu:draw()
	love.graphics.printf("PARTY", 0, 0, self.bg.width, "center")
	if self.state == "MAIN" then
		love.graphics.printf("["..Input.key_bindings["menu"][1]:upper().."] REMOVE", 185, -20, self.bg.width, "center")
		love.graphics.printf("[V] RANDOM", 185, 12, self.bg.width, "center")
	end
	
    local x = 9 + (8 - Game:getFlag("party_max")) * 30
    for i=1,Game:getFlag("party_max") do
        love.graphics.setColor(1, 1, 1)
        local path = "ui/menu/party/head"
        if Game.party[i] then
            path = Game.party[i].menu_icon
        end
        local sprite = Assets.getTexture(path)
        local width  = sprite:getWidth()
        x = x + 60
        love.graphics.draw(sprite, x, 35, 0, 2, 2, 11*width/8, 0.5)
        if self.selected_party == i then
            love.graphics.setColor(1, 0, 0)
            love.graphics.draw(self.heart_sprite, x - 51, 80, 0, 1, 1, 0.5, 0.5)
        end
    end
	
	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle("fill", -20, 100, 517, 4)
	
	for i,list in ipairs(self.list) do
		for i2,entry in ipairs(list) do
			local path = "ui/menu/party/" .. entry
			if self.state == "SELECT" and i == self.selected_y and i2 == self.selected_x then
				path = "ui/menu/party/" .. entry .. "_h"
			end
			local sprite = Assets.getTexture(path)
			love.graphics.draw(sprite, i2*45 - 27, i*40 + 100)
		end
	end

    super.draw(self)
end

return DarkPartyMenu