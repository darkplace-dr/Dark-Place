local BlendMenu, super = Class(Object)

function BlendMenu:init()
    super.init(self, 130, 130, 380, 220)

    self.parallax_x = 0
    self.parallax_y = 0

    self.font = Assets.getFont("main")
    self.font_small = Assets.getFont("main", 16)

    self.ui_move = Assets.newSound("ui_move")
    self.ui_select = Assets.newSound("ui_select")
    self.ui_cant_select = Assets.newSound("ui_cant_select")
    self.ui_cancel_small = Assets.newSound("ui_cancel_small")

    self.heart_sprite = Assets.getTexture("player/heart")
    self.up = Assets.getTexture("ui/page_arrow_up")
    self.down = Assets.getTexture("ui/page_arrow_down")

    self.bg = UIBox(0, 0, self.width, self.height)
    self.bg.layer = -1
    self.bg.debug_select = false
    self:addChild(self.bg)
	
	self.blends = {
		-- name, item ID, effect, Darkess, Fountain, Spam, Binari (add more parameters for more beans)
		{"Hatsell Blend", "hatsell_blend", "+1 Attack", 10, 0, 20, 0},
		{"Friva Blend", "friva_blend", "+1 Defense", 20, 0, 10, 0},
	}
	
	self.selected = 1
	
	self.page = 1
	self.pages = math.ceil(#self.blends/15)
end

function BlendMenu:draw()
    super.draw(self)

    love.graphics.setFont(self.font_small)
	love.graphics.setLineWidth(4)
	
	love.graphics.line(self.width/2 - 20, -20, self.width/2 - 20, 240)
	love.graphics.line(self.width/2 - 20, 190, self.width + 20, 190)
	
	for k,v in pairs(self.blends) do
		if (k >= 1 + 15 * (self.page - 1)) and (k <= 15 * (self.page)) then
			if k == self.selected then
				love.graphics.setColor(1, 1, 0, 1)
			else
				love.graphics.setColor(1, 1, 1, 1)
			end
			love.graphics.print(v[1], -6, -26 + (16 * (k-15*(self.page-1))))
		end
	end
	
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.printf(self.blends[self.selected][1], self.width/2, -14, self.width/2, "center")
	love.graphics.setFont(self.font)
	love.graphics.print(self.blends[self.selected][3], self.width/2 - 4, 198)
    love.graphics.setFont(self.font_small)
	love.graphics.print("Darkess Beans", self.width/2 - 4, 10)
	love.graphics.print(Game:getFlag("darkess_beans") .. "/" .. self.blends[self.selected][4], self.width - self.font_small:getWidth(Game:getFlag("darkess_beans")) - self.font_small:getWidth(self.blends[self.selected][4]), 10)
	love.graphics.print("Fountain Beans", self.width/2 - 4, 30)
	love.graphics.print(Game:getFlag("fountain_beans") .. "/" .. self.blends[self.selected][5], self.width - self.font_small:getWidth(Game:getFlag("fountain_beans")) - self.font_small:getWidth(self.blends[self.selected][5]), 30)
	love.graphics.print("Spam Beans", self.width/2 - 4, 50)
	love.graphics.print(Game:getFlag("spam_beans") .. "/" .. self.blends[self.selected][6], self.width - self.font_small:getWidth(Game:getFlag("spam_beans")) - self.font_small:getWidth(self.blends[self.selected][6]), 50)
	love.graphics.print("Binaribeans", self.width/2 - 4, 70)
	love.graphics.print(Game:getFlag("binaribeans") .. "/" .. self.blends[self.selected][7], self.width - self.font_small:getWidth(Game:getFlag("binaribeans")) - self.font_small:getWidth(self.blends[self.selected][7]), 70)
	
	if self.page < self.pages then
		Draw.draw(self.down, 135, 204)
	end
	
	if self.page > 1 then
		Draw.draw(self.up, 135, 0)
	end
end

function BlendMenu:close()
    Game.world.menu = nil
    self:remove()
end

function BlendMenu:onKeyPressed(key)
    if Input.pressed("cancel") or Input.pressed("menu") then
        self.ui_cancel_small:stop()
        self.ui_cancel_small:play()
        Game.world:closeMenu()
        return
    end
	if Input.pressed("confirm") then
		if Game:getFlag("darkess_beans") >= self.blends[self.selected][4] and Game:getFlag("fountain_beans") >= self.blends[self.selected][5] and Game:getFlag("spam_beans") >= self.blends[self.selected][6] and Game:getFlag("binaribeans") >= self.blends[self.selected][7] then
			local success = Game.inventory:addItem(self.blends[self.selected][2])
			if success then
				self.ui_select:stop()
				self.ui_select:play()
				Game:addFlag("darkess_beans", -self.blends[self.selected][4])
				Game:addFlag("fountain_beans", -self.blends[self.selected][5])
				Game:addFlag("spam_beans", -self.blends[self.selected][6])
				Game:addFlag("binaribeans", -self.blends[self.selected][7])
			else
				self.ui_cant_select:stop()
				self.ui_cant_select:play()
			end
		else
			self.ui_cant_select:stop()
			self.ui_cant_select:play()
		end
        return
    end
	local old = self.selected
	if Input.is("up", key) then
		self.selected = self.selected - 1
	end
	if Input.is("down", key) then
		self.selected = self.selected + 1
	end
	if self.selected < 1 then self.selected = 1 end
	if self.selected > #self.blends then self.selected = #self.blends end
	if self.selected ~= old then
		self.ui_move:stop()
		self.ui_move:play()
		for i=1,self.pages do
			if (self.selected >= 1 + 15 * (i - 1)) and (self.selected <= 15 * (i)) then
				self.page = i
			end
		end
	end
end

return BlendMenu