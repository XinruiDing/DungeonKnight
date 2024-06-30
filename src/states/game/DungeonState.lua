DungeonState = Class{__includes = BaseState}

function DungeonState:init()
    self.dungeon = Dungeon()

    gSounds['intro-music']:setLooping(true)
    gSounds['intro-music']:play()

end

function DungeonState:update(dt)
    self.dungeon:update(dt)
end

function DungeonState:render()
    self.dungeon:render()
end


