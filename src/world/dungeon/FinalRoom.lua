FinalRoom = Class{__includes = Room}

function FinalRoom:init(player)
    Room.init(self, player) -- Call the base class constructor

    -- Custom setup for elite room
    -- Override entities with a single boss
    self.entities = {}
    self:generateBoss()

    self.objects = {}
    
end

function FinalRoom:update(dt)
    Room.update(self, dt)

    if self:areAllEnemiesDefeated() then
        self.player.isWin = true
        self.player:onFinalWin()
    end

    if self.player.isWin then
        return
    end

end


function FinalRoom:generateBoss()
    local def = ENTITY_DEFS['final-enemy']
    local boss = Entity {
        animations = def.animations, -- Ensure this definition exists
        walkSpeed = def.walkSpeed,
        x = VIRTUAL_WIDTH / 2 - 16, -- Centered horizontally
        y = VIRTUAL_HEIGHT / 2 - 24, -- Centered vertically
        width = 32, -- Larger size for boss
        height = 48,
        health = def.health -- Higher health for boss
    }

    boss.stateMachine = StateMachine {
        ['idle'] = function() return EntityIdleState(boss) end,
        ['walk'] = function() return EntityWalkState(boss, self) end
    }

    table.insert(self.entities, boss)
    boss:changeState('idle')
end
