local CardGame, super = Class(Object)

function  CardGame:init()
    super:init(self)

    self.money = 0
	
	self.cards = { {"rodenteer", 6} }					-- Cards to add to the deck.
	self.deck = { }										-- Draw pile.
	self.player_deck = { }								-- Draw pile for the player.
	self.discard = { }									-- Discard pile, after a card is used.
	self.player_discard = { }							-- Discard pile for player, after a card is used.
	
	self.coinflip = "Random"							-- Random, Heads, Tails
	
	self.coin_head = "cards/heads"
	self.coin_tail = "cards/tails"
	self.coin_side = "heads"
	self.flipped = 0
	
	self.name = "Tutorial Terry"
	self.opponent_name = "cards/opponent/terry"
	self.opponent_head = "cards/opponent/terry_head"
	self.opponent_color = {178/255,0,255/255,1}
	
	self.attack_sprite = "cards/icons/attack"
	self.defend_sprite = "cards/icons/defend"
	
	self.player_hand = { }
	self.opponent_hand = { }
	
	self.max_hp = 20									-- Change this value if you wish for the game to be longer.
	
	self.ui_move = Assets.newSound("ui_move")
    self.ui_select = Assets.newSound("ui_select")
	self.ui_error = Assets.newSound("error")
    self.ui_cant_select = Assets.newSound("ui_cant_select")
	self.ui_block = Assets.newSound("ding")
    self.ui_hit = Assets.newSound("damage")
	
	self.intro_timer = 0
    self.offset = 0

    self.transitioned = false
    self.started = false
	
	-- states: TRANSITION, FLIPCOIN, DRAW, TURN, CARDSELECT, SLIDECARDS, FLIPCARDS, ATTACKING, POSTTURN, VICTORY, DEFEAT, TRANSITIONOUT

    self.state = "NONE"
    self.substate = "NONE"

    self.state_reason = nil
    self.substate_reason = nil

    self.camera = Camera(self, SCREEN_WIDTH/2, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT, false)

    self.cutscene = nil

    self.current_selected = 1

    self.turn_count = 0
	
	self.state_timer = 0

    self.cards_ui = nil
	
    self.soul = nil

    self.music = Music()
	self.music_choice = "cards"

    self.timer = Timer()
    self:addChild(self.timer)
	
	self.selected_cards = { }							-- What cards are selected by the player to play?
	self.selected_cards_o = { }							-- What cards are selected by the opponent to play?
	
	self.player_points = 2
	self.opponent_points = 2

    self.darkify = false								-- To be determined if we'll use this
	
	self.transition_cover = Sprite("new_battle_transition/cover", 0, -560)
	self.transition_cover.scale_x = 2
    self.transition_cover.scale_y = 2
	self.transition_cover.layer = CARD_LAYERS["top"]
	self:addChild(self.transition_cover)
	
	self.intro_completed = false
	self.outro_completed = false
	self.ending_started = false
	
	self.flip_timer = 0
	
	self.px, self.py = Game.world.player:localToScreenPos(9,20)
	
	self.attack_started = false
	self.attack_begun = false
	self.start_draw = false
	self.post_attack = false
	self.can_select = false
	
	self.post_turn = false
	self.init_draw = false
	
	self.textbox = nil
	
	self.ui_rect = Rectangle(0, 0, SCREEN_WIDTH, 37)
	self.ui_rect.color = {0,0,0}
	
	self.ending = false
end

function CardGame:postInit()
	if Game.world.music:isPlaying() and self.music_choice then
        self.resume_world_music = true
        Game.world.music:pause()
    end
	
	self.player_hp = self.max_hp
	self.opponent_hp = self.max_hp
	
	self.state = "TRANSITION"
	
	for k,v in pairs(self.cards) do
		self:addToDeck(v)
	end
	
	for k,v in pairs(Game:getFlag("equipped_cards")) do
		self:addToPlayerDeck(v)
	end
	
	self.deck = Utils.shuffle(self.deck)
	self.player_deck = Utils.shuffle(self.player_deck)
	
	if self.coinflip == "Heads" then
		self.flips = 4
		self.turn_attacking = true
	elseif self.coinflip == "Tails" then
		self.flips = 5
		self.turn_attacking = false
	else
		self.flips = math.random (3, 8)
		if self.flips%2 == 1 then
			self.turn_attacking = false
		else
			self.turn_attacking = true
		end
	end
	self.flips = self.flips + 1
	
	self.playerbox = PlayerBox(-2,0)
	self.opponentbox = OpponentBox(SCREEN_WIDTH - 211,0,self.opponent_name,self.opponent_head,self.opponent_color)
	
	self.coin_slide_timer = 0
	self.coin = Sprite(self.coin_head, SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
	self.coin:setOrigin(0.5, 0.5)
	self.coin.scale_x = 2
    self.coin.scale_y = 2
	self.coin.layer = CARD_LAYERS["coin"]
end

function CardGame:startCutscene(group, id, ...)
	if self.cutscene and not self.cutscene.ended then
        local cutscene_name = ""
        if type(group) == "string" then
            cutscene_name = group
            if type(id) == "string" then
                cutscene_name = group.."."..id
            end
        elseif type(group) == "function" then
            cutscene_name = "<function>"
        end
        error("Attempt to start a cutscene "..cutscene_name.." while already in cutscene "..self.cutscene.id)
    end
    if Kristal.Console.is_open then
        Kristal.Console:close()
    end
    self.cutscene = CardCutscene(group, id, ...)
    return self.cutscene
end

function CardGame:addToDeck(cardset)
	local card = cardset[1]
	local count = cardset[2]
	for i=1,count do
		self:addCard(card)
	end
end

function CardGame:addToPlayerDeck(cardset)
	local card = cardset[1]
	local count = cardset[2]
	for i=1,count do
		self:addPlayerCard(card)
	end
end

function CardGame:addCard(card)
	table.insert(self.deck, Mod:createCard(card))
end

function CardGame:addPlayerCard(card)
	table.insert(self.player_deck, Mod:createCard(card))
end

function CardGame:drawCard(plr, card)
	if plr then
		table.insert(self.player_hand, table.remove(self.player_deck, 1))
		self.player_hand[#self.player_hand].x = -50 + (#self.player_hand * 100)
		self.player_hand[#self.player_hand].y = SCREEN_HEIGHT + 65
		self.player_hand[#self.player_hand]:flip()
		self:addChild(self.player_hand[#self.player_hand])
		self.timer:tween(0.5, self.player_hand[#self.player_hand], {y = SCREEN_HEIGHT - 65}, "out-cubic")
	else
		table.insert(self.opponent_hand, table.remove(self.deck, 1))
		self.opponent_hand[#self.opponent_hand].x = SCREEN_WIDTH - 32 - (#self.opponent_hand * 18)
		self.opponent_hand[#self.opponent_hand].y = SCREEN_HEIGHT + 65
		self:addChild(self.opponent_hand[#self.opponent_hand])
		self.timer:tween(0.5, self.opponent_hand[#self.opponent_hand], {y = SCREEN_HEIGHT - 65}, "out-cubic")
	end
end

function CardGame:showUI()
    if self.cards_ui then
        self.cards_ui:transitionIn()
    end
end

function CardGame:onRemove(parent)
    super:onRemove(self, parent)

    self.music:remove()
end

function CardGame:setState(state, reason)
    local old = self.state
    self.state = state
    self.state_reason = reason
    self:onStateChange(old, self.state)
end

function CardGame:setSubState(state, reason)
    local old = self.substate
    self.substate = state
    self.substate_reason = reason
end

function CardGame:getState()
    return self.state
end

function CardGame:onStateChange(old,new)
	self.state_timer = 0
end

function CardGame:update()
	if not self.cutscene then
		super:update(self)
		
		self.state_timer = self.state_timer + DTMULT
		
		if self.state == "TRANSITION" then
			self:updateTransition()
		elseif self.state == "FLIPCOIN" then
			self:updateCoinflip()
		elseif self.state == "IDRAW" then
			self:updateIDraw()
		elseif self.state == "DRAW" then
			self:updateDraw()
		elseif self.state == "CARDSELECT" then
			self:updateCardSelect()
		elseif self.state == "SLIDECARDS" then
			self:updateCardSlide()
		elseif self.state == "FLIPCARDS" then
			self:updateFlipCard()
		elseif self.state == "ATTACKING" then
			self:updateAttack()
		elseif self.state == "POSTTURN" then
			self:updatePostTurn()
		elseif self.state == "VICTORY" then
			self:updateWin()
		elseif self.state == "DEFEAT" then
			self:updateLoss()
		elseif self.state == "TRANSITIONOUT" then
			self:updateTransitionOut()
		end
	end
	
	if self.cutscene then
		if not self.cutscene.ended then
			self.cutscene:update()
		else
			self.cutscene = nil
		end
	end
	
	Game.world:update()
end

function CardGame:onKeyPressed(key, is_repeat)
	if self.state == "CARDSELECT" then
		if self.can_select then
			if Input.isConfirm(key) then
				if self.player_hand[self.current_selected].selected == true then
					self.player_hand[self.current_selected]:selectUnselect()
					self.player_points = self.player_points + self.player_hand[self.current_selected].cost
				else
					if not self.player_hand[self.current_selected].webbed then
						if self.player_hand[self.current_selected].cost <= self.player_points then
							if (self.turn_attacking == true and self.player_hand[self.current_selected].attack == true) or (self.turn_attacking == false and self.player_hand[self.current_selected].defense == true) then
								self.ui_select:stop()
								self.ui_select:play()
								self.player_hand[self.current_selected]:selectUnselect()
								self.player_points = self.player_points - self.player_hand[self.current_selected].cost
							else
								self.ui_error:stop()
								self.ui_error:play()
							end
						else
							self.ui_error:stop()
							self.ui_error:play()
						end
					else
						self.ui_error:stop()
						self.ui_error:play()
					end
				end
			elseif Input.isCancel(key) then
				self:setState("SLIDECARDS")
			elseif Input.is("left", key) then
				if self.current_selected > 1 then
					self.current_selected = self.current_selected - 1
					self.soul.x = self.player_hand[self.current_selected].x
					self.ui_move:stop()
					self.ui_move:play()
				else
					self.ui_cant_select:stop()
					self.ui_cant_select:play()
				end
			elseif Input.is("right", key) then
				if self.current_selected < #self.player_hand then
					self.current_selected = self.current_selected + 1
					self.soul.x = self.player_hand[self.current_selected].x
					self.ui_move:stop()
					self.ui_move:play()
				else
					self.ui_cant_select:stop()
					self.ui_cant_select:play()
				end
			end
		end
    end
end

function CardGame:updateTransition()
	if self.state_timer <= 15 then
		self.transition_cover.y = self.transition_cover.y + ((DTMULT / 15) * 580)
	end

    if self.state_timer >= 15 then
		if not self.intro_completed then
			self.intro_completed = true
			self:addChild(self.coin)
			self:addChild(self.ui_rect)
			self:addChild(self.playerbox)
			self:addChild(self.opponentbox)
		end
		self.transition_cover.y = self.transition_cover.y - ((DTMULT / 15) * 580)
    end
	
	if self.state_timer >= 30 then
		self:setState("FLIPCOIN")
		self.music:play(self.music_choice)
	end
end

function CardGame:updateTransitionOut()
	local prev = self.state_timer - DTMULT
	if not self.ending_started then
		self.ending_started = true
	end

    if self.state_timer <= 0 then--or not self.transitioned then
        self:returnToWorld()
		self.transition_cover:remove()
        return
    end
	
	if self.state_timer <= 10 then
		self.transition_cover.y = self.transition_cover.y + (DTMULT * 56)
	end
	
	if prev < 10 and self.state_timer >= 10 then
		for k,v in pairs(self.selected_cards) do
			v:remove()
		end
		
		for k,v in pairs(self.selected_cards_o) do
			v:remove()
		end
		
		for k,v in pairs(self.player_hand) do
			v:remove()
		end
		
		for k,v in pairs(self.opponent_hand) do
			v:remove()
		end
		
		self.ui_rect:remove()
		self.playerbox:remove()
		self.opponentbox:remove()
	end
	
	if self.state_timer >= 10 then
		if not self.outro_completed then
			self.outro_completed = true
		end
		self.transition_cover.y = self.transition_cover.y - (DTMULT * 56)
    end
	
	if self.state_timer >= 20 then
		self.transition_cover:remove()
		Game.card_game = nil
		Game.state = "OVERWORLD"
		if self.resume_world_music then
			Game.world.music:resume()
		end
		self:remove()
	end
end

function CardGame:updateCoinflip()
	if self.state_timer >= 10 and self.flipped < self.flips then
		self.coin.scale_x = (math.sin((self.state_timer - 10) * 0.5)) * 2
		local prev = self.state_timer - DTMULT
		if Utils.sign(math.cos((self.state_timer - 10) * 0.5)) ~= Utils.sign(math.cos((prev - 10) * 0.5)) then
			self.flipped = self.flipped + 1
		end
	end
	
	if self.flipped == self.flips then
		self.flip_timer = self.flip_timer + DTMULT
		if self.flip_timer > 15 then
			self.coin.x = self.coin.x + (DTMULT * 14)
			if self.coin.x > SCREEN_WIDTH + 70 then
				self.coin:remove()
				self:setState("IDRAW")
			end
		end
	end
	
	if self.coin.scale_x < 0 then
		self.coin:setSprite(self.coin_tail)
	else
		self.coin:setSprite(self.coin_head)
	end
end

function CardGame:updateIDraw()
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
		self:setState("CARDSELECT")
	end
end

function CardGame:updateDraw()
	if self.init_draw == false then
		self.init_draw = true
		self.discard = Utils.shuffle(self.discard)
		
		for k,v in pairs(self.discard) do
			v:flip()
			v:selectUnselect()
			table.insert(self.deck, v)
		end
		
		for k,v in pairs(self.player_discard) do
			v:flip()
			v:selectUnselect()
			table.insert(self.player_deck, v)
		end
		
		for k,v in pairs(self.deck) do
			Utils.removeFromTable(self.discard, v)
		end
		
		for k,v in pairs(self.player_deck) do
			Utils.removeFromTable(self.player_discard, v)
		end
		
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
	
	local prev = self.state_timer - DTMULT
	
	if prev < 5 and self.state_timer >= 5 then
		if #self.player_hand < 4 then
			self:drawCard(true)
		end
	end
	if prev < 10 and self.state_timer >= 10 then
		if #self.opponent_hand < 4 then
			self:drawCard(false)
		end
	end
	if prev < 15 and self.state_timer >= 15 then
		self:setState("CARDSELECT")
	end
end

function CardGame:updateCardSelect()
	if self.attack_started == false then
		self.attack_started = true
		self.soul = Sprite("player/heart_dodge", self.px, self.py)
		self.soul:setColor(Game.party[1].soul_color)
		self.soul.layer = CARD_LAYERS["soul"]
		self.soul:setOrigin(0.5,0.5)
		self:addChild(HeartBurst(self.px - 10, self.py - 10, {253/255, 190/255, 219/255}))
		self:addChild(self.soul)
		self.timer:tween(0.25, self.soul, {y = self.player_hand[1].y - 100, x = self.player_hand[1].x}, "in-linear", function()
			self.can_select = true
		end)
	end
end

function CardGame:updateCardSlide()
	if self.post_attack == false then
		self.post_attack = true
		self.timer:tween(0.25, self.soul, {y = self.py, x = self.px}, "in-linear", function()
			self:addChild(HeartBurst(self.px - 10, self.py - 10, {253/255, 190/255, 219/255}))
			self.soul:remove()
		end)
		local selcount = 0
		for k,v in pairs(self.player_hand) do
			if v.selected == true then
				selcount = selcount + 1
				table.insert(self.selected_cards, v)
			end
		end
		for k,v in pairs(self.selected_cards) do
			Utils.removeFromTable(self.player_hand, self.selected_cards[k])
		end
		
		self:enemyAI()
		
		if selcount == 1 then
			self.timer:tween(0.25, self.selected_cards[1], {y = 200, x = 168})
		elseif selcount == 2 then
			self.timer:tween(0.25, self.selected_cards[1], {y = 200, x = 118})
			self.timer:tween(0.25, self.selected_cards[2], {y = 200, x = 218})
		elseif selcount == 3 then
			self.timer:tween(0.25, self.selected_cards[1], {y = 135, x = 118})
			self.timer:tween(0.25, self.selected_cards[2], {y = 135, x = 218})
			self.timer:tween(0.25, self.selected_cards[3], {y = 265, x = 168})
		elseif selcount == 4 then
			self.timer:tween(0.25, self.selected_cards[1], {y = 135, x = 118})
			self.timer:tween(0.25, self.selected_cards[2], {y = 135, x = 218})
			self.timer:tween(0.25, self.selected_cards[3], {y = 265, x = 118})
			self.timer:tween(0.25, self.selected_cards[4], {y = 265, x = 218})
		end
		
		if #self.selected_cards_o == 1 then
			self.timer:tween(0.25, self.selected_cards_o[1], {y = 200, x = 470})
		elseif #self.selected_cards_o == 2 then
			self.timer:tween(0.25, self.selected_cards_o[1], {y = 200, x = 420})
			self.timer:tween(0.25, self.selected_cards_o[2], {y = 200, x = 520})
		elseif #self.selected_cards_o == 3 then
			self.timer:tween(0.25, self.selected_cards_o[1], {y = 135, x = 420})
			self.timer:tween(0.25, self.selected_cards_o[2], {y = 135, x = 520})
			self.timer:tween(0.25, self.selected_cards_o[3], {y = 265, x = 470})
		elseif #self.selected_cards_o == 4 then
			self.timer:tween(0.25, self.selected_cards_o[1], {y = 135, x = 420})
			self.timer:tween(0.25, self.selected_cards_o[2], {y = 135, x = 520})
			self.timer:tween(0.25, self.selected_cards_o[3], {y = 265, x = 420})
			self.timer:tween(0.25, self.selected_cards_o[4], {y = 265, x = 520})
		end
		
		for k,v in pairs(self.player_hand) do
			self.timer:tween(0.25, v, {x = -50 + (k * 100)})
		end
		for k,v in pairs(self.opponent_hand) do
			self.timer:tween(0.25, v, {x = SCREEN_WIDTH - 32 - (k * 18)})
		end
	end
	if self.state_timer >= 5 then
		self:setState("FLIPCARDS")
	end
end

function CardGame:enemyAI()
	for k,v in pairs(self.opponent_hand) do
		if self.opponent_points >= v.cost then
			if ((self.turn_attacking == false and v.attack == true) or (self.turn_attacking == true and v.defense == true)) and not v.webbed then
				table.insert(self.selected_cards_o, v)
				v:selectUnselect(true)
				self.opponent_points = self.opponent_points - v.cost
			end
		end
	end
	for k,v in pairs(self.selected_cards_o) do
		Utils.removeFromTable(self.opponent_hand, self.selected_cards_o[k])
	end
end

function CardGame:updateFlipCard()
	local prev = self.state_timer - DTMULT
	for k,v in pairs(self.selected_cards_o) do
		if prev < 10 * k and self.state_timer >= 10 * k then
			v:flip()
		end
	end
	if self.state_timer > 10 + (10 * #self.selected_cards_o) then
		self:setState("ATTACKING")
	end
end

function CardGame:updateAttack()
	if self.attack_begun == false then
		self.attack_begun = true
		self.post_turn = false
		self.init_draw = false
		local player_val = 0
		for k,v in pairs(self.selected_cards) do
			player_val = player_val + v.value
		end
		for k,v in pairs(self.player_hand) do
			if v.webbed then
				v:webUnweb()
			end
			if v.web_outline then
				v.web_outline:remove()
			end
		end
		local opponent_val = 0
		for k,v in pairs(self.selected_cards_o) do
			opponent_val = opponent_val + v.value
		end
		for k,v in pairs(self.opponent_hand) do
			if v.webbed then
				v:webUnweb()
			end
			if v.web_outline then
				v.web_outline:remove()
			end
		end
		local webbed = 0
		self.timer:tween(0.5, self.attacking, {x = self.defending.x}, "in-cubic", function()
			if self.turn_attacking == true then
				local can_web = 0
				for k,v in pairs(self.opponent_hand) do
					if not v.webbed then
						can_web = can_web + 1
					end
				end
				if player_val > opponent_val then
					self.defending:remove()
					local attack_val = player_val - opponent_val
					for k,v in pairs(self.selected_cards) do
						for k,v in pairs(v.status) do
							if v == "poison" then
								attack_val = attack_val + 1
							elseif v == "web" then
								if webbed < can_web then
									webbed = webbed + 1
								end
							end
						end
						if v.special == "steal" then
							if #self.player_hand > 0 then
								local choice = Utils.pick(self.opponent_hand)
								table.insert(self.player_hand, choice)
								Utils.removeFromTable(self.opponent_hand, choice)
								choice:flip()
							end
						elseif v.special == "block" then
							self:drawCard(false, "fake")
						end
					end
					self.opponent_hp = self.opponent_hp - attack_val
					self.ui_hit:stop()
					self.ui_hit:play()
					if self.opponent_hp <= 0 then
						self.opponent_hp = 0
						self:setState("VICTORY")
					end
				else
					self.attacking:remove()
					self.ui_block:stop()
					self.ui_block:play()
					for k,v in pairs(self.selected_cards_o) do
						if v.special == "steal" then
							if #self.player_hand > 0 then
								local choice = Utils.pick(self.player_hand)
								table.insert(self.opponent_hand, choice)
								Utils.removeFromTable(self.player_hand, choice)
								choice:flip()
							end
						elseif v.special == "block" then
							self:drawCard(true, "fake")
						end
					end
				end
				while webbed > 0 do
					local choice = Utils.pick(self.opponent_hand)
					if not choice.webbed then
						choice:webUnweb()
						webbed = webbed - 1
					end
				end
			else
				local can_web = 0
				for k,v in pairs(self.player_hand) do
					if not v.webbed then
						can_web = can_web + 1
					end
				end
				if opponent_val > player_val then
					self.defending:remove()
					local attack_val = opponent_val - player_val
					for k,v in pairs(self.selected_cards_o) do
						for k,v in pairs(v.status) do
							if v == "poison" then
								attack_val = attack_val + 1
							elseif v == "web" then
								if webbed < can_web then
									webbed = webbed + 1
								end
							end
						end
						if v.special == "steal" then
							if #self.opponent_hand > 0 then
								local choice = Utils.pick(self.player_hand)
								table.insert(self.opponent_hand, choice)
								Utils.removeFromTable(self.player_hand, choice)
								choice:flip()
							end
						elseif v.special == "block" then
							self:drawCard(true, "fake")
						end
					end
					self.player_hp = self.player_hp - attack_val
					self.ui_hit:stop()
					self.ui_hit:play()
					if self.player_hp <= 0 then
						self.player_hp = 0
						self:setState("DEFEAT")
					end
				else
					self.attacking:remove()
					self.ui_block:stop()
					self.ui_block:play()
					for k,v in pairs(self.selected_cards) do
						if v.special == "steal" then
							if #self.opponent_hand > 0 then
								local choice = Utils.pick(self.opponent_hand)
								table.insert(self.player_hand, choice)
								Utils.removeFromTable(self.opponent_hand, choice)
								choice:flip()
							end
						elseif v.special == "block" then
							self:drawCard(false, "fake")
						end
					end
				end
				while webbed > 0 do
					local choice = Utils.pick(self.player_hand)
					if not choice.webbed then
						choice:webUnweb()
						webbed = webbed - 1
					end
				end
			end
		end)
	end
	if self.state_timer > 20 then
		if self.player_hp <= 0 then
			self:setState("DEFEAT")
		elseif self.opponent_hp <= 0 then
			self:setState("VICTORY")
		else
			self:setState("POSTTURN")
		end
	end
end

function CardGame:updatePostTurn()
	if self.post_turn == false then
		self.post_turn = true
		self.attack_started = false
		self.attack_begun = false
		self.start_draw = false
		self.post_attack = false
		self.can_select = false
		
		self.current_selected = 1
		self.turn_count = self.turn_count + 1
		
		if self.turn_attacking then
			self.turn_attacking = false
		else
			self.turn_attacking = true
		end
		
		if self.attacking then
			self.attacking:remove()
		end
		if self.defending then
			self.defending:remove()
		end
		
		for k,v in pairs(self.selected_cards) do
			self.timer:tween(0.5, v, {y = v.y - 350}, "in-linear", function()
				table.insert(self.player_discard, v)
				Utils.removeFromTable(self.selected_cards, v)
				v:remove()
			end)
		end
		for k,v in pairs(self.selected_cards_o) do
			self.timer:tween(0.5, v, {y = v.y - 350}, "in-linear", function()
				table.insert(self.discard, v)
				Utils.removeFromTable(self.selected_cards_o, v)
				v:remove()
			end)
		end
		
		self.player_points = 2 + math.ceil(self.turn_count / 2)
		if self.player_points > 9 then
			self.player_points = 9
		end
		self.opponent_points = 2 + math.ceil(self.turn_count / 2)
		if self.opponent_points > 9 then
			self.opponent_points = 9
		end
	
		for k,v in pairs(self.player_hand) do
			if v.expire then
				v.expire = v.expire - 1
				if v.expire <= 0 then
					Utils.removeFromTable(self.player_hand, v)
					self.timer:tween(0.25, v, {y = v.y + 150}, "in-linear", function()
						v:remove()
					end)
				end
			end
		end
		for k,v in pairs(self.player_hand) do
			if v then
				self.timer:tween(0.25, v, {x = -50 + (k * 100)})
			end
		end
		for k,v in pairs(self.opponent_hand) do
			if v.expire then
				v.expire = v.expire - 1
				if v.expire <= 0 then
					Utils.removeFromTable(self.opponent_hand, v)
					self.timer:tween(0.25, v, {y = v.y + 150}, "in-linear", function()
						v:remove()
					end)
				end
			end
		end
		for k,v in pairs(self.opponent_hand) do
			if v then
				self.timer:tween(0.25, v, {x = SCREEN_WIDTH - 32 - (k * 18)})
			end
		end
	end
	
	if self.state_timer > 10 then
		self:setState("DRAW")
	end
end

function CardGame:updateWin()
	if not self.ending then
		self.ending = true
		self:onWin()
		self.textbox = Textbox(56, 344, 529, 103)
		self.textbox.layer = CARD_LAYERS["textbox"]
		self.textbox:setCallback(function()
			self.textbox:remove()
			self.textbox = nil
		end)
		self:addChild(self.textbox)
		if self.money > 0 then
			Game.money = Game.money + self.money
			self.textbox:setText("* You won!\n* " .. self.name .. " gave you " .. self.money .. " D$!")
		else
			self.textbox:setText("* You won!")
		end
	end
	
	if not self.textbox then
		self:setState("TRANSITIONOUT")
	end
end

function CardGame:onWin()
end

function CardGame:updateLoss()
	if not self.ending then
		self.ending = true
		self:onLoss()
		self.textbox = Textbox(56, 344, 529, 103)
		self.textbox.layer = CARD_LAYERS["textbox"]
		self.textbox:setCallback(function()
			self.textbox:remove()
			self.textbox = nil
		end)
		self:addChild(self.textbox)
		self.textbox:setText("* You lost.")
	end
	
	if not self.textbox then
		self:setState("TRANSITIONOUT")
	end
end

function CardGame:onLoss()
end

return CardGame