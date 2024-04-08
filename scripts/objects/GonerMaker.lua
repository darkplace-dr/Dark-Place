local PART = {}
local PARTMAX = {}
local PARTX = {}
local IDEALX = {}
local LOCK = {}
local sy = {}

local GonerMaker, super = Class(Object)

function GonerMaker:init(x, y)
    super.init(self, x, y)
	
    self.layer = 9999

    self.HEAD = 0
    self.BODY = 0
    self.LEGS = 0
	
    self.HEADMAX = 8
    self.BODYMAX = 6
    self.LEGSMAX = 2
	
    PART[1] = Game:getFlag("DEVICE_HEAD", 0)  --global.flag[900]
    PART[2] = Game:getFlag("DEVICE_BODY", 0)  --global.flag[901]
    PART[3] = Game:getFlag("DEVICE_LEGS", 0)  --global.flag[902]
	
    IDEALX[1] = 8
    IDEALX[2] = 6
    IDEALX[3] = 5
	
    self.s = 0
    self.offx = 0
    self.movetimer = 0
	
    PARTX[1] = 0
    IDEALX[1] = 0
    PARTX[2] = 0
    IDEALX[2] = 0
    PARTX[3] = 0
    IDEALX[3] = 0
	
    for i = 1, 3 do
        IDEALX[i] = PART[i] * -50
        PARTX[i] = IDEALX[i]
    end

    LOCK[1] = false
    LOCK[2] = false
    LOCK[3] = false

    sy[1] = 0
    sy[2] = 34
    sy[3] = 60

    self.siner = 0
    self.obacktimer = 0
    self.OB_DEPTH = 0
    self.flashtimer = 0
    self.midscreenx = SCREEN_WIDTH / 2
    self.midscreeny = SCREEN_HEIGHT / 2
	
    self.STEP = 1
    self.FINISH = false
    self.ONEBUFFER = 10
    self.FADEBUFFER = 10
    self.CANCEL = false

    self.init_x = self.x
    self.init_y = self.y
	
-- og Deltarune code
--[[

HEAD = 0
BODY = 0
LEGS = 0
HEADMAX = 7
BODYMAX = 5
LEGSMAX = 1
PART[0] = global.flag[900]
PART[1] = global.flag[901]
PART[2] = global.flag[902]
PARTMAX[0] = 7
PARTMAX[1] = 5
PARTMAX[2] = 4
s = 0
offx = 0
movetimer = 0
PARTX[0] = 0
IDEALX[0] = 0
PARTX[1] = 0
IDEALX[1] = 0
PARTX[2] = 0
IDEALX[2] = 0
for (i = 0; i < 3; i += 1)
{
    IDEALX[i] = (PART[i] * -50)
    PARTX[i] = IDEALX[i]
}
LOCK[0] = false
LOCK[1] = false
LOCK[2] = false
sy[0] = 0
sy[1] = 34
sy[2] = 60
siner = 0
obacktimer = 0
OB_DEPTH = 0
flashtimer = 0
midscreenx = (__view_get((0 << 0), 0) + (__view_get((2 << 0), 0) / 2))
midscreeny = (__view_get((1 << 0), 0) + (__view_get((3 << 0), 0) / 2))
STEP = 1
FINISH = false
ONEBUFFER = 10
FADEBUFFER = 10
CANCEL = false
initx = x
inity = y

]]
end

function GonerMaker:update()
    super.update(self)
	
    self.siner = self.siner + DTMULT

    self.x = self.init_x + (math.sin((self.siner / 24)) * 2)
    self.y = self.init_y + (math.cos((self.siner / 30)) * 2)
	
    if self.FINISH == false and self.ONEBUFFER < 0 and self.CANCEL == false then
        -- TODO: Pressing left or right crashed the mod for some reason. Gotta figure out why.
        if Input.keyPressed("left") then
            PART[self.s] = PART[self.s] - 1
        end
        if Input.keyPressed("right") then
            PART[self.s] = PART[self.s] + 1
        end
        if Input.keyPressed("confirm") and LOCK[self.s] == true then
            self.FINISH = true
            Game:setFlag("DEVICE_HEAD", PART[self.s])
            Game:setFlag("DEVICE_BODY", PART[self.s])
            Game:setFlag("DEVICE_LEGS", PART[self.s])
            --global.flag[20] = 1 -- what flag is this in Deltarune???
        end
    end
	
    for i = 1, 3 do
        if PART[i] > IDEALX[i] then
            PART[i] = IDEALX[i]
		end
        if PART[i] < 0 then
            PART[i] = 0
        end
		
        IDEALX[i] = PART[i] * -50
	
        if PARTX[i] < IDEALX[i] then
            if math.abs((IDEALX[i] - PARTX[i])) >= 0 then
                PARTX[i] = PARTX[i] + 10
			end
            if math.abs((IDEALX[i] - PARTX[i])) > 50 then
                PARTX[i] = PARTX[i] + 10
			end
            if math.abs((IDEALX[i] - PARTX[i])) > 100 then
                PARTX[i] = PARTX[i] + 10
			end
            if math.abs((IDEALX[i] - PARTX[i])) > 150 then
                PARTX[i] = PARTX[i] + 10
			end
        end
		
        if PARTX[i] > IDEALX[i] then
            if math.abs((IDEALX[i] - PARTX[i])) >= 0 then
                PARTX[i] = PARTX[i] - 10
			end
            if math.abs((IDEALX[i] - PARTX[i])) > 50 then
                PARTX[i] = PARTX[i] - 10
			end
            if math.abs((IDEALX[i] - PARTX[i])) > 100 then
                PARTX[i] = PARTX[i] - 10
			end
            if math.abs((IDEALX[i] - PARTX[i])) > 150 then
                PARTX[i] = PARTX[i] - 10
			end
        end
		
        if PARTX[i] == IDEALX[i] then
            LOCK[i] = true
        else
            LOCK[i] = false
		end
	end
	
    self.ONEBUFFER = self.ONEBUFFER - DTMULT
	
    if self.FADEBUFFER > 0 and self.FINISH == false then
        self.FADEBUFFER = self.FADEBUFFER - DTMULT
    end
    if self.FINISH == true then
        self.FADEBUFFER = self.FADEBUFFER + DTMULT
    end
    if self.FADEBUFFER > 10 then
        self:remove()
    end
	
-- og Deltarune code
--[[

siner += 1
x = (initx + (sin((siner / 24)) * 2))
y = (inity + (cos((siner / 30)) * 2))
if (FINISH == false && ONEBUFFER < 0 && CANCEL == false)
{
    if left_p()
        PART[s] -= 1
    if right_p()
        PART[s] += 1
    if (button1_p() && LOCK[s] == true)
    {
        FINISH = true
        global.flag[(900 + s)] = PART[s]
        global.flag[20] = 1
    }
}
for (i = 0; i < 3; i += 1)
{
    if (PART[i] > PARTMAX[i])
        PART[i] = PARTMAX[i]
    if (PART[i] < 0)
        PART[i] = 0
    IDEALX[i] = (PART[i] * -50)
    if (PARTX[i] < IDEALX[i])
    {
        if (abs((IDEALX[i] - PARTX[i])) >= 0)
            PARTX[i] += 10
        if (abs((IDEALX[i] - PARTX[i])) > 50)
            PARTX[i] += 10
        if (abs((IDEALX[i] - PARTX[i])) > 100)
            PARTX[i] += 10
        if (abs((IDEALX[i] - PARTX[i])) > 150)
            PARTX[i] += 10
    }
    if (PARTX[i] > IDEALX[i])
    {
        if (abs((IDEALX[i] - PARTX[i])) >= 0)
            PARTX[i] -= 10
        if (abs((IDEALX[i] - PARTX[i])) > 50)
            PARTX[i] -= 10
        if (abs((IDEALX[i] - PARTX[i])) > 100)
            PARTX[i] -= 10
        if (abs((IDEALX[i] - PARTX[i])) > 150)
            PARTX[i] -= 10
    }
    if (PARTX[i] == IDEALX[i])
        LOCK[i] = true
    else
        LOCK[i] = false
}
ONEBUFFER -= 1
if (FADEBUFFER > 0 && FINISH <= false)
    FADEBUFFER -= 1
if (FINISH == true)
    FADEBUFFER += 1
if (FADEBUFFER > 10)
    instance_destroy()

]]
end

function GonerMaker:draw()
    super.draw(self)
	
    local FA = ((10 - self.FADEBUFFER) / 10)
    if FA > 1 then
        FA = 1
	end


    -- TODO: figure out how to get the other parts to display instead of just the first one.
    for k = 1, self.STEP do
        local img = Assets.getTexture("world/cutscenes/intro/vessel/IMAGE_GONERHEAD_1")
        if k == 2 then
            img = Assets.getTexture("world/cutscenes/intro/vessel/IMAGE_GONERBODY_1")
		end
        if k == 3 then
            img = Assets.getTexture("world/cutscenes/intro/vessel/IMAGE_GONERLEGS_1")
		end
        if LOCK[k] == true then
            local s_size = math.abs((math.sin((self.siner / 16)) / 2))
		    local lock_alpha = 0.4 * FA
	        love.graphics.setColor(1, 1, 1, lock_alpha)
            Draw.draw(img, (self.x - ((s_size * img:getWidth()) / 2)), ((self.y + sy[k]) - ((s_size * img:getHeight()) / 2)), 0, (4 + s_size), (4 + s_size))

            local s_size = math.abs((math.sin((self.siner / 21)) / 2))
		    local lock_alpha = 0.4 * FA
	        love.graphics.setColor(1, 1, 1, lock_alpha)
            Draw.draw(img, (self.x - ((s_size * img:getWidth()) / 2)), ((self.y + sy[k]) - ((s_size * img:getHeight()) / 2)), 0, (4 + s_size), (4 + s_size))
        end
    end
	
    if self.CANCEL == false then
		local heart_alpha = 1 * FA
	    love.graphics.setColor(1, 0, 0, heart_alpha)
        Draw.draw(Assets.getTexture("player/heart_blur"), (self.init_x + 10), (self.init_y - 30), 0, 2, 2)
	end

    -- TODO: figure out how to get the other parts to display instead of just the first one.
    for j = 1, self.STEP do
        local img = Assets.getTexture("world/cutscenes/intro/vessel/IMAGE_GONERHEAD_1")
        if j == 2 then
            img = Assets.getTexture("world/cutscenes/intro/vessel/IMAGE_GONERBODY_1")
		end
        if j == 3 then
            img = Assets.getTexture("world/cutscenes/intro/vessel/IMAGE_GONERLEGS_1")
		end
		
        if self.s == j then
            for i = 1, IDEALX[j] do
                local alpha = (1 - (math.abs((PARTX[j] + (i * 50))) / 120))
				local part_alpha = alpha * FA
                Draw.draw(img[i], ((self.x + PARTX[j]) + (i * 50)), (self.y + sy[j]), 0, 4, 4)
             end
        else
		    local part_alpha2 = 1 * FA
	        love.graphics.setColor(1, 1, 1, part_alpha2)
            Draw.draw(img, self.x, (self.y + sy[j]), 0, 4, 4)
        end
    end
--og Deltarune code
--[[

FA = ((10 - FADEBUFFER) / 10)
if (FA > 1)
    FA = 1
for (k = obj_sneo_friedpipis; k < STEP; k += 1)
{
    img = IMAGE_GONERHEAD
    if (k == obj_pipis_bullet_cone)
        img = IMAGE_GONERBODY
    if (k == obj_84_lang_helper)
        img = IMAGE_GONERLEGS
    if (LOCK[k] == true)
    {
        s_size = abs((sin((siner / 16)) / 2))
        draw_sprite_ext(img, PART[k], (x - ((s_size * sprite_width) / 2)), ((y + sy[k]) - ((s_size * sprite_height) / 2)), (2 + s_size), (2 + s_size), 0, c_white, (0.4 * FA))
        s_size = abs((sin((siner / 21)) / 2))
        draw_sprite_ext(img, PART[k], (x - ((s_size * sprite_width) / 2)), ((y + sy[k]) - ((s_size * sprite_height) / 2)), (2 + s_size), (2 + s_size), 0, c_white, (0.4 * FA))
    }
}
if (CANCEL == false)
    draw_sprite_ext(IMAGE_SOUL_BLUR, 0, (initx + 10), (inity - 30), 1, 1, 0, c_white, (1 * FA))
for (j = 0; j < STEP; j += 1)
{
    img = IMAGE_GONERHEAD
    if (j == 1)
        img = IMAGE_GONERBODY
    if (j == 2)
        img = IMAGE_GONERLEGS
    if (s == j)
    {
        for (i = 0; i <= PARTMAX[j]; i += 1)
        {
            alpha = (1 - (abs((PARTX[j] + (i * 50))) / 120))
            draw_sprite_ext(img, i, ((x + PARTX[j]) + (i * 50)), (y + sy[j]), 2, 2, 0, c_white, (alpha * FA))
        }
    }
    else
        draw_sprite_ext(img, PART[j], x, (y + sy[j]), 2, 2, 0, c_white, (1 * FA))
}

]]
end

return GonerMaker