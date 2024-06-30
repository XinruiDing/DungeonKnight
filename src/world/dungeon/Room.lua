Room = Class{}

function Room:init(player)
    self.width = MAP_WIDTH
    self.height = MAP_HEIGHT

    self.renderOffsetX = MAP_RENDER_OFFSET_X
    self.renderOffsetY = MAP_RENDER_OFFSET_Y

    self.tiles = {}
    self:generateWallsAndFloors()

    self.entities = {}
    self:generateEntities()

    self.objects = {}
    self:generateObjects()

    self.player = player

    self.player.stateMachine = StateMachine {
        ['walk'] = function() return PlayerWalkState(self.player, self) end,
        ['idle'] = function() return PlayerIdleState(self.player) end
    }
    self.player.stateMachine:change('idle')

end

function Room:generateWallsAndFloors()
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
                id = DUNGEON_FLOORS[math.random(#DUNGEON_FLOORS)]
                frame = 'floor'
            end
            
            table.insert(self.tiles[y], {
                id = id,
                frame = frame
            })
        end
    end
end

function Room:generateEntities()
    local types = {'small-enemy', 
    'shoot-straight-enemy', 
    'shoot-circle-enemy',
    'berserk-enemy',

    }

    local enemyCount = math.random(5, 10)

    for i = 1, enemyCount do

        local type = types[math.random(#types)]

        table.insert(self.entities, Entity {
            animations = ENTITY_DEFS[type].animations,
            walkSpeed = ENTITY_DEFS[type].walkSpeed or 20,

            -- ensure X and Y are within bounds of the map
            x = math.random(MAP_RENDER_OFFSET_X + TILE_SIZE,
                VIRTUAL_WIDTH - TILE_SIZE * 2 - 16),
            y = math.random(MAP_RENDER_OFFSET_Y + TILE_SIZE,
                VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE - 16),
            
            width = 16,
            height = 32,

            health = ENTITY_DEFS[type].health or 1
        })

        self.entities[i].stateMachine = StateMachine {
            ['idle'] = function() return EntityIdleState(self.entities[i]) end,
            ['walk'] = function() return EntityWalkState(self.entities[i], self) end
        }

        self.entities[i]:changeState('idle')

    end
end

function Room:generateObjects()
    local door = GameObject(
        GAME_OBJECT_DEFS['entrance'],
        VIRTUAL_WIDTH / 2 - TILE_SIZE + MAP_RENDER_OFFSET_X, MAP_RENDER_OFFSET_Y)

    door.onCollide = function()
        self.player.interactFlag = true
    end

    table.insert(self.objects, door)

end


function Room:update(dt)
    self.player:update(dt)
    self.player.sword:update(dt)

    for k, entity in pairs(self.entities) do
        if entity.health <= 0 then
            entity.dead = true
        elseif not entity.dead then
            entity:processAI({room = self}, dt)
            entity:update(dt)
        end

        -- collision between the player and entities in the room
        if not entity.dead and self.player:collides(entity) and not self.player.invulnerable then
            self.player:damage(1)
            if self.player.isDead then
                return
            end
            self.player:goInvulnerable(1.5)
        end

        if not entity.dead then
            if self.player.sword.isActive then
                if entity:collides(self.player.sword) and not entity.hitBySword then
                    entity:damage(self.player.sword.hurt)
                    self.player.wealth = self.player.wealth + 5
                    entity.hitBySword = true
                end
            else
                entity.hitBySword = false
            end
            
        end
    end

    for k, object in pairs(self.objects) do
        if self.player:collides(object) then
            -- Calculate overlaps
            local overlapX = math.min(self.player.x + self.player.width, object.x + object.width) - math.max(self.player.x, object.x)
            local overlapY = math.min(self.player.y + self.player.height, object.y + object.height) - math.max(self.player.y, object.y)

            -- Determine the smallest overlap
            if overlapX < overlapY / 2 then
                -- Adjust horizontally based on the player's and entity's relative positions
                if self.player.x < object.x then
                    self.player.x = self.player.x - PLAYER_WALK_SPEED * dt - OVERLAP
                else
                    self.player.x = self.player.x + PLAYER_WALK_SPEED * dt + OVERLAP
                end
            else
                -- Adjust vertically based on the player's and entity's relative positions
                if self.player.y < object.y then
                    self.player.y = self.player.y - PLAYER_WALK_SPEED * dt - OVERLAP
                else
                    self.player.y = self.player.y + PLAYER_WALK_SPEED * dt + OVERLAP
                end
            end
            
            object.onCollide()
        end
    end

end

function Room:render()
    for y = 1, self.height do
        for x = 1, self.width do
            local tile = self.tiles[y][x]
            love.graphics.draw(gTextures[tile.frame], gFrames[tile.frame][tile.id],
                (x - 1) * TILE_SIZE + self.renderOffsetX, 
                (y - 1) * TILE_SIZE + self.renderOffsetY)
        end
    end

    for k, entity in pairs(self.entities) do
        if not entity.dead then
            entity:render()
        end
    end

    for k, object in pairs(self.objects) do
        object:render()
    end

    self.player:render()

    if self.player.sword.isActive then
        self.player.sword:render()
    end

    for i = 1, self.player.health do
        love.graphics.draw(gTextures['gui'], gFrames['gui'][86],
        TILE_SIZE * i, 0)
    end

end