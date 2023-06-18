---@class GameOverSegaForever : Object
local GameOverSF, super = Class(Object)

function GameOverSF:init(my_bars)
    my_bars = my_bars or (not Game:getFlag("s") and love.math.random(1, 1145) == 1145)

    super.init(self, SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 320, 120)

    self:setOrigin(0.5, 0.5)
    self:setScale(my_bars and 1 or 0, my_bars and 1 or 0)
    self.draw_children_below = 0

    self.box = UIBox(0, 0, self.width, self.height)
    self.box.layer = -1
    self:addChild(self.box)
    self.decline_dialogue = nil

    self.music = Music()
    self.timer = Timer()
    self:addChild(self.timer)

    self.screenshot = nil

    self.font = Assets.getFont("main", 32)
    self.font_body = Assets.getFont("plain", 32)

    self.state_manager = StateManager("SHOWING_UP", self, true)
    self.state_manager:addState("SHOWING_UP", { update = self.showingUpUpdate })
    self.state_manager:addState("IDLE", { enter = self.onIdle })
    self.state_manager:addState("CONFIRMED", { enter = self.onConfirm })
    self.state_manager:addState("DECLINED", { enter = self.onDecline, update = self.declineUpdate })

    self.my_bars = my_bars
end

function GameOverSF:onAdd(parent)
    super.onAdd(self, parent)

    local screenshot_img = love.graphics.newImage(SCREEN_CANVAS:newImageData())
    self.screenshot = Sprite(screenshot_img, 0, 0)
    self.screenshot.layer = -2
    if self.my_bars then
        self.screenshot:addFX(RecolorFX(1, 0, 0), "so_edgy")
    end
    parent:addChild(self.screenshot)

    self.timer:after(1/12, function()
        local song = self.my_bars and "TAFFED_OI_DAU" or (Game:isLight() and "determination" or "AUDIO_DEFEAT")
        self.music:play(song, song == "TAFFED_OI_DAU" and 0.8 or 1)
        if self.scale_x == 0 then
            self.graphics.grow = 0.2
        end

        if not self.my_bars then
            self.choicer = GonerChoice(35, 90, {
                {{"YES", 0, 0}, {"NO", 220, 0}}
            })
            self.choicer.on_select = function()
                return false
            end
            self.choicer.on_complete = function(choice)
                self:onChoiceComplete(choice == "YES")
            end
            self:addChild(self.choicer)
        end
    end)
end

function GameOverSF:update()
    super.update(self)

    self.state_manager:update()
end

function GameOverSF:draw()
    love.graphics.setColor(COLORS["white"])

    if not self.my_bars then
        if self.state_manager.state == "SHOWING_UP" or self.state_manager.state == "IDLE" then
            love.graphics.setFont(self.font)
            love.graphics.printf("GAME OVER", 0, 0, self.width, "center")

            love.graphics.setFont(self.font_body)
            love.graphics.printf("Watch an ad to continue?", 0, 55, self.width, "center")
        end

        if self.state_manager.state == "CONFIRMED" then
            -- it would be funny if theres actually ads
            -- idk how to implement it though, using videos doesnt feel right
            love.graphics.setFont(self.font_body)
            love.graphics.printf("I lied there's no ad LOL", 0, 55, self.width, "center")
        end
    else
        love.graphics.setFont(self.font)
        love.graphics.printf("BRUH!! you LOST'd,  LOSER", 0, 0, self.width, "center")

        love.graphics.setFont(self.font_body)
        love.graphics.printf("HAHAhahahahahahahah you did this to your selv\nenjoys the night wares i've given you", 0, 45, self.width, "center")
    end

    self:drawChildren()
end

function GameOverSF:onKeyPressed(key, is_repeated) end

function GameOverSF:setState(state)
    self.state_manager:setState(state)
end

function GameOverSF:showingUpUpdate()
    if self.scale_x >= 1 or Input.pressed("menu") then
        self:setScale(1, 1)
        self.graphics.grow = 0
    end
    if self.scale_x == 1 and (not self.choicer or self.choicer.state == "CHOICE") then
        self:setState(self.my_bars and "CONFIRMED" or "IDLE")
    end
end

function GameOverSF:onIdle()
    self.choicer.on_select = function(choice)
        if choice == "YES" then
            self.choicer.alpha = 0
        end
    end
end

function GameOverSF:onChoiceComplete(continue)
    self:setState(continue and "CONFIRMED" or "DECLINED")
end

function GameOverSF:onConfirm()
    self.music:stop()
    self.timer:script(function(wait)
        wait(self.my_bars and 2 or 1/2.5)

        local explosion = Explosion(self.width/2, self.height/2)
        explosion:setOrigin(0.5, 0.5)
        explosion:setScale(3)
        explosion:setLayer(1)
        self:addChild(explosion)
        wait(0.9)

        Assets.stopSound("badexplosion")
        self:cleanup()
        Game:loadQuick()
    end)
end

function GameOverSF:onDecline()
    self.music:fade(0, 0.08)
    self.screenshot.graphics.fade_to = 0
    self.screenshot.graphics.fade = 0.1
    self.box.graphics.fade_to = 0
    self.box.graphics.fade = 0.1

    self.timer:after(1/1.5, function()
        self.decline_dialogue = DialogueText(
            "[noskip][speed:0.5][spacing:8][voice:none]THEN THE WORLD[wait:30]\nWAS COVERED[wait:30]\nIN DARKNESS.",
            0, 0, {style = "GONER", line_offset = 14}
        )
        self:addChild(self.decline_dialogue)
    end)
end

function GameOverSF:declineUpdate()
    if not self.decline_dialogue then
        return
    end

    if not self.decline_dialogue:isRemoved() then -- how to not add 100000 state variables
        if Input.pressed("confirm") and not self.decline_dialogue:isTyping() then
            self.decline_dialogue:remove()
            self.music:play("AUDIO_DARKNESS", 1)
            self.music.source:setLooping(false)
        end
    else
        if not self.music:isPlaying() then
            if Kristal.getModOption("hardReset") then
                love.event.quit("restart")
            else
                Kristal.returnToMenu()
            end
        end
    end
end

function GameOverSF:cleanup()
    self.screenshot:remove()
    self.music:remove()
end

function GameOverSF:onRemove(parent)
    super.onRemove(self, parent)

    self:cleanup()
end

return GameOverSF