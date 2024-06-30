---@class Quicktime : Object
---@overload fun(...) : Quicktime
local Quicktime, super = Class(Object)

function Quicktime:init(user, target)
    super.init(self, 0, 0)

    self.target = target

    self.caster = user
    self.font = Assets.getFont("main")
    local rbm = {"z", "x"}
--, "c", "w", "a", "s", "d"

    local meth = love.math.random(4, 10)*2

    self.limit = meth

    for i = 1, self.limit do
        self["n"..i.."n"] = Utils.pick(rbm)
    end

    local halfLimit = self.limit / 2

    self.startX = 200 + (halfLimit - 10) * (-15)

    self.hits = 1

    self.timer = 0
    self.thing = 5
    self.power = meth*5
    self.init = 0
end

function Quicktime:endme()
    self.danceoff:stop()
    Game.battle.music:fade(1, 0.25)
    Game.battle:finishAction()
    Assets.playSound("bookspin")
    Assets.playSound("spellcast")
    self:remove()
end

function Quicktime:idiot()
    self.danceoff:stop()
    Game.battle.music:fade(1, 0.25)
    Assets.playSound("explosion")
    Assets.playSound("badexplosion")
    self.target:hurt(self.power)
    self.caster:hurt(5)
    Game.battle:finishAction()
    self:remove()
end

function Quicktime:idiot2()
    self.danceoff:stop()
    Game.battle.music:fade(1, 0.25)
    Assets.playSound("explosion")
    Assets.playSound("badexplosion")
    self.caster:hurt(5)
    Game.battle:finishAction()
    self:remove()
end

function Quicktime:count()
    self.hits = self.hits + 1
    Assets.playSound("noise")
    Assets.playSound("ui_move")
end

function Quicktime:update()
    super.update(self)

    local click = Input.pressed("x") or Input.pressed("z")

    for i = 1, self.limit do
        if self.hits == i then
            if Input.pressed(self["n"..i.."n"]) then
                self:count()
                if i == self.limit then
                    self.target:heal(self.power)
                    self:endme()
                end
            elseif click then
                self:idiot()
            end
            break
        end
    end
    if self.thing < 0 then
        self:idiot2()
    end
end

function Quicktime:draw()
    love.graphics.setFont(self.font)
    local shakeAmount = 2

    Draw.setColor(Utils.hslToRgb((Kristal.getTime()/2) % 1, 1, 0.5))
    love.graphics.rectangle("fill", 160, 110, self.thing*70, 15)
    love.graphics.circle("line", 320, 190, self.thing*60)
    --Draw.setColor(1, 1, 1, 1)

    love.graphics.print("UH! OH! QUICK TIME EVENT", 180, 120)

    local halfLimit = self.limit / 2  -- Calculate half of the limit
    local spacingX = 20
    local spacingY = 30

    local startY = 150

    for i = 1, self.limit do
        local row = math.ceil(i / halfLimit)
        local col = (i - 1) % halfLimit + 1
        local x = self.startX + (col - 1) * spacingX
        local y = startY + (row - 1) * spacingY
        
        x = x + love.math.random(-shakeAmount, shakeAmount)
        y = y + love.math.random(-shakeAmount, shakeAmount)
        
        if self.hits <= i then
            love.graphics.print(self['n'..i..'n'], x, y)
        end
    end

    love.graphics.print("YOU HAVE "..self.limit + 1 - self.hits.." REMAINING", 190, 220)

    if self.init == 0 then
        self.init = 1
        self.danceoff = Music("danceparty", 1, 1.5)
        Game.battle.music:fade(0.3, 0.1)
        Game.battle.timer:tween(6, self, {thing = -1})
    end
    Draw.setColor(1, 1, 1, 1)
    super.draw(self)
end
return Quicktime