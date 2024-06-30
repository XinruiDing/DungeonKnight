EntityIdleState = Class{__includes = EntityBaseState}

function EntityIdleState:init(entity)
    self.entity = entity
    self.entity:changeAnimation('idle')

    self.waitDuration = 2
    self.waitTimer = 0

end

function EntityIdleState:processAI(params, dt)
    self.waitTimer = self.waitTimer + dt

    if self.waitTimer > self.waitDuration then
        self.entity:changeState('walk')
    end
end

