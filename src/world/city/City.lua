City = Class{}

function City:init(def)
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

    self.player = def or Player {
        animations = ENTITY_DEFS['player'].animations,
        x = 100 + MAP_RENDER_OFFSET_X,
        y = 100 + MAP_RENDER_OFFSET_Y,
        width = 16,
        height = 32,
        health = 10,
        wealth = 10,
        sword = 'normal-sword'
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
            type = type,

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

function City:generateObjects()
    local entrance = GameObject(
        GAME_OBJECT_DEFS['entrance'],
        VIRTUAL_WIDTH / 2 - TILE_SIZE + MAP_RENDER_OFFSET_X, MAP_RENDER_OFFSET_Y)

    entrance.onCollide = function()
        gStateStack:push(DialogueState('Do you want to go to the dungeon?',
            function()
                gStateStack:push(SelectState({'cancel', 'Enter dungeon'}, self,
                    function(selectedOption)
                        if selectedOption == 'Enter dungeon' then
                            gStateStack:pop()
                            gStateStack:push(DungeonState(self.player))
                        end
                    end
            ))
            end))
    end

    table.insert(self.objects, entrance)

end


function City:update(dt)
    if love.keyboard.wasPressed('q') then
        gStateStack:push(PlayerStatsState(self.player))
    end

    self.player:update(dt)

    for k, entity in pairs(self.entities) do
        entity:update(dt)

        if self.player:collides(entity) then
            -- Calculate overlaps
            local overlapX = math.min(self.player.x + self.player.width, entity.x + entity.width) - math.max(self.player.x, entity.x)
            local overlapY = math.min(self.player.y + self.player.height, entity.y + entity.height) - math.max(self.player.y, entity.y)

            -- Determine the smallest overlap
            if overlapX < overlapY / 2 then
                -- Adjust horizontally based on the player's and entity's relative positions
                if self.player.x < entity.x then
                    self.player.x = self.player.x - PLAYER_WALK_SPEED * dt - OVERLAP
                else
                    self.player.x = self.player.x + PLAYER_WALK_SPEED * dt + OVERLAP
                end
            else
                -- Adjust vertically based on the player's and entity's relative positions
                if self.player.y < entity.y then
                    self.player.y = self.player.y - PLAYER_WALK_SPEED * dt - OVERLAP
                else
                    self.player.y = self.player.y + PLAYER_WALK_SPEED * dt + OVERLAP
                end
            end
    
            local entityDef = ENTITY_DEFS[entity.type]

            gStateStack:push(DialogueState(entityDef.dialogue,
                function ()
                    gStateStack:push(SelectState(
                        entityDef.interactions, self, 
                        function(selectedOption)
                            if selectedOption == 'Buy mask' then
                                if self.player.wealth >= 10 then
                                    gStateStack:push(DialogueState('You bought a mask!', function()
                                        self.player.health = self.player.health + 1
                                        self.player.maxHealth = self.player.maxHealth + 1
                                        self.player.wealth = self.player.wealth - 10
                                    end))
                                else
                                    gStateStack:push(DialogueState('You do not have enough money!'))
                                end
                            elseif selectedOption == 'Buy weapon' then
                                gStateStack:push(SelectState({'silver-sword', 'gold-sword'}, self, 
                                    function(selectedWeapon)
                                        local cost = 0
                                        if selectedWeapon == 'silver-sword' then cost = 50
                                        elseif selectedWeapon == 'gold-sword' then cost = 100
                                        end

                                        if self.player.wealth >= cost then
                                            gStateStack:push(DialogueState('You bought a weapon!', function()
                                                self.player:swordUpgrade(selectedWeapon)
                                                self.player.weaponName = selectedWeapon
                                                self.player.wealth = self.player.wealth - cost
                                            end))
                                        else
                                            gStateStack:push(DialogueState('You do not have enough money!'))
                                        end
                                    end))
                            elseif selectedOption == 'Buy charm' then
                                gStateStack:push(DialogueState('Comming soon...'))
                            end
                        end
                    ))
                end
            ))
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

function City:render()
    
    for y = 1, self.height do
        for x = 1, self.width do
            local tile = self.tiles[y][x]
            love.graphics.draw(gTextures[tile.frame], gFrames[tile.frame][tile.id],
                (x - 1) * TILE_SIZE + self.renderOffsetX, 
                (y - 1) * TILE_SIZE + self.renderOffsetY)
        end
    end

    for k, entity in pairs(self.entities) do
        entity:render()
    end

    for k, object in pairs(self.objects) do
        object:render()
    end

    self.player:render()

    for i = 1, self.player.health do
        love.graphics.draw(gTextures['gui'], gFrames['gui'][86],
        TILE_SIZE * i, 0)
    end

    love.graphics.printf("To See character panel, Press Q", 0, 10, VIRTUAL_WIDTH, 'right')
end