PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') then
        self.entity:changeState('walk')
    elseif love.keyboard.isDown('right') then
        self.entity:changeState('walk')
    elseif love.keyboard.isDown('up') then
        self.entity:changeState('walk')
    elseif love.keyboard.isDown('down') then
        self.entity:changeState('walk')
    end

    if love.keyboard.wasPressed('space') and gStateStack:getCurrentState().__index == DungeonState and not self.entity.sword.isActive then
        self.entity.sword:throw()
    end

end