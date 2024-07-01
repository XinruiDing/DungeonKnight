Dungeon = Class{}

function Dungeon:init(player)
    self.player = player
    self.rooms = {}
    self.currentRoomIndex = 1
    if not self.player.final then
        self:createRoom(self.currentRoomIndex)
    else 
        self:createFinalRoom(self.currentRoomIndex)
    end
end

function Dungeon:createRoom(index)
    local room = Room(self.player)

    self.rooms[index] = room
end

function Dungeon:createEliteRoom(index)
    local room = EliteRoom(self.player)

    self.rooms[index] = room
end

function Dungeon:createFinalRoom(index)
    local room = FinalRoom(self.player)

    self.rooms[index] = room
end


function Dungeon:update(dt)
    local currentRoom = self.rooms[self.currentRoomIndex]
    currentRoom:update(dt)

    -- Check if the player interacts with the door to move to the next room
    if self.player.interactFlag then
        self.player.interactFlag = false
        gStateStack:push(DialogueState('Do you want to go to the next room?',
            function()
                gStateStack:push(SelectState(
                    {'cancel', 'confirm'}, self,
                    function(selectedOption)
                        if selectedOption == 'confirm' then
                            if self.currentRoomIndex < 3 then
                                self.currentRoomIndex = self.currentRoomIndex + 1
                                if not self.rooms[self.currentRoomIndex] then
                                    self:createRoom(self.currentRoomIndex) -- Create the next room only when needed
                                end
                            else
                                self.currentRoomIndex = self.currentRoomIndex + 1
                                if not self.rooms[self.currentRoomIndex] then
                                    self:createEliteRoom(self.currentRoomIndex) -- Create the next room only when needed
                                end
                            end
                        end
                    end
                ))
            end
        ))
    end
end

function Dungeon:render()
    local currentRoom = self.rooms[self.currentRoomIndex]
    currentRoom:render()
end