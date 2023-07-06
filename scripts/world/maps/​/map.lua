local mb_map, super = Class(Map)

function mb_map:load()
	self.return_map = Mod.world_dest_map_bak or Mod.lastMap
	if not Game:getFlag("partySet", nil) then
	    self.old_party = {}
	    for i,v in ipairs(Game.party) do
	    	table.insert(self.old_party, Game.party[i].actor.id)
	    end
		Game:setPartyMembers("kris")
		Game:setFlag("partySet", true)
	end

	self.stepback = 0.01
	Game.world.camera.keep_in_bounds = false

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
			Game:setPartyMembers(Utils.unpack(self.old_party))
			player:remove()
			self.back = false
			Game.world.fader.alpha = 1
			Game.world.timer:after(10+1/120, function()
				Game.world.music:play("TAEFED_OIDUA", 0)
				Game:setFlag("partySet", nil)
				for i,v in ipairs(Game.stage:getObjects(Character)) do
					v:remove()
				end
				Game.world.timer:tween(10, Game.world.music, {volume=1}, "in-cubic", function()
					local t = Text("You lost, Kris.", 200, 200, 300, 200)
					Game.stage:addChild(t)
					Game:setFlag("s", true)

					Game.world.timer:after((1/60)*DTMULT, function()
						t:remove()
						Game.world.fader.alpha = 0
						Game.world.camera.keep_in_bounds = true
						Game.world:loadMap(self.return_map)
					end)
				end)
			end)
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

return mb_map