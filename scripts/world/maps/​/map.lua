local mb, super = Class(Map)

function mb:load()
	self.return_map = Mod.lastMap
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

function mb:update()
	super.update(self)
	if self.back then
		local player = Game.world.player
		local mb = Game.world:getEvent(10)
		mb.x = Utils.approach(mb.x, player.x-mb.width/2, self.stepback*DTMULT)
		mb.y = Utils.approach(mb.y, player.y-mb.height*2, self.stepback*DTMULT)
		self.stepback = Utils.clamp(self.stepback + 0.1*DTMULT, 0.01, 12)
		if player:collidesWith(mb) then
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

function mb:onExit()
	if Game:getFlag("partySet", nil) then
		Game:setPartyMembers(Utils.dump(self.old_party))
		Game:setFlag("partySet", nil)
	end
	Game.world.camera.keep_in_bounds = true
end

return mb