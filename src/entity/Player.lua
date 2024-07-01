Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    self.isDead = false
end

function Player:collides(target)
    local selfY, selfHeight = self.y + self.height / 2, self.height - self.height / 2
    
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                selfY + selfHeight < target.y or selfY > target.y + target.height)
end

function Player:swordUpgrade(weaponDef)
    -- Assuming you pass the entire definition of the new weapon
    local newSwordDef = GAME_OBJECT_DEFS[weaponDef]
    self.sword = Sword(newSwordDef, self.x + TILE_SIZE, self.y + TILE_SIZE, self)
end


function Player:onDeath()
    gStateStack:push(DialogueState('You Lost! Press Enter to return to city!', 
        function()
            gStateStack:pop()
            self.health = self.maxHealth
            self.isDead = false
            gStateStack:push(CityState(self))
        end
    ))
end