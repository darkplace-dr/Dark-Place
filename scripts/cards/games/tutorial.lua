local Tutorial, super = Class(CardGame)

function Tutorial:init()
	super:init(self)
	
	self.cards = { {"rodenteer", 5},
				   {"froglin", 5},
				   {"rodenteer_ex", 4},
				   {"froglin_ex", 4},
				   {"owlen", 2} }
				   
	self.coinflip = "Heads"
	
	self.flip_cutscene = false
end

function Tutorial:enemyAI()
	for k,v in pairs(self.opponent_hand) do
		if self.opponent_points >= v.cost then
			if (self.turn_attacking == false and v.attack == true) or (self.turn_attacking == true and v.defense == true) then
				if #self.selected_cards_o < 2 then
					table.insert(self.selected_cards_o, v)
					v:selectUnselect(true)
					self.opponent_points = self.opponent_points - v.cost
				end
			end
		end
	end
	for k,v in pairs(self.selected_cards_o) do
		Utils.removeFromTable(self.opponent_hand, self.selected_cards_o[k])
	end
end

function Tutorial:updateIDraw()
	local prev = self.state_timer - DTMULT
	if self.start_draw == false then
		self.start_draw = true
		self.attacking = Sprite("cards/icons/attack")
		self.attacking.y = 7
		if self.turn_attacking then
			self.attacking.x = 212
		else
			self.attacking.x = 412
		end
		self:addChild(self.attacking)
		self.defending = Sprite("cards/icons/defend")
		self.defending.y = 7
		if self.turn_attacking then
			self.defending.x = 412
		else
			self.defending.x = 212
		end
		self:addChild(self.defending)
	end
	if prev < 5 and self.state_timer >= 5 then
		self:drawCard(true)
	end
	if prev < 10 and self.state_timer >= 10 then
		self:drawCard(false)
	end
	if prev < 15 and self.state_timer >= 15 then
		self:drawCard(true)
	end
	if prev < 20 and self.state_timer >= 20 then
		self:drawCard(false)
	end
	if prev < 25 and self.state_timer >= 25 then
		self:drawCard(true)
	end
	if prev < 30 and self.state_timer >= 30 then
		self:drawCard(false)
	end
	if self.state_timer >= 40 then
		if Game:getFlag("dungeonkiller") then
			self:setState("CARDSELECT")
		else
			self:startCutscene("tutorial.pre_pick")
		end
	end
end

function Tutorial:onWin()
	Game:setFlag("CardTutorialWin", true)
end

return Tutorial