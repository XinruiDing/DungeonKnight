GAME_OBJECT_DEFS = {
    ['entrance'] = {
        type = 'door',
        texture = 'door',
        frame = 42,
        width = 16,
        height = 16,
        solid = false,
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
}