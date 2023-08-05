local Dokokashira, super = Class(Event)

function Dokokashira:init(data)
	super:init(self, data)
	print(data.properties.flagObject.id)
	self.solid = true

	if not Game:getFlag("glitch_passed", false) then
		Game:setFlag("glitch_passed", false)
	end

	self.wall_bump = Game.world:getEvent(data.properties.flagObject.id)
	self.tile_fucker = Game.world:getEvent(data.properties.tileFucker.id)

	if Game:getFlag("glitch_passed") or not Game.inventory:isFull("items") then
		self.wall_bump:remove()
		self.tile_fucker:remove()
		return
	end

	Game:setFlag("glitch_oob", "")
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
    		while not Input.pressed("confirm") do
    			wait()
    		end
    		Game.world.music:stop()
    		Game.fader.alpha = 1
    		Registry.initMaps()
    		wait(1)
    		Game:setFlag("glitch_passed", true)
    		Game.world:loadMap("cybercity/alley2", 2000, 610)
    		Kristal.callEvent("completeAchievement", "glitch_music")
    		Game.fader.alpha = 0
    	end)
    end
end

return Dokokashira