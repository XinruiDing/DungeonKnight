--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Entity = Class{}

function Entity:init(def)
    self.direction = 'down'

    self.animations = self:createAnimations(def.animations)

    self.width = def.width
    self.height = def.height

    self.x = def.x

    self.y = def.y

    if def.walkSpeed then
        self.walkSpeed = self:decideWalkSpeed(def.walkSpeed) or PLAYER_WALK_SPEED
    else 
        self.walkSpeed = PLAYER_WALK_SPEED
    end

    self.health = def.health

    self.type = def.type or nil

end

function Entity:changeAnimation(name)
    self.currentAnimation = self.animations[name]
end

function Entity:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture or 'entities',
            frames = animationDef.frames,
            interval = animationDef.interval
        }
    end

    return animationsReturned
end

function Entity:decideWalkSpeed(state)
    local speedReturned = 10  -- Default speed
    if self.walkSpeed and self.walkSpeed[state] then
        speedReturned = self.walkSpeed[state]
    end
    return speedReturned
end


function Entity:changeState(name)
    self.stateMachine:change(name)
end

function Entity:collides(target)
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                self.y + self.height < target.y or self.y > target.y + target.height)
end

function Entity:damage(dmg)
    self.health = self.health - dmg
end

function Entity:onInteract()
    return self.interactFlag
end

function Entity:processAI(params, dt)
    self.stateMachine:processAI(params, dt)
end

function Entity:update(dt)
    self.currentAnimation:update(dt)
    self.stateMachine:update(dt)
end

function Entity:render()
    self.stateMachine:render()
end