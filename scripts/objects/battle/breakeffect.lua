local BreakEffect, super = Class(Object)

function BreakEffect:init(texture, x, y, after)
    super.init(self, x, y)

    if type(texture) == "string" then
        texture = Assets.getTexture(texture) or (Assets.getFrames(texture)[1])
    end
    self.texture = texture

    self.start_color = {1, 1, 1}
    self.red_timer = 0

    self.done = false
    self.after_func = after

    self.width, self.height = texture:getWidth(), texture:getHeight()
    if self.width >= 100 or self.height >= 100 then
        self.block_size = 16
    elseif self.width >= 50 or self.height >= 50 then
        self.block_size = 8
    end
    self.blocks_x = 2
    self.blocks_y = 2
    self.blocks = {}
    for i = 0, self.blocks_x do
        self.blocks[i] = {}
        for j = 0, self.blocks_y do
            local block = {}

            local qx = (i * self.width/2)
            local qy = (j * self.height/2)
            local qw = Utils.clamp(self.width/2, 0, self.width - qx)
            local qh = Utils.clamp(self.height/2, 0, self.height - qy)

            block.quad = love.graphics.newQuad(qx, qy, qw, qh, self.width, self.height)
			
			block.dir=0
			if(i==0)and(j==0)then
				block.dir=math.rad(-45)-math.rad(90)
			elseif(i==0)and(j==1)then
				block.dir=math.rad(-45)-math.rad(180)
			elseif(i==1)and(j==0)then
				block.dir=math.rad(-45)-math.rad(360)
			else
				block.dir=math.rad(-45)-math.rad(270)
			end
            block.x = (i * self.width/2)
			block.y=(j*self.height/2)
            block.speed = 2
            block.timer=0

            self.blocks[i][j] = block
        end
    end
end

function BreakEffect:onAdd(parent)
    super.onAdd(self, parent)

    self.start_color = self.color
end

function BreakEffect:update()
    for i = 0, self.blocks_x do
        for j = 0, self.blocks_y do
            local block = self.blocks[i][j]
            block.timer = block.timer + DTMULT
            block.x = block.x + block.speed * DTMULT * math.cos(block.dir)
			block.y = block.y + block.speed * DTMULT * math.sin(block.dir)
        end
    end

    if self.blocks[0][self.blocks_y].timer >= 5 then
        self.done = true
        if self.after_func then
            self.after_func()
        end
        self:remove()
    end

    super.update(self)
end

function BreakEffect:draw()
    local r, g, b, a = self:getDrawColor()

    for i = 0, self.blocks_x do
        for j = 0, self.blocks_y do
            local block = self.blocks[i][j]
            love.graphics.setColor(r, g, b, a * (1.5 - (block.timer / 5)))
            love.graphics.draw(self.texture, block.quad, block.x, block.y)
        end
    end

    super.draw(self)
end

return BreakEffect