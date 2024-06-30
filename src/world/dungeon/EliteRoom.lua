EliteRoom = Class{__includes = Room}

function EliteRoom:init(player)
    Room.init(self, player) -- Call the base class constructor

    -- Custom setup for elite room
    -- Override entities with a single boss
    self.entities = {}
    self:generateBoss()

    self.objects = {}
    
end

function EliteRoom:generateBoss()
    local boss = Entity {
        animations = ENTITY_DEFS['elite-enemy'].animations, -- Ensure this definition exists
        walkSpeed = 30,
        x = VIRTUAL_WIDTH / 2 - 16, -- Centered horizontally
        y = VIRTUAL_HEIGHT / 2 - 24, -- Centered vertically
        width = 32, -- Larger size for boss
        height = 48,
        health = 20 -- Higher health for boss
    }

    boss.stateMachine = StateMachine {
        ['idle'] = function() return EntityIdleState(boss) end,
        ['walk'] = function() return EntityWalkState(boss, self) end
    }

--[[     boss.onDeath = function() -- Function to execute when boss dies
        self:spawnGem()
    end
 ]]
    table.insert(self.entities, boss)
    boss:changeState('idle')
end

--[[ function EliteRoom:spawnGem()
    local gem = GameObject(
        GAME_OBJECT_DEFS['gem'], -- Make sure this definition exists
        boss.x, -- Coordinates where the boss was defeated
        boss.y
    )

    gem.onCollide = function()
        -- Logic to collect the gem and possibly return to the town area
        self.player.collectGem = true
        -- Trigger any events related to gem collection
    end

    table.insert(self.objects, gem)
end

function EliteRoom:generateEliteWallsAndFloors()
    -- Optionally redefine this method to create unique walls and floors
    -- This could include visual themes or obstacles specific to the elite room
    Room.generateWallsAndFloors(self)
end

-- Override update and render methods if specific behaviors are needed for elite room
 ]]