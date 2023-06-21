local field, super = Class(Map)

function field:onEnter()
    super.onEnter(self)
	
	Game.world.timer:every(0.75, function()
		
		-- "There is always hope."
		-- This is what I believe in.
		
		-- Dedicated to Bor and Kumi. As of the time of writing this, I don't even know if either of them will be okay or not.
		-- Yet at the same time... I feel like I just know both will be fine in the end. I can always hope that these comments will age well.
		local hopetext = Text(Utils.pick({
			"I hope Bor and Kumi are okay.", -- This deserves to show up twice as often.
			"I hope Bor and Kumi are okay.", -- 6/60/2023 9:00 PM: NEVER TAKE BOR OR KUMI's NAME OFF OF THIS, even if they end up being fine. Their names being here is a symbol of good luck. I wish the best of luck for Bor and Kumi both.
			"I hope I can get more sleep soon.",
			"I wish I was more consistant.",
			"I wish I had more time, in general.",
			"I hope everything is going to end up okay.",
			"I hope that all of my friends stay safe.",
			"I hope that I can handle whatever brings me down.",
			--"", -- Please, add more.
			--"", -- All I ask for are your Hopes and Dreams.
			--"", --       -Charbomber
			--"", -- P.S. I'm afraid of this seeming a little presumptuous or cheesy...
			--"", -- In the end, I don't really care if it's cheesy.
			--"", -- I just have always wanted something like this in Dark Place and...
			--"", -- I think we need this now more than ever, so here it is.
		}), SCREEN_WIDTH/2, SCREEN_HEIGHT/2 - 40, 999, 128)
		
		hopetext.physics.speed_y = -1
		hopetext.physics.friction = 0.005
		hopetext:fadeOutAndRemove(3)
		hopetext:setOrigin(0.25, 0)
		Game.stage:addChild(hopetext)
		
		
		for i=0,3 do
			local hopestar = Sprite("effects/star", Utils.random(40, SCREEN_WIDTH - 40, 1), SCREEN_HEIGHT)
			hopestar:setOrigin(0.5, 0.5)
			hopestar.graphics.spin = 0.002 * Utils.randomSign() * Utils.random(1, 3, 1)
			hopestar.physics.speed_y = -1
			hopestar.physics.friction = 0.005
			hopestar:fadeOutAndRemove(3)
			Game.stage:addChild(hopestar)
		end
		
		
		
	end)
	
	
end




function field:onExit()
	Game.world.timer:clear()
end

return field