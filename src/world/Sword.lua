Sword = Class{__includes = GameObject}

function Sword:init(def, x, y, player)
    GameObject.init(self, def, x, y)
    self.player = player
    self.width = def.width
    self.height = def.height
    self.speed = def.speed
end

function Sword:update(dt)
    self.x = self.player.x + TILE_SIZE
    self.y = self.player.y + TILE_SIZE

    if self.isActive then
        self.x = self.x + self.directionX * dt * self.speed
        self.y = self.y + self.directionY * dt * self.speed
        if math.sqrt((self.x - self.player.x)^2 + (self.y - self.player.y)^2) > 300 then
            self.isActive = false
            self.x = self.player.x + TILE_SIZE
            self.y = self.player.y + TILE_SIZE
        end
    end
end

function Sword:render()
    if self.isActive then
        love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.frame],
            self.x, self.y)
    end
end

function Sword:throw()
    self.isActive = true
    self.directionX = self.player.lastMove.x
    self.directionY = self.player.lastMove.y
    self.x = self.player.x
    self.y = self.player.y
end