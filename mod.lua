function Mod:init()
    print("Loaded "..self.info.name.."!")
end

function Mod:postInit(new_file)
    Utils.hook(ActionButton, "select", function(orig, self)
        if self.type == "send" then
            Game.battle:setState("ENEMYSELECT", "SPARE")
        else
            orig(self)
        end
    end)
    Utils.hook(ActionButton, "hasSpecial", function(orig, self)
        if self.type == "send" then
            for _,enemy in ipairs(Game.battle:getActiveEnemies()) do
                if enemy.mercy >= 100 then
                    return true
                end
            end
            return false
        else
            return orig(self)
        end
    end)
    Utils.hook(EnemyBattler, "getSpareText", function(orig, self, battler, success)
        local text = orig(self, battler, success)
        if battler.chara.id == "YOU" then
            if type(text)=="table" then
                text[1] = text[1]:gsub("spared", "sended")
            else
                text = text:gsub("spared", "sended")
            end
        end
        return text
    end)
    
    	
    --FUN Value
    if new_file then
        Game:setFlag("fun", love.math.random(1,100))
    end

    if new_file and Game:hasPartyMember("YOU") then
        Game.world:startCutscene("react_to_YOU")
    end
	
	Game.binInput = {""}
	
	
	
	-- I'm going to cause pain and suffering with one weird trick:
	-- here's the table containing any and all warp codes for the warp bin
	-- have fun :]   -Char
	
	-- Also for reference: first in a table is the code, second in a table is the result, and third in a table is the marker you wanna go (optional but defaults to spawn).
	-- If the result is a string then it goes to that map, if the last argument is a function it will run the function.
	
	binCodes = {
		{"00000000", "warphub", nil},
		{"spamroom", "spamroom", nil},
		{"desshere", "dessstuff/dessstart", nil},
		{"wtf1998s", function()
			Game.world:showText("* Wow![wait:10]\n* You found a secret![wait:10]\n* Awesome!")
			Game.world:addBinCode("sppispod", function() Game.world:showText({"* Since you found another one...", "* Here's a fun fact:", "* This was made as a way to showcase what the warp bin can do!"}) end)
		end},
		{"bossrush", "thearena", nil},
	
	}
	
	-- if you don't want to be cringe there's also this new totally cool helper function wowee
	-- also returns success just in-case someone else steals your code before you get to use it.
	function Game.world.addBinCode(world, code, result, marker)
		
		for i=1,#binCodes do
			if binCodes[i][1] == code then
				-- whoops, no success
				return false
			end
		end
		
		-- lmao
		binCodes[#binCodes+1] = {code, result, marker or "spawn"}
		return true
	
	end
	
	-- and here's a function to check if a Bin Code exists
	function Game.world.checkBinCode(world, code)
	
		for i=1,#binCodes do
			if binCodes[i][1] == code then
				-- Yep, code exists.
				return true
			end
		end
		
		-- nope.
		return false
	
	end
	
	-- and here's one to delete Bin Codes
	function Game.world.deleteBinCode(world, code)
		
		for i=1,#binCodes do
			if binCodes[i][1] == code then
				-- See ya MAAAAAN
				table.remove(binCodes, binCodes[i])
				return true
			end
		end
		
		-- darn
		return false
	
	end
	
	-- god I am so sorry for how shitty this code is
	
end


-- I'm still sorry
function Map:onEnter()

	BinRect = UIBox((SCREEN_WIDTH / 2) - 64, 256, 128, 32)
	Game.stage:addChild(BinRect)
	--BinRect.color = {0, 0, 0}
	BinRect.visible = false
	
	BinText = Text("", (SCREEN_WIDTH / 2) - 64, 256, 640, 480)
	Game.stage:addChild(BinText)
	--BinText:setLayer(9999999)
	BinText.visible = false

end

function Mod:getActionButtons(battler, buttons)
    if battler.chara.id == "YOU" then
        return {"fight", "act", "item", "send", "defend"}
    end
    return buttons
end

-- hee hee  -Char
function Mod:postUpdate()
	if TextInput.active then
		if #Game.binInput[1] < 8 then
			BinText:setText(Game.binInput[1].."_")
		else
			BinText:setText(Game.binInput[1])
		end
	end
end