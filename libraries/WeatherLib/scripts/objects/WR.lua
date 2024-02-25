local WR, super = Class(Object)

function WR:init()
    super.init(self)
    self.weather = {}

    for _,path,weather in Registry.iterScripts("objects/weather") do
        weather.id = weather.id or path
        self.weather[weather.id] = weather
    end
end

function WR:createWeather(id, ...)
    if self.weather[id] then return self.weather[id] else error("This weather ("..id..") doesnt exist") end
end

return WR