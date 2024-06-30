GAME_OBJECT_DEFS = {
    ['entrance'] = {
        type = 'door',
        texture = 'door',
        frame = 42,
        width = 16,
        height = 16,
        solid = true,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 42
            },
            ['pressed'] = {
                frame = 42
            }
        }
    },
    ['door'] = {
        type = 'door',
        texture = 'door',
        frame = 42,
        width = 16,
        height = 16,
        solid = true,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 42
            },
            ['pressed'] = {
                frame = 42
            }
        }
    },
    ['normal-sword'] ={
        type = 'weapon',
        texture = 'weapon',
        frame = 2,
        width = 16,
        height = 16,
        solid = true,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 2
            },
            ['pressed'] = {
                frame = 2
            }
        },
        speed = 20,
        hurt = 1
    },
    ['silver-sword'] ={
        type = 'weapon',
        texture = 'weapon',
        frame = 1,
        width = 16,
        height = 16,
        solid = true,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 1
            },
            ['pressed'] = {
                frame = 1
            }
        },
        speed = 40,
        hurt = 2
    },
    ['gold-sword'] ={
        type = 'weapon',
        texture = 'weapon',
        frame = 3,
        width = 16,
        height = 16,
        solid = true,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 3
            },
            ['pressed'] = {
                frame = 3
            }
        },
        speed = 60,
        hurt = 3
    },

}