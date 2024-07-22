---@class DarkCardsMenu : Object
---@overload fun(...) : DarkCardsMenu
local DarkCardsMenu, super = Class(Object)

function DarkCardsMenu:init()
    super.init(self, 92, 112, 457, 227)

    self.draw_children_below = 0

    self.font = Assets.getFont("main")

    self.ui_move = Assets.newSound("ui_move")
    self.ui_select = Assets.newSound("ui_select")
    self.ui_cant_select = Assets.newSound("ui_cant_select")
    self.ui_cancel_small = Assets.newSound("ui_cancel_small")

    self.heart_sprite = Assets.getTexture("player/heart")
	self.up_sprite = Assets.getTexture("ui/page_arrow_up")
	self.down_sprite = Assets.getTexture("ui/page_arrow_down")

    self.lower_bg = UIBox(0, -6, self.width, self.height + 56)
    self.lower_bg.layer = -1
    self.lower_bg.debug_select = false
    self:addChild(self.lower_bg)

    self.bg = UIBox(0, -6, self.width, self.height)
    self.bg.layer = -1
    self.bg.debug_select = false
    self:addChild(self.bg)

    self.selected_item = 1
	self.offset = 1
	
	local obtained = Game:getFlag("collected_cards")
	self.equipped = Game:getFlag("equipped_cards")
	
	self.obtained = {}
	for i,card in ipairs(obtained) do
		self.obtained[i] = {}
		self.obtained[i][1] = card[1]
		self.obtained[i][2] = Mod:createCard(card[1]).name
		self.obtained[i][3] = card[2]
		self.obtained[i][4] = Mod:createCard(card[1]).image
	end
	self.obtained_num = #self.obtained
	
	self.red_timer = 0
end

function DarkCardsMenu:update()
	self.red_timer = self.red_timer - (DTMULT / 15)
	if Input.pressed("cancel") then
		local num = self:getNumberEquipped()
		if num < 20 or num > 40 then
			self.ui_cant_select:stop()
			self.ui_cant_select:play()
			self.red_timer = 1
		else
			Game:setFlag("equipped_cards", self.equipped)
			self.ui_cancel_small:stop()
			self.ui_cancel_small:play()
			Game.world.menu:closeBox()
			return
		end
    end
	
	if Input.pressed("up") then
		if self.selected_item > 1 then
			self.selected_item = self.selected_item - 1
			if self.selected_item < self.offset then
				self.offset = self.offset - 1
			end
		end
    end
    if Input.pressed("down") then
		if self.selected_item < #self.obtained then
			self.selected_item = self.selected_item + 1
			if self.selected_item > self.offset + 4 then
				self.offset = self.offset + 1
			end
		end
    end
	if Input.pressed("left") then
		local current_equipped = self:findEquippedSlot(self.obtained[self.selected_item][1])
		if current_equipped ~= 0 then
			if current_equipped[2] > 0 then
				current_equipped[2] = current_equipped[2] - 1
				local card = Mod:createCard(self.obtained[self.selected_item][1])
				local reactions = card:getReactionUnequipped()
				for index,chara in ipairs(Game.party) do
					if reactions[chara.id] then
						Game.world.healthbar.action_boxes[index].reaction_alpha = 50
						Game.world.healthbar.action_boxes[index].reaction_text = reactions[chara.id]
					end
				end
			end
		end
    end
    if Input.pressed("right") then
		local current_equipped = self:findEquippedSlot(self.obtained[self.selected_item][1])
		if current_equipped ~= 0 then
			if current_equipped[2] < self.obtained[self.selected_item][3] then
				current_equipped[2] = current_equipped[2] + 1
				local card = Mod:createCard(self.obtained[self.selected_item][1])
				local reactions = card:getReactionEquipped()
				for index,chara in ipairs(Game.party) do
					if reactions[chara.id] then
						Game.world.healthbar.action_boxes[index].reaction_alpha = 50
						Game.world.healthbar.action_boxes[index].reaction_text = reactions[chara.id]
					end
				end
			end
		end
    end

    super.update(self)
end

function DarkCardsMenu:draw()
    love.graphics.setFont(self.font)
	
	love.graphics.rectangle("fill", 260, -26, 6, 268)
	love.graphics.rectangle("fill", 260, 190, 220, 6)
	
	local current_equipped = self:findEquippedSlot(self.obtained[self.selected_item][1])
	
	love.graphics.print("Using: " .. current_equipped[2] .. "/" .. self.obtained[self.selected_item][3], 274, 200)
	love.graphics.print(Input.getText("left") .. ": -1 card, " .. Input.getText("right") .. ": +1 card", 0, 250)
	love.graphics.print("CARDS", 80, -16)
	Draw.setColor({1, 1-self.red_timer, 1-self.red_timer})
	love.graphics.print("Min: 20, Max: 40 (" .. self:getNumberEquipped() .. ")", 6, 200)
	Draw.setColor({1, 1, 1})
	
	for i = self.offset, self.offset + 4 do
		if i > self.obtained_num then break end
		love.graphics.print(self.obtained[i][2], 28, (i-(self.offset-1))*32-10)
	end
	
	Draw.setColor(Game:getSoulColor())
    Draw.draw(self.heart_sprite, 0, (self.selected_item-(self.offset-1))*32)
	
	Draw.setColor({1, 1, 1})
    Draw.draw(Assets.getTexture(self.obtained[self.selected_item][4]), 320, 20)
	
	if self.offset > 1 then
        if Input.down("up") then
            Draw.setColor(1,1,0)
        else
            Draw.setColor(1,1,1)
        end
        Draw.draw(self.up_sprite, 240, 16)
        Draw.setColor(1,1,1)
	end
	
	if self.offset < #self.obtained - 4 then
        if Input.down("down") then
            Draw.setColor(1,1,0)
        else
            Draw.setColor(1,1,1)
        end
        Draw.draw(self.down_sprite, 240, 180)
        Draw.setColor(1,1,1)
	end

    super.draw(self)
end

function DarkCardsMenu:getNumberEquipped()
	local number = 0
	for i,card in ipairs(self.equipped) do
		number = number + card[2]
	end
	return number
end

function DarkCardsMenu:findObtainedSlot(id)
	for i,card in ipairs(self.obtained) do
		if card[1] == id then
			return card
		end
	end
	return 0
end

function DarkCardsMenu:findEquippedSlot(id)
	for i,card in ipairs(self.equipped) do
		if card[1] == id then
			return card
		end
	end
	return 0
end

return DarkCardsMenu