Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Constants'
require 'src/StateMachine'
require 'src/Util'
require 'src/Animation'

require 'src/entity/entity_def'
require 'src/entity/Entity'
require 'src/entity/Player'


require 'src/states/BaseState'
require 'src/states/StateStack'

require 'src/states/game/StartState'
require 'src/states/game/CityState'
require 'src/states/game/DialogueState'
require 'src/states/game/SelectState'

require 'src/states/entity/EntityBaseState'
require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'
require 'src/states/entity/PlayerIdleState'
require 'src/states/entity/PlayerWalkState'

require 'src/gui/Textbox'
require 'src/gui/Panel'
require 'src/gui/Menu'
require 'src/gui/Selection'

require 'src/world/city/City'



gTextures = {
    ['background'] = love.graphics.newImage('graphics/background.png'),
    ['character'] = love.graphics.newImage('graphics/0x72_DungeonTilesetII_v1.7.png'),
    ['floor'] = love.graphics.newImage('graphics/Objects/Floor.png'),
    ['low-wall'] = love.graphics.newImage('graphics/Objects/Wall.png'),
    ['gui'] = love.graphics.newImage('graphics/GUI/GUI0.png'),

}

gFrames = {
    ['character'] = GenerateQuads(gTextures['character'], 16, 32),
    ['floor'] = GenerateQuads(gTextures['floor'], 16, 16),
    ['low-wall'] = GenerateQuads(gTextures['low-wall'], 16, 16),
    ['gui'] = GenerateQuads(gTextures['gui'], 16, 16),
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
}

gSounds = {
    ['intro-music'] = love.audio.newSource('sounds/ReturningHome.ogg', 'static')
}