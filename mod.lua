function Mod:postInit(new_file)	
    -- FUN Value
    if new_file then
        Game:setFlag("fun", love.math.random(1, 100))
    end

    Mod:initializeYOUHooks()

    if new_file and Game:hasPartyMember("YOU") then
        Game.world:startCutscene("react_to_YOU")
    end
	
	-- Mod:createBinUI()
end

-- Hooks for YOU's "send" action

function Mod:initializeYOUHooks()
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
            if type(text) == "table" then
                text[1] = text[1]:gsub("spared", "sended")
            else
                text = text:gsub("spared", "sended")
            end
        end
        return text
    end)
end
    
function Mod:getActionButtons(battler, buttons)
    if battler.chara.id == "YOU" then
        return {"fight", "act", "item", "send", "defend"}
    end
    return buttons
end

-- Warp Bin
-- god I am so sorry for how shitty this code is

Mod.binInput = {""}

-- I'm going to cause pain and suffering with one weird trick:
-- here's the table containing any and all warp codes for the warp bin
-- have fun :]   -Char
-- Also for reference: first in a table is the code, second in a table is the result, and third in a table is the marker you wanna go (optional but defaults to spawn).
-- If the result is a string then it goes to that map, if the last argument is a function it will run the function.
Mod.binCodes = {
    {"00000000", "warphub"},
    {"spamroom", "spamroom"},
    {"desshere", "dessstuff/dessstart"},
    {"wtf1998s", function()
        Game.world:showText("* Wow![wait:10]\n* You found a secret![wait:10]\n* Awesome!")
        Mod:addBinCode("sppispod", function()
            Game.world:showText({
                "* Since you found another one...",
                "* Here's a fun fact:",
                "* This was made as a way to showcase what the warp bin can do!"
            })
        end)
    end},
    {"bossrush", "thearena"},
}

-- I'm sorry
function Mod:tableContainsValueSatisfyingCondition1D(tbl, cond)
    for i = 1, #tbl do
        if cond(tbl[i]) then
            return true
        end
    end
    return false
end

-- if you don't want to be cringe there's also this new totally cool helper function wowee
-- also returns success just in-case someone else steals your code before you get to use it.
function Mod:addBinCode(code, result, marker)
    marker = marker or "spawn"

    if Mod:binCodeExists(code) then
        -- whoops, no success
        return false
    end
    
    -- lmao
    table.insert(Mod.binCodes, {code, result, marker})
    return true
end

-- and here's a function to check if a Bin Code exists
function Mod:binCodeExists(code)
    return Mod:tableContainsValueSatisfyingCondition1D(Mod.binCodes, function(v) return v[1] == code end)
end

-- and here's one to delete Bin Codes
function Mod:deleteBinCode(code)
    local old_size = #Mod.binCodes
    Utils.filterInPlace(Mod.binCodes, function(v) return v[1] ~= code end)
    return #Mod.binCodes < old_size
end

function Mod:createBinUI()
    BinRect = UIBox((SCREEN_WIDTH / 2) - 64, 256, 128, 32)
    Game.stage:addChild(BinRect)
    --BinRect.color = {0, 0, 0}
    BinRect.visible = false
	
    BinText = Text("", (SCREEN_WIDTH / 2) - 64, 256, 640, 480)
    Game.stage:addChild(BinText)
    --BinText:setLayer(9999999)
    BinText.visible = false
end

-- I'm still sorry
function Map:onEnter()
    Mod:createBinUI()
end

-- hee hee  -Char
function Mod:postUpdate()
    if TextInput.active then
        if #Mod.binInput[1] < 8 then
            BinText:setText(Mod.binInput[1].."_")
        else
            BinText:setText(Mod.binInput[1])
        end
    end
end

-- Wavy VFX

Mod.wave_shader = love.graphics.newShader([[
    extern number wave_sine;
    extern number wave_mag;
    extern number wave_height;
    extern vec2 texsize;
    vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
    {
        number i = texture_coords.y * texsize.y;
        vec2 coords = vec2(max(0.0, min(1.0, texture_coords.x + (sin((i / wave_height) + (wave_sine / 30.0)) * wave_mag) / texsize.x)), max(0.0, min(1.0, texture_coords.y + 0.0)));
        return Texel(texture, coords) * color;
    }
]])