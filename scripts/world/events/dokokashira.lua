local Dokokashira, super = Class(Event)

function Dokokashira:init(data)
	super:init(self, data)
	self.solid = true

	if not Game:getFlag("glitch_passed") then
		Game:setFlag("glitch_passed", false)
	end

	self.wall_bump = Game.world:getEvent(data.properties.flagObject.id)
	self.tile_fucker = Game.world:getEvent(data.properties.tileFucker.id)

	Game:setFlag("glitch_oob", "")

	if Game:getFlag("glitch_passed") or not Game.inventory:isFull("items") then
		self.wall_bump:remove()
		self.tile_fucker:remove()
		return
	end
end

function Dokokashira:update()
	if Game:getFlag("nb_bonk", 0) > 10 and not Game:getFlag("glitch_passed") then
		if self.solid then
			self.x = self.x + 40
			self.width = self.width + 80
			self.solid = false
		end
	end
end

function Dokokashira:onEnter(chara)
    if chara.is_player and Game:getFlag("nb_bonk", 0) > 10 then
    	Game.world.timer:script(function(wait)
    		wait(0.1)
    		Game.lock_movement = true
    		chara:setSprite(chara.sprite.sprite.."/"..chara.sprite.facing.."_"..chara.sprite.frame)
    		for i, chara in ipairs(Game.world.followers) do
    			chara:setSprite(chara.sprite.sprite.."/"..chara.sprite.facing.."_"..chara.sprite.frame)
    		end
    		wait(0.5)
    		chara:remove()
    		for i, chara in ipairs(Game.world.followers) do
    			chara:remove()
    		end
    		for i=1,Game.world.map.width*40 do
    			for j=1,Game.world.map.height*40 do
    				Game.world.map:setTile(i, j, love.math.random(0, 924))
    			end
    		end
    		Game.world.music:play("glitch_music")
    		Game.world:spawnNPC("ghost", 2340, 1395)
    		for i=1,love.math.random(10,30) do
    			local script = Script(Utils.random(2035, 2830), Utils.random(1150, 1680), 40, 40, {cutscene="ghost_glitch"})
    			script.layer = Game.world:parseLayer("objects")
    			Game.world:addChild(script)
    		end
    		while not (Input.pressed("confirm") and not Kristal.Console.is_open and not Game.world.cutscene) and not Kristal.force_quit_glitch do
    			wait()
    		end
    		Kristal.force_quit_glitch = nil
    		Game.world.music:stop()
    		Game.fader.alpha = 1
    		Registry.initMaps()
    		wait(1)
    		Game:setFlag("glitch_passed", true)
    		Game.world:loadMap("cybercity/alley2", 965, 600)
    		Game.lock_movement = false
    		Kristal.callEvent("completeAchievement", "glitch_music")
    		Game.fader.alpha = 0
    	end)
    end
end

return Dokokashira