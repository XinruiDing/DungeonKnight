--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The Selection class gives us a list of textual items that link to callbacks;
    this particular implementation only has one dimension of items (vertically),
    but a more robust implementation might include columns as well for a more
    grid-like selection, as seen in many kinds of interfaces and games.
]]

Selection = Class{}

function Selection:init(def)
    self.items = def.items
    self.x = def.x
    self.y = def.y

    self.height = def.height
    self.width = def.width
    self.font = def.font or gFonts['small']

    self.gapHeight = self.height / #self.items

    self.currentSelection = 1

    -- decide to show the cursor or not
    self.cursorVisible = def.cursorVisible or true
end

function Selection:update(dt)
    -- we can only select items when cursorVisible is true
    if self.cursorVisible then
        if love.keyboard.wasPressed('up') then
            if self.currentSelection == 1 then
                self.currentSelection = #self.items
            else
                self.currentSelection = self.currentSelection - 1
            end
            
        elseif love.keyboard.wasPressed('down') then
            if self.currentSelection == #self.items then
                self.currentSelection = 1
            else
                self.currentSelection = self.currentSelection + 1
            end
            
        elseif love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
            self.items[self.currentSelection].onSelect()
            
        end
    end
end

function Selection:render()
    local currentY = self.y

    for i = 1, #self.items do
        local paddedY = currentY + (self.gapHeight / 2) - self.font:getHeight() / 2

        -- draw selection marker if we're at the right index
        if i == self.currentSelection and self.cursorVisible then
            love.graphics.draw(gTextures['gui'], gFrames['gui'][38], self.x - 8, paddedY)
        end

        love.graphics.printf(self.items[i].text, self.x, paddedY, self.width, 'center')

        currentY = currentY + self.gapHeight
    end
end