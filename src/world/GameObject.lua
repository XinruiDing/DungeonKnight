--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameObject = Class{}

function GameObject:init(def, x, y)
    
    -- string identifying this object type
    self.type = def.type

    self.texture = def.texture
    self.frame = def.frame or 1

    -- whether it acts as an obstacle or not
    self.solid = def.solid

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    self.isActive = false

    -- dimensions
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height

    self.speed = def.speed or 0

    self.hurt = def.hurt or 1

    -- default empty collision callback
    self.onCollide = function() end
    -- default empty consume callback
    self.onConsume = function() end
end

function GameObject:update(dt)

end

function GameObject:render()
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.states[self.state].frame or self.frame],
        self.x, self.y)
end