City = Class{}

function City:init()
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    self.renderOffsetX = MAP_RENDER_OFFSET_X
    self.renderOffsetY = MAP_RENDER_OFFSET_Y

    self.adjacentOffsetX = 0
    self.adjacentOffsetY = 0

    self.tiles = {}
    self:generateWallsAndFloors()

    self.entities = {}
    self:generateEntities()

    self.player = Player {
        animations = ENTITY_DEFS['player'].animations,
        x = 100 + MAP_RENDER_OFFSET_X,
        y = 100 + MAP_RENDER_OFFSET_Y,
        width = 16,
        height = 32,
        health = 10,
    }

    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player, self) end,
        ['idle'] = function() return PlayerIdleState(self.player) end
    }
    self.player.stateMachine:change('idle')

end

function City:generateWallsAndFloors()
    for y = 1, self.height do
        table.insert(self.tiles, {})

        for x = 1, self.width do
            local id = TILE_EMPTY
            local frame = nil

            if x == 1 and y == 1 then
                id = TILE_TOP_LEFT_CORNER
                frame = 'low-wall'
            elseif x == 1 and y == self.height then
                id = TILE_BOTTOM_LEFT_CORNER
                frame = 'low-wall'
            elseif x == self.width and y == 1 then
                id = TILE_TOP_RIGHT_CORNER
                frame = 'low-wall'
            elseif x == self.width and y == self.height then
                id = TILE_BOTTOM_RIGHT_CORNER
                frame = 'low-wall'
            
            -- random left-hand walls, right walls, top, bottom, and floors
            elseif x == 1 then
                id = TILE_LEFT_WALLS
                frame = 'low-wall'
            elseif x == self.width then
                id = TILE_RIGHT_WALLS
                frame = 'low-wall'
            elseif y == 1 then
                id = TILE_TOP_WALLS
                frame = 'low-wall'
            elseif y == self.height then
                id = TILE_BOTTOM_WALLS
                frame = 'low-wall'
            else
                id = SAFE_FLOORS[math.random(#SAFE_FLOORS)]
                frame = 'floor'
            end
            
            table.insert(self.tiles[y], {
                id = id,
                frame = frame
            })
        end
    end
end

function City:generateEntities()
    local types = {'charm-merchant', 'mask-merchant', 'weapon-merchant'}

    for i = 1, #types do

        local type = types[i]

        table.insert(self.entities, Entity {
            animations = ENTITY_DEFS[type].animations,

            -- ensure X and Y are within bounds of the map
            x = MAP_RENDER_OFFSET_X + 20,
            y = MAP_RENDER_OFFSET_Y + 30 * (i - 1),
            
            width = 16,
            height = 32,

            health = 999
        })

        self.entities[i].stateMachine = StateMachine {
            ['idle'] = function() return EntityIdleState(self.entities[i]) end
        }

        self.entities[i]:changeState('idle')
    end
end


function City:update(dt)
    self.player:update(dt)

    for k, entity in pairs(self.entities) do
        entity:update(dt)

        if self.player:collides(entity) then
            if self.player.direction == 'left' then
                self.player.x = self.player.x + PLAYER_WALK_SPEED * dt
                self.player:changeState('idle')
            elseif self.player.direction == 'right' then
                self.player.x = self.player.x - PLAYER_WALK_SPEED * dt
                self.player:changeState('idle')
            elseif self.player.direction == 'up' then
                self.player.y = self.player.y + PLAYER_WALK_SPEED * dt
                self.player:changeState('idle')
            else
                self.player.y = self.player.y - PLAYER_WALK_SPEED * dt
                self.player:changeState('idle')
            end

            gStateStack:push(DialogueState('Buy Something?',
                function ()
                    gStateStack:push(SelectState(
                        {'cancel', 'buy a musk'}, self
                    ))
                end
            ))
        end
    end
end

function City:render()
    for y = 1, self.height do
        for x = 1, self.width do
            local tile = self.tiles[y][x]
            love.graphics.draw(gTextures[tile.frame], gFrames[tile.frame][tile.id],
                (x - 1) * TILE_SIZE + self.renderOffsetX + self.adjacentOffsetX, 
                (y - 1) * TILE_SIZE + self.renderOffsetY + self.adjacentOffsetY)
        end
    end

    self.player:render()

    for k, entity in pairs(self.entities) do
        entity:render()
    end

end