---@class field : Map
local field, super = Class(Map)

function field:onEnter()
    super.onEnter(self)

	-- "There is always hope." \
	-- This is what I believe in. \
	-- \
	-- Dedicated to Bor and Kumi. As of the time of writing this, I don't even know if either of them will be okay or not. \
	-- Yet at the same time... I feel like I just know both will be fine in the end. I can always hope that these comments will age well.
	---@type string[]
	self.hopes_and_dreams = {
		"I hope Bor and Kumi are okay.", -- This deserves to show up twice as often.
		"I hope Bor and Kumi are okay.", --[[ 6/60/2023 9:00 PM: NEVER TAKE BOR OR KUMI's NAME OFF OF THIS, even if they end up being fine.
												Their names being here is a symbol of good luck. I wish the best of luck for Bor and Kumi both. ]]
		"I hope I can get more sleep soon.",
		"I wish I was more consistant.",
		"I wish I had more time, in general.",
		"I hope everything is going to end up okay.",
		"I hope that all of my friends stay safe.",
		"I hope that I can handle whatever brings me down.",
		"I hope this world lives on for many years to come.",
		"I hope you all get to be happy.",
		"I hope I get to do something meaningful one day.",
		--"", -- Please, add more.
		--"", -- All I ask for are your Hopes and Dreams.
		--"", --       -Charbomber
		--"", -- P.S. I'm afraid of this seeming a little presumptuous or cheesy...
		--"", -- In the end, I don't really care if it's cheesy.
		--"", -- I just have always wanted something like this in Dark Place and...
		--"", -- I think we need this now more than ever, so here it is.
	}

	self.text_gen = Game.world.timer:every(2.5, function()
		local text = Text(Utils.pick(self.hopes_and_dreams),
			20, SCREEN_HEIGHT/2,
			SCREEN_WIDTH - 40, SCREEN_HEIGHT,
			{
				align = "center"
			}
		)
		text:setParallax(0, 0)
		text.physics.speed_y = -1
		text.physics.friction = 0.0005
		text:addFX(OutlineFX(COLORS.black, {
			thickness = 2,
			amount = 4
		}))
		text:fadeOutAndRemove(5)
		Game.world:spawnObject(text, "top") -- FIXME: below_ui ?
	end)

	self.star_gen = Game.world.timer:everyInstant(0.5, function()
		for _ = 1, 2 do
			local star = Sprite("effects/star", Utils.random(40, SCREEN_WIDTH - 40), SCREEN_HEIGHT)
			star:setParallax(0, 0)
			star:setOrigin(0.5, 0.5)
			star.rotation = Utils.random(0, 12)
			star.graphics.spin = -1/30
			star.physics.speed_y = -Utils.random(1, 2)
			star.physics.friction = 0.005
			star:fadeOutAndRemove(3)
			Game.world:spawnObject(star, "top")
		end
	end)
end

function field:onExit()
    super.onExit(self)

	Game.world.timer:cancel(self.text_gen)
	Game.world.timer:cancel(self.star_gen)
end

return field