SelectState = Class{__includes = BaseState}

function SelectState:init(options, level, callback)
    self.level = level
    self.options = options
    self.callback = callback or function() end

    local menuItems = {}
    for i, optionText in ipairs(self.options) do
        table.insert(menuItems, {
            text = optionText,
            onSelect = function()
                gStateStack:pop()  -- Pop the menu
                self.callback(optionText)
            end
        })
    end

    self.menu = Menu {
        x = VIRTUAL_WIDTH / 2 - 64,
        y = VIRTUAL_HEIGHT / 2 - 32,
        width = 128,
        height = 64,
        items = menuItems
    }
end

function SelectState:update(dt)
    self.menu:update(dt)
end

function SelectState:render()
    self.menu:render()
end