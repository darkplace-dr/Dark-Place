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
		{"YOU", "kris", "susie", "noelle", "dess", "brandon", "dumbie", "ostarwalker", "berdly", "bor"},
		{"robo_susie", "noyno", "iphone", "frisk2", "alseri", "jamm", "unknown", "unknown", "unknown", "unknown"},
		--{"unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown"},
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
			if self.selected_party < 4 then
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
			self:reorderParty()
            Game.world:closeMenu()
            return
        end
		if Input.pressed("menu") then
			if self.selected_party == 1 or Game.party[self.selected_party] == nil then
				self.ui_cant_select:stop()
				self.ui_cant_select:play()
			else
				self.ui_cancel_small:stop()
            	self.ui_cancel_small:play()
				Game:setFlag(Game.party[self.selected_party].id.."_party", false)
				 if Game.world.followers[self.selected_party-1] then
					Game.world.followers[self.selected_party-1]:remove()
				 end
				Game.party[self.selected_party] = nil
			end
		end
	elseif self.state == "SELECT" then
		if Input.pressed("confirm") then
			if self.list[self.selected_y][self.selected_x] ~= "unknown" then
				for index,party in pairs(Game.party) do
					if index == self.selected_party then
						Game:setFlag(party.id.."_party", false)
					end
					if party.id == self.list[self.selected_y][self.selected_x] then return end
				end
				Game.party[self.selected_party] = Game:getPartyMember(self.list[self.selected_y][self.selected_x])
				Game:setFlag(self.list[self.selected_y][self.selected_x].."_party", true)
				--[[for k,v in pairs(Game.world.healthbar.action_boxes) do
					v:remove()
				end]]
				if self.selected_party > 1 then
					if Game.world.followers[self.selected_party-1] then
						Game.world.followers[self.selected_party-1]:setActor(Game.party[self.selected_party].actor)
					else
						local follower = Game.world:spawnFollower(self.list[self.selected_y][self.selected_x])
						follower:setFacing("down")
					end
				else
					Game.world.player:setActor(Game.party[1].actor)
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

    super.update(self)
end

function DarkPartyMenu:draw()
	love.graphics.printf("PARTY", 0, 0, self.bg.width, "center")
	if self.state == "MAIN" then
		love.graphics.printf("["..Input.key_bindings["menu"][1]:upper().."] REMOVE", 185, -20, self.bg.width, "center")
	end
	
    for i=1,4 do
        local path = "ui/menu/party/head"
        if Game.party[i] then
            path = Game.party[i].menu_icon
        end
        local sprite = Assets.getTexture(path)
        local width  = sprite:getWidth()
        love.graphics.draw(sprite, i*105 + 15, 35, 0, 2, 2, 11*width/8, 0.5)
    end
	
	love.graphics.setColor(1, 0, 0)
    love.graphics.draw(self.heart_sprite, (self.selected_party*105 + 20) - 55, 80, 0, 1, 1, 0.5, 0.5)
	
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

function DarkPartyMenu:reorderParty()
	if Game.party[2] == nil then
		if Game.party[3] ~= nil then
			Game.party[2] = Game.party[3]
			Game.party[3] = nil
		elseif Game.party[4] ~= nil then
			Game.party[2] = Game.party[4]
			Game.party[4] = nil
		end

	end
	if Game.party[3] == nil and Game.party[4] ~= nil then
		Game.party[3] = Game.party[4]
		Game.party[4] = nil
	end
	-- Double check that followers are the right actors
	if Game.world.followers[1] and Game.party[2] then Game.world.followers[1]:setActor(Game.party[2].actor) end
	if Game.world.followers[2] and Game.party[3] then Game.world.followers[2]:setActor(Game.party[3].actor) end
	if Game.world.followers[3] and Game.party[4] then Game.world.followers[3]:setActor(Game.party[4].actor) end

	-- for SOME reason I've had one(1) follower stick around when I have a 1 person party. We remove them here.
	if Game.world.followers[1] and not Game.party[2] then Game.world.followers[1]:remove() end

end

return DarkPartyMenu
