SelectState = Class{__includes = BaseState}

function SelectState:init(texts, level)
    self.level = level
    self.texts = texts

    self.menu = Menu {
        x = VIRTUAL_WIDTH / 2 - 64,
        y = VIRTUAL_HEIGHT / 2 - 32,
        width = 128,
        height = 64,
        items = {
            {
                text = self.texts[1],
                onSelect = function()
                    gStateStack:pop()  -- Pop the menu
                end
            },
            {
                text = self.texts[2],
                onSelect = function()
                    gStateStack:pop()  -- Pop the menu
                    gStateStack:push(DialogueState('You bought a mask!', function()
                        self.level.player.health = self.level.player.health + 1
                    end))
                end
            }
        }
    }

end

function SelectState:update(dt)
    self.menu:update(dt)
end

function SelectState:render()
    self.menu:render()
end