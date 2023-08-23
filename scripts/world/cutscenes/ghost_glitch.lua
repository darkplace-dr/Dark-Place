return function(cutscene)
	local ghost = cutscene:getCharacter("ghost")
	local leader = Game.world.player

	ghost.actor.spin = false
	Game.world.music:play("burned")
	ghost.alert_icon = Sprite("effects/alert", ghost.sprite.width/2)
	ghost.alert_icon:setOrigin(0.5, 1)
	ghost.alert_icon.layer = 100
	ghost:addChild(ghost.alert_icon)
	Game.world.timer:after(0.8, function()
        ghost.alert_icon:remove()
    end)

    cutscene:wait(0.8)
    ghost:setSprite("walk")

    local dir = love.math.random(1,4)
    local walk

    if dir == 1 then --up
    	walk = cutscene:walkTo(ghost, ghost.x, ghost.y-100)
    elseif dir == 2 then --right
    	walk = cutscene:walkTo(ghost, ghost.x+100, ghost.y)
    elseif dir == 3 then --down
    	walk = cutscene:walkTo(ghost, ghost.x, ghost.y+100)
    elseif dir == 4 then --left
    	walk = cutscene:walkTo(ghost, ghost.x-100, ghost.y)
    end
    cutscene:wait(walk)
    leader:setFacing(Utils.pick({"left", "up", "down", "right"}))

    cutscene:wait(0.2)

    for i=1,love.math.random(1, 10) do
	    local text = ""
	    for _=1,love.math.random(10, 1000) do
	    	local special_text = Utils.random(-10, 300)
	    	print(special_text)
	    	if special_text < -5 then
	    		text = text.."MOM"
	    	elseif special_text < 0 then
	    		text =  text..Game.save_name
	    	else
		    	local r = love.math.random(0, 127)
		    	--print(r, _, string.char(r))
		    	text = text..string.char(r)
		    end
	    end
	    --print(text)
	    if Utils.random(0, 100) <= 25 then
	    	Game.world.timer:after((1/60)*2, function()
	    		local dialogue_text = Game.stage:getObjects(Textbox)[1].text
	    		dialogue_text:setPosition(Utils.random(-50, 50), Utils.random(-350, 50))
	    	end)
	    end
	    cutscene:text(text)
	end
	love.window.showMessageBox("Kristal", "Unknown opcode fd at ff00", "error", false)
	Kristal.force_quit_glitch = true
end