local WerewireTextbox, super = Class(Sprite)

function WerewireTextbox:init(x, y)
    super:init(self, "bubbles/werewire/bubble", x, y)

    self:setScale(2, 2)
    self:setOrigin(1, 0)

    self.done = false

    self.wait_timer = 15/30

    self.siner = 0
    self.letter_siner = 0

    local letter_options = {"z", "t", "exclaim", "b", "g"}

    self.letters = {"z", "z", "t", "exclaim"}
    for i = 1, 3 do
        self.letters[i] = Utils.pick(letter_options)
    end
    if Utils.random() < 0.66 then
        self.letters[1] = "z"
    end

    local preset_rand = Utils.random()
    if preset_rand < 0.25 then
        self.letters = {"z", "z", "t", "exclaim"}
    elseif preset_rand < 0.5 then
        self.letters = {"b", "z", "z", "exclaim"}
    end
end

function WerewireTextbox:advance()
    if self.wait_timer == 0 then
        self.done = true
        self:remove()
    end
end

function WerewireTextbox:isTyping()
    return false
end

function WerewireTextbox:isDone()
    return self.done
end

function WerewireTextbox:onAddToStage(stage)
    super:onAddToStage(self, stage)

    Assets.playSound("electric_talk")
end

function WerewireTextbox:update()
    self.wait_timer = Utils.approach(self.wait_timer, 0, DT)

    if Input.pressed("confirm") or Input.down("menu") then
        self:advance()
    end

    self.letter_siner = self.letter_siner + 0.2 * DTMULT

    self.siner = self.siner + DTMULT
    self.y = self.y + (math.sin(self.siner / 8) * 0.1) * DTMULT
end

function WerewireTextbox:draw()
    super:draw(self)

    local r,g,b,a = self:getDrawColor()

    Draw.setColor(1, 1, 1, a)
    for i = 1, #self.letters do
        local frames = Assets.getFramesOrTexture("bubbles/werewire/text_"..self.letters[i])
        local texture = frames[(math.floor(self.letter_siner) % #frames) + 1]

        local letter_x = (i - 1) * 10   + Utils.random()
        local letter_y = (i - 1) * -3.5 + Utils.random() + math.sin((i - 1) / 2 + (self.siner / 3)) / 2

        Draw.draw(texture, letter_x, letter_y)
    end
end

return WerewireTextbox