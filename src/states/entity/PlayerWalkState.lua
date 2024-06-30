PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(entity, level)
    EntityWalkState.init(self, entity, level)
    self.entity.lastMove = {x = 0, y = 1}
end

function PlayerWalkState:update(dt)
    local dx, dy = 0, 0

    -- Check each direction independently
    if love.keyboard.isDown('left') then
        dx = dx - self.entity.walkSpeed * dt
    end
    if love.keyboard.isDown('right') then
        dx = dx + self.entity.walkSpeed * dt
    end
    if love.keyboard.isDown('up') then
        dy = dy - self.entity.walkSpeed * dt
    end
    if love.keyboard.isDown('down') then
        dy = dy + self.entity.walkSpeed * dt
    end

    local len = math.sqrt(dx * dx + dy * dy)
    if len > 0 then
        dx = (dx / len) * self.entity.walkSpeed * dt
        dy = (dy / len) * self.entity.walkSpeed * dt
    end
    
    self.entity.lastMove = {x = dx, y = dy}
    -- Apply movement
    self.entity.x = self.entity.x + dx
    self.entity.y = self.entity.y + dy

    -- perform base collision detection against walls
    EntityWalkState.update(self, dt)

    if love.keyboard.wasPressed('space') and gStateStack:getCurrentState().__index == DungeonState then
        self.entity.sword:throw()
    end

    

    -- if we bumped something when checking collision, check any object collisions
    if self.bumped then
        --self.entity.x = math.max(MAP_RENDER_OFFSET_X + TILE_SIZE, math.min(self.entity.x, VIRTUAL_WIDTH - TILE_SIZE * 2))
        --self.entity.y = math.max(MAP_RENDER_OFFSET_Y + TILE_SIZE - self.entity.height / 2, math.min(self.entity.y, VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE))

        if self.entity.x < MAP_RENDER_OFFSET_X + TILE_SIZE then
            self.entity.x = self.entity.x - PLAYER_WALK_SPEED * dt

            self.entity.x = self.entity.x + PLAYER_WALK_SPEED * dt
        elseif self.entity.x + self.entity.width > VIRTUAL_WIDTH - TILE_SIZE * 2 then
            self.entity.x = self.entity.x + PLAYER_WALK_SPEED * dt

            self.entity.x = self.entity.x - PLAYER_WALK_SPEED * dt
        elseif self.entity.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE - self.entity.height / 2 then
            self.entity.y = self.entity.y - PLAYER_WALK_SPEED * dt

            self.entity.y = self.entity.y + PLAYER_WALK_SPEED * dt
        else
            self.entity.y = self.entity.y + PLAYER_WALK_SPEED * dt

            self.entity.y = self.entity.y - PLAYER_WALK_SPEED * dt
        end

--[[         if self.entity.direction == 'left' then
            
            -- temporarily adjust position into the wall, since bumping pushes outward
            self.entity.x = self.entity.x - PLAYER_WALK_SPEED * dt
            
            -- readjust
            self.entity.x = self.entity.x + PLAYER_WALK_SPEED * dt
        elseif self.entity.direction == 'right' then
            
            -- temporarily adjust position
            self.entity.x = self.entity.x + PLAYER_WALK_SPEED * dt
            -- readjust
            self.entity.x = self.entity.x - PLAYER_WALK_SPEED * dt
        elseif self.entity.direction == 'up' then
            
            -- temporarily adjust position
            self.entity.y = self.entity.y - PLAYER_WALK_SPEED * dt
            -- readjust
            self.entity.y = self.entity.y + PLAYER_WALK_SPEED * dt
        else
            
            -- temporarily adjust position
            self.entity.y = self.entity.y + PLAYER_WALK_SPEED * dt
            -- readjust
            self.entity.y = self.entity.y - PLAYER_WALK_SPEED * dt
        end
 ]]        
    end
end