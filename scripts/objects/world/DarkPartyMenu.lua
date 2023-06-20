local DarkPartyMenu, super = Class(Object)

function DarkPartyMenu:init()
    super.init(self, 82, 112, 477, 277)

    self.draw_children_below = 0

    self.font = Assets.getFont("main")

    self.ui_move = Assets.newSound("ui_move")
    self.ui_select = Assets.newSound("ui_select")
    self.ui_cant_select = Assets.newSound("ui_cant_select")
    self.ui_cancel_small = Assets.newSound("ui_cancel_small")

    self.heart_sprite = Assets.getTexture("player/heart")

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
		{"robo_susie", "noyno", "iphone", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown"},
		--{"unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown"},
	}
	
	self.listreference = Game:getFlag("party", {"YOU", "susie"})
	
	for i,list in ipairs(self.list) do
		for i2,entry in ipairs(list) do
			if not self:hasValue(self.listreference, entry) then
				self.list[i][i2] = "unknown"
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
		if Input.pressed("cancel") or Input.pressed("menu") then
            self.ui_cancel_small:stop()
            self.ui_cancel_small:play()
            Game.world:closeMenu()
            return
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
	
    for i=1,4 do
        local path = "party/head"
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

return DarkPartyMenu
