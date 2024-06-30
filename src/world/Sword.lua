Sword = Class{__includes = GameObject}

function Sword:init(def, x, y, player)
    GameObject.init(self, def, x, y)
    self.player = player
    self.width = def.width
    self.height = def.height
    self.speed = def.speed
    self.isActive = false
    self.directionX = 0
    self.directionY = 0
    self.startX = 0
    self.startY = 0
end

function Sword:update(dt)
    if not self.isActive then
        self.x = self.player.x + TILE_SIZE
        self.y = self.player.y + TILE_SIZE
    else
        self.x = self.x + self.directionX * dt * self.speed
        self.y = self.y + self.directionY * dt * self.speed
        
        if math.sqrt((self.x - self.startX)^2 + (self.y - self.startY)^2) > 50 then
            self.x = self.player.x + TILE_SIZE
            self.y = self.player.y + TILE_SIZE    
            self.isActive = false
        end
    end
end

function Sword:render()
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.frame],
        self.x, self.y)
end

function Sword:throw()
    self.isActive = true
    local dx, dy = self.player.lastMove.x, self.player.lastMove.y
    local length = math.sqrt(dx*dx + dy*dy)
    if length > 0 then
        self.directionX = dx / length
        self.directionY = dy / length
    else
        self.directionX = 0
        self.directionY = 1
    end
    self.startX = self.player.x + TILE_SIZE
    self.startY = self.player.y + TILE_SIZE
    self.x = self.startX
    self.y = self.startY
end