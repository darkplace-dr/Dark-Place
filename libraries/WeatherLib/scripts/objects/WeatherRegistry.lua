local WeatherRegistry = {}

local self = WeatherRegistry

function WeatherRegistry.init()
    self.initWeatherData()
end

function WeatherRegistry.getWeatherData(id)
    return self.weather[id]
end

function WeatherRegistry.createWeatherData(id, ...)
    if self.weather[id] then
        return self.weather[id](...)
    else
        error("Attempt to create nonexistent weather: "..id)
    end
end

function WeatherRegistry.registerWeatherData(id, weather)
    self.weather[id] = weather
end

function WeatherRegistry.initWeatherData()
    self.weather = {}

    for _,path,weather in Registry.iterScripts("objects/weather") do
        weather.id = weather.id or path
        self.registerWeatherData(weather.id, weather)
    end
end


return WeatherRegistry