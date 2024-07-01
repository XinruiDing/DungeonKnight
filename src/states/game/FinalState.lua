FinalState = Class{__includes = BaseState}

function FinalState:init(player)
    self.player = player
    self.dungeon = Dungeon(self.player, 2)

    gSounds['intro-music']:setLooping(true)
    gSounds['intro-music']:play()

end

function FinalState:update(dt)
    self.dungeon:update(dt)
end

function FinalState:render()
    self.dungeon:render()
end



