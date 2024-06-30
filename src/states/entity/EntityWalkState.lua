--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

EntityWalkState = Class{__includes = EntityBaseState}

function EntityWalkState:init(entity, level)
    self.entity = entity
    self.bumped = false
    self.level = level

    self.entity:changeAnimation('walk')
    
    self.directionTimer = 0
    self.changeDirectionEvery = 5
    self.currentDirection = {
        x = math.random(-1, 1),
        y = math.random(-1, 1)
    }
end

function EntityWalkState:update(dt)
    
    -- assume we didn't hit a wall
    self.bumped = false

    if self.entity.x <= MAP_RENDER_OFFSET_X + TILE_SIZE then 
        self.entity.x = MAP_RENDER_OFFSET_X + TILE_SIZE
        self.bumped = true
    end

    if self.entity.x + self.entity.width >= VIRTUAL_WIDTH - TILE_SIZE * 2 then
        self.entity.x = VIRTUAL_WIDTH - TILE_SIZE * 2 - self.entity.width
        self.bumped = true
    end

    if self.entity.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE - self.entity.height / 2 then 
        self.entity.y = MAP_RENDER_OFFSET_Y + TILE_SIZE - self.entity.height / 2
        self.bumped = true
    end


    if self.entity.y < MAP_RENDER_OFFSET_Y + TILE_SIZE - self.entity.height / 2 or self.entity.y + self.entity.height > VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) 
    + MAP_RENDER_OFFSET_Y - TILE_SIZE then
        self.entity.y = math.max(MAP_RENDER_OFFSET_Y + TILE_SIZE, math.min(self.entity.y, VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE))
        self.bumped = true
    end

    local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) 
    + MAP_RENDER_OFFSET_Y - TILE_SIZE

    if self.entity.y + self.entity.height >= bottomEdge then
        self.entity.y = bottomEdge - self.entity.height
        self.bumped = true
    end

--[[     -- boundary checking on all sides, allowing us to avoid collision detection on tiles
    if self.entity.direction == 'left' then
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
        
        if self.entity.x <= MAP_RENDER_OFFSET_X + TILE_SIZE then 
            self.entity.x = MAP_RENDER_OFFSET_X + TILE_SIZE
            self.bumped = true
        end
    elseif self.entity.direction == 'right' then
        self.entity.x = self.entity.x + self.entity.walkSpeed * dt

        if self.entity.x + self.entity.width >= VIRTUAL_WIDTH - TILE_SIZE * 2 then
            self.entity.x = VIRTUAL_WIDTH - TILE_SIZE * 2 - self.entity.width
            self.bumped = true
        end
    elseif self.entity.direction == 'up' then
        self.entity.y = self.entity.y - self.entity.walkSpeed * dt

        if self.entity.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE - self.entity.height / 2 then 
            self.entity.y = MAP_RENDER_OFFSET_Y + TILE_SIZE - self.entity.height / 2
            self.bumped = true
        end
    elseif self.entity.direction == 'down' then
        self.entity.y = self.entity.y + self.entity.walkSpeed * dt

        local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) 
            + MAP_RENDER_OFFSET_Y - TILE_SIZE

        if self.entity.y + self.entity.height >= bottomEdge then
            self.entity.y = bottomEdge - self.entity.height
            self.bumped = true
        end
    end
 ]]

end


function EntityWalkState:processAI(params, dt)
    local room = params.room
    local player = room.player
    self.directionTimer = self.directionTimer + dt

    if self.directionTimer > self.changeDirectionEvery or self.bumped then
        -- Introduce more variability in direction changes
        self.currentDirection.x = math.random(-1, 1)
        self.currentDirection.y = math.random(-1, 1)
        self.directionTimer = 0
        self.bumped = false  -- Reset bump flag
    end

    local toPlayerX = player.x - self.entity.x
    local toPlayerY = player.y - self.entity.y
    local distanceToPlayer = math.sqrt(toPlayerX^2 + toPlayerY^2)

    -- Safe normalization with a check to prevent division by zero
    local normalizedToPlayerX = distanceToPlayer > 0 and toPlayerX / distanceToPlayer or 0
    local normalizedToPlayerY = distanceToPlayer > 0 and toPlayerY / distanceToPlayer or 0

    -- Combine weighted player direction and random direction
    local weight = 0.8  -- Stronger weight towards player
    local combinedX = self.currentDirection.x * (1 - weight) + normalizedToPlayerX * weight
    local combinedY = self.currentDirection.y * (1 - weight) + normalizedToPlayerY * weight

    -- Update entity position and handle screen boundaries
    self.entity.x = self.entity.x + combinedX * self.entity.walkSpeed * dt
    self.entity.y = self.entity.y + combinedY * self.entity.walkSpeed * dt

    -- Implement boundary checks (assuming screen limits are known)
    if self.entity.x < MAP_RENDER_OFFSET_X + TILE_SIZE or self.entity.x + self.entity.width > VIRTUAL_WIDTH - TILE_SIZE * 2 then
        self.entity.x = math.max(MAP_RENDER_OFFSET_X + TILE_SIZE, math.min(self.entity.x, VIRTUAL_WIDTH - TILE_SIZE * 2))
        self.currentDirection.x = -self.currentDirection.x
    end
    if self.entity.y < MAP_RENDER_OFFSET_Y + TILE_SIZE - self.entity.height / 2 or self.entity.y + self.entity.height > VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) 
    + MAP_RENDER_OFFSET_Y - TILE_SIZE then
        self.entity.y = math.max(MAP_RENDER_OFFSET_Y + TILE_SIZE, math.min(self.entity.y, VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) 
        + MAP_RENDER_OFFSET_Y - TILE_SIZE))
        self.currentDirection.y = -self.currentDirection.y
    end
end
