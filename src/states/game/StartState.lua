StartState = Class{__includes = BaseState}

function StartState:init()
    gSounds['intro-music']:play()
end

function StartState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds['intro-music']:stop()

        gStateStack:pop()
        
        gStateStack:push(CityState())

    end
end


function StartState:render()
    love.graphics.draw(gTextures['background'], 0, 0, 0, 
    VIRTUAL_WIDTH / gTextures['background']:getWidth(),
    VIRTUAL_HEIGHT / gTextures['background']:getHeight())

    love.graphics.setColor(230/255, 230/255, 250/255, 1)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('DUNGEON KNIGHT', 0, VIRTUAL_HEIGHT / 2 - 72, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 68, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])

    love.graphics.setColor(1, 1, 1, 1)
end