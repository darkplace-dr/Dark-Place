local PurpleGrass, super = Class(Event)

function PurpleGrass:init(x, y, w, h)
    super.init(self, x, y, w, h)

    self.frames = Assets.getFrames("world/maps/chapter1/darkgrass")
    self.solid = false

    self.tiles_x = math.floor(self.width/40)
    self.tiles_y = math.floor(self.height/40)

    self.time = 0
    self.frame = 1
    self.speed = 0.2
end

function PurpleGrass:update()
    self.time = self.time + (self.speed * DTMULT)

    self.frame = math.floor(self.time) + 1
	
    if self.frame > #self.frames then
        self.frame = 1
        self.time = 0
    end

    super.update(self)
end

function PurpleGrass:draw()
    for i = 1, self.tiles_x do
        for j = 1, self.tiles_y do
            Draw.draw(self.frames[self.frame], (i - 1) * 40, (j - 1) * 40, 0, 1, 1)
        end
    end

    super.draw(self)
end

return PurpleGrass