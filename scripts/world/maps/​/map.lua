local mb_map, super = Class(Map)

function mb_map:load()
	self.return_map = Mod.world_dest_map_bak or Mod.lastMap
	if not Game:getFlag("partySet", nil) then
	    self.old_party = {}
	    for _,v in ipairs(Game.party) do
	    	table.insert(self.old_party, v.id)
	    end
		Game:setPartyMembers("kris")
		Game:setFlag("partySet", true)
	end

	self.stepback = 0.01
	Game.world.camera.keep_in_bounds = false

	self.limit_timer = 900

	super.load(self)
end

function mb_map:update()
	super.update(self)
	if self.back then
		local player = Game.world.player
		local mb_ev = Game.world:getEvent(10)
		mb_ev.x = Utils.approach(mb_ev.x, player.x-mb_ev.width/2, self.stepback*DTMULT)
		mb_ev.y = Utils.approach(mb_ev.y, player.y-mb_ev.height*2, self.stepback*DTMULT)
		self.stepback = Utils.clamp(self.stepback + 0.1*DTMULT, 0.01, 12)
		if player:collidesWith(mb_ev) then
			Game:setFlag("s", true)
			Game:setPartyMembers(Utils.unpack(self.old_party))
			player:remove()
			self.back = false
			Game.world:closeMenu()
			for key,_ in pairs(Assets.sound_instances) do
				Assets.stopSound(key, true)
			end
			Game.lock_movement = true
			local c = Rectangle(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
			c:setLayer(WORLD_LAYERS["above_bullets"])
			c:setParallax(0, 0)
			c:setColor(0, 0, 0)
			Game.world:addChild(c)
			Game.world.timer:after(10+1/120, function()
				Game.world.music:play("TAEFED", 0)
				Game:setFlag("partySet", nil)
				for i,v in ipairs(Game.stage:getObjects(Character)) do
					v:remove()
				end
				Game.world.timer:tween(10, Game.world.music, {volume=1}, "in-cubic", function()
					local t = Text("You lost, Kris.", 200, 200, 300, 200)
					t:setLayer(WORLD_LAYERS["textbox"])
					t:setParallax(0, 0)
					Game.world:addChild(t)

					Game.world.timer:after(1/60, function()
						t:remove()
						Game.world.fader.alpha = 0
						Game.world.camera.keep_in_bounds = true
						Game.lock_movement = false
						if type(Mod.world_dest_mk_bak) == "string" or not Mod.world_dest_mk_bak then
							Game.world:loadMap(self.return_map, Mod.world_dest_mk_bak, Mod.world_dest_fc_bak)
						else
							Game.world:loadMap(self.return_map, Mod.world_dest_mk_bak[1], Mod.world_dest_mk_bak[2], Mod.world_dest_fc_bak)
						end
					end)
				end)
			end)
		end
	else
		if not Game:getFlag("finish") then
			self.limit_timer = self.limit_timer - DTMULT
			if self.limit_timer <= 0 then
				self:casuallyApproachChild()
			end
		end
	end
end

function mb_map:onExit()
	if Game:getFlag("partySet", nil) then
		Game:setPartyMembers(Utils.dump(self.old_party))
		Game:setFlag("partySet", nil)
	end
	Game.world.camera.keep_in_bounds = true
end

function mb_map:casuallyApproachChild()
	if not Game:getFlag("finish", false) then
		Game:setFlag("finish", true)
	end
	self.back = true
	for i=#self.collision, 1, -1 do
		table.remove(self.collision, i)
	end
	local mb = Game.world:getEvent(10)
	mb:setHitbox(0, 0, mb.width, mb.height)
	Game.world.camera.keep_in_bounds = false
end

return mb_map