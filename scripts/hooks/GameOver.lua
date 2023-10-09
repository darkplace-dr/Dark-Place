---@class GameOver
local GameOver, super = Class("GameOver")

function GameOver:init(x, y, force_message)
	super.init(self, x, y)

	self.force_message = force_message
end

function GameOver:update()
    super.super.update(self)

    self.timer = self.timer + DTMULT
    if (self.timer >= 30) and (self.current_stage == 0) then
        self.screenshot = nil
        self.current_stage = 1
    end
    if (self.timer >= 50) and (self.current_stage == 1) then
        Assets.playSound("break1")
        self.soul:setSprite("player/heart_break")
        self.current_stage = 2
    end
    if (self.timer >= 90) and (self.current_stage == 2) then
        Assets.playSound("break2")

        local shard_count = 6
        local x_position_table = {-2, 0, 2, 8, 10, 12}
        local y_position_table = {0, 3, 6}

        self.shards = {}
        for i = 1, shard_count do 
            local x_pos = x_position_table[((i - 1) % #x_position_table) + 1]
            local y_pos = y_position_table[((i - 1) % #y_position_table) + 1]
            local shard = Sprite("player/heart_shard", self.soul.x + x_pos, self.soul.y + y_pos)
            shard:setColor(self.soul:getColor())
            shard.physics.direction = math.rad(Utils.random(360))
            shard.physics.speed = 7
            shard.physics.gravity = 0.2
            shard:play(5/30)
            table.insert(self.shards, shard)
            self:addChild(shard)
        end

        self.soul:remove()
        self.soul = nil
        self.current_stage = 3
    end
    if (self.timer >= 140) and (self.current_stage == 3) then
        if Game:isLight() then
            self.fader_alpha = 0
            self.current_stage = 4
        else
            self.fader_alpha = (self.timer - 140) / 10
            if self.fader_alpha >= 1 then
                for i = #self.shards, 1, -1 do
                    self.shards[i]:remove()
                end
                self.shards = {}
                self.fader_alpha = 0
                self.current_stage = 4
            end
        end
    end
    if (self.timer >= 150) and (self.current_stage == 4) then
        self.music:play(Game:isLight() and "determination" or "AUDIO_DEFEAT")
        if Game:isLight() then
            self.text = Sprite("ui/gameover_ut", 111, 32)
        else
            self.text = Sprite("ui/gameover", 0, 40)
            self.text:setScale(2)
        end
        self.alpha = 0
        self:addChild(self.text)
        self.text:setColor(1, 1, 1, self.alpha)
        self.current_stage = 5
    end
    if ((self.timer >= (Game:isLight() and 230 or 180))) and (self.current_stage == 5) then
        local options = {}
        local main_chara = Game:getSoulPartyMember()
        for _, member in ipairs(Game.party) do
            if member ~= main_chara and member:getGameOverMessage(main_chara) then
                table.insert(options, member)
            end
        end
        if #options == 0 then
            if Game:isLight() then
                if Input.pressed("confirm") or Input.pressed("menu") then
                    self.music:fade(0, 2)
                    self.current_stage = 10
                    self.timer = 0
                end
            else
                self.current_stage = 7
            end
        else
            local member = Utils.pick(options)
            local voice = member:getActor().voice or "default"
            self.lines = {}
            for _,dialogue in ipairs(member:getGameOverMessage(main_chara)) do
                local spacing = Game:isLight() and 6 or 8
                local full_line = "[speed:0.5][spacing:"..spacing.."][voice:"..voice.."]"
                local lines = Utils.split(dialogue, "\n")
                for i,line in ipairs(lines) do
                    if i > 1 then
                        full_line = full_line.."\n  "..line
                    else
                        full_line = full_line.."  "..line
                    end
                end
                table.insert(self.lines, full_line)
            end
            if self.force_message then
            	if type(self.force_message)=="table" then
            		for i, message in ipairs(self.force_message) do
            			self.force_message[i] = "[speed:0.5][spacing:"..(Game:isLight() and 6 or 8).."]"..message
            		end
            	else
            		self.lines = {"[speed:0.5][spacing:"..(Game:isLight() and 6 or 8).."]"..self.force_message}
            	end
            end
            self.dialogue = DialogueText(self.lines[1], Game:isLight() and 114 or 100, Game:isLight() and 320 or 300, {style = "none"})
            if Game:isLight() then
                self.dialogue.skippable = false
                self.dialogue.line_offset = 8
                table.insert(self.lines, "")
            else
                self.dialogue.skip_speed = true
                self.dialogue.line_offset = 14
            end
            self:addChild(self.dialogue)
            table.remove(self.lines, 1)
            self.current_stage = 6
        end
    end
    if (self.current_stage == 6) and Input.pressed("confirm") and (not self.dialogue:isTyping()) then
        if #self.lines > 0 then
            self.dialogue:setText(self.lines[1])
            self.dialogue.line_offset = 14
            table.remove(self.lines, 1)
        else
            self.dialogue:remove()
            self.current_stage = 7
            if Game:isLight() then
                self.music:fade(0, 2)
                self.current_stage = 10
                self.timer = 0
            end
        end
    end

    if (self.current_stage == 7) then
        self.choicer = GonerChoice(160, 360, {
            {{"CONTINUE",0,0},{"GIVE UP",220,0}}
        })
        self:addChild(self.choicer)
        self.current_stage = 8
    end

    if (self.current_stage == 8) then
        if self.choicer.choice then
            self.music:stop()

            if self.choicer.choice_x == 1 then
                self.current_stage = 9
                self.timer = 0
            elseif self.choicer.choice_x == 2 then
                self.text:remove()
                self.current_stage = 20

                self.dialogue = DialogueText("[noskip][speed:0.5][spacing:8][voice:none] THEN THE WORLD[wait:30] \n WAS COVERED[wait:30] \n IN DARKNESS.", 120, 160, {style = "GONER", line_offset = 14})
                self:addChild(self.dialogue)
            end
        end
    end

    if (self.current_stage == 9) then
        if (self.timer >= 30) then
            self.timer = 0
            self.current_stage = 10
            local sound = Assets.newSound("dtrans_lw")
            sound:play()
            self.fade_white = true

            
            -- I, SAD DIAMOND MAN, DIDDY THE FUNNY
            local funnytitle = love.math.random(1, 13)

            local scriptPath = debug.getinfo(1).source:match("@(.*)$")
            local folderPath = scriptPath:match("(.*[/\\])")
            folderPath = folderPath:gsub("[/\\]", "/")

            if funnytitle <= 1 then
                love.window.setTitle("Deltarune")
                ico = love.image.newImageData(folderPath ..'/funnyicons/icon_1.png')
                love.window.setIcon(ico)
                --Player2 = require(folderPath ..'scripts.objects.player2')

            elseif funnytitle <= 2 then
                love.window.setTitle("Half-Life")
                ico = love.image.newImageData(folderPath ..'/funnyicons/icon_2.png')
                love.window.setIcon(ico)

            elseif funnytitle <= 3 then
                love.window.setTitle("* GOD damnit KRIS where the HELL are WE!?")
                ico = love.image.newImageData(folderPath ..'/funnyicons/icon_3.png')
                love.window.setIcon(ico)

            elseif funnytitle <= 4 then
                love.window.setTitle("* GOD damn YOU where the HELL are WE!?")
                ico = love.image.newImageData(folderPath ..'/funnyicons/icon_4.png')
                love.window.setIcon(ico)

            elseif funnytitle <= 5 then
                love.window.setTitle("* SO, I have no fucking clue where we are.")
                ico = love.image.newImageData(folderPath ..'/funnyicons/icon_5.png')
                love.window.setIcon(ico)

            elseif funnytitle <= 6 then
                love.window.setTitle("* z...z.....z.....z.......Z.........Z")
                ico = love.image.newImageData(folderPath ..'/funnyicons/icon_6.png')
                love.window.setIcon(ico)

            elseif funnytitle <= 7 then
                love.window.setTitle("Kristale")
                ico = love.image.newImageData(folderPath ..'/funnyicons/icon_7.png')
                love.window.setIcon(ico)

            elseif funnytitle <= 8 then
                love.window.setTitle("* WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT? WHAT?")
                ico = love.image.newImageData(folderPath ..'/funnyicons/icon_8.png')
                love.window.setIcon(ico)

            elseif funnytitle <= 9 then
                love.window.setTitle("Kris Tea")
                ico = love.image.newImageData(folderPath ..'/funnyicons/icon_9.png')
                love.window.setIcon(ico)

            elseif funnytitle <= 10 then
                love.window.setTitle("* REDDIT GOLD POG!!")
                ico = love.image.newImageData(folderPath ..'/funnyicons/icon_10.png')
                love.window.setIcon(ico)

            elseif funnytitle <= 11 then
                love.window.setTitle("LOOK ITS BrACON and MEGALORE!!!")
                ico = love.image.newImageData(folderPath ..'/funnyicons/icon_11.png')
                love.window.setIcon(ico)

            elseif funnytitle <= 12 then
                love.window.setTitle("...")
                ico = love.image.newImageData(folderPath ..'/funnyicons/icon_12.png')
                love.window.setIcon(ico)

            elseif funnytitle <= 13 then
                love.window.setTitle("Kristal")
                ico = love.image.newImageData(folderPath ..'/funnyicons/icon_13.png')
                love.window.setIcon(ico)
            else
                love.window.setTitle("Depa Runts")
            end
            --love.window.setTitle("Spamton Sweepstakes")
        end
    end

    if (self.current_stage == 10) then
        self.fade_white = not Game:isLight()
        self.fader_alpha = self.fader_alpha + ((Game:isLight() and 0.02 or 0.01) * DTMULT)
        if self.timer >= (Game:isLight() and 80 or 120) then
            self.current_stage = 11
            Game:loadQuick()
        end
    end

    if (self.current_stage == 20) and Input.pressed("confirm") and (not self.dialogue:isTyping()) then
        self.dialogue:remove()
        self.music:play("AUDIO_DARKNESS")
        self.music.source:setLooping(false)
        self.current_stage = 21
    end

    if (self.current_stage == 21) and (not self.music:isPlaying()) then
        if Kristal.getModOption("hardReset") then
            love.event.quit("restart")
        else
            Kristal.returnToMenu()
        end
        self.current_stage = 0
    end

    if ((self.timer >= 80) and (self.timer < 150)) then
        if Input.pressed("confirm") then
            self.skipping = self.skipping + 1
        end
        if (self.skipping >= 4) then
            if self.force_message and self.force_message == "EH HE EH HE!![wait:5]\nHAPPY NOW??" then
                local succ, err = love.filesystem.write("saves/"..Mod.info.id.."/ikilledyouoncedidn'ti_"..Game.save_id, "2")
                if not succ then
                    print("Writing error: "..err)
                end
                Game:setFlag("skipped_jeku", true)
            end
            Game:loadQuick()
        end
    end

    if self.text then
        self.alpha = self.alpha + (0.02 * DTMULT)
        self.text:setColor(1, 1, 1, self.alpha)
    end
end
--local bonkrr = love.math.random(27, 30)
--if bonkrr <= 27 then
return GameOver