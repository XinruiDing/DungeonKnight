PlayerStatsState = Class{__includes = BaseState}

function PlayerStatsState:init(player)
    self.player = player
end

function PlayerStatsState:update(dt)
    if love.keyboard.wasPressed('q') then
        gStateStack:pop()
    end
end

function PlayerStatsState:render()
    love.graphics.setColor(0, 0, 0, 0.8)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Player Stats', 0, 10, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf('MaxHealth: ' .. self.player.maxHealth, 0, 40, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Wealth: ' .. self.player.wealth, 0, 60, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Sword: ' .. self.player.weaponName, 0, 80, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Q to close', 0, VIRTUAL_HEIGHT - 30, VIRTUAL_WIDTH, 'center')
end