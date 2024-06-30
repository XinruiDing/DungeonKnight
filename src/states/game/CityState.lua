CityState = Class{__includes = BaseState}

function CityState:init(def)
    self.city = City(def)

    gSounds['intro-music']:setLooping(true)
    gSounds['intro-music']:play()

end

function CityState:update(dt)
    self.city:update(dt)
end

function CityState:render()
    self.city:render()
end



