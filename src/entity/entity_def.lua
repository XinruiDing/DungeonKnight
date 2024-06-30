ENTITY_DEFS = {
    ['player'] = {
        animations = {
            ['walk'] = {
                frames = {265, 266, 267, 268, 269, 270, 271, 272, 273},
                interval = 0.15,
                texture = 'character'
            },
            ['idle'] = {
                frames = {265},
                texture = 'character'
            },
        }
    },
    ['charm-merchant'] = {
        interactions = {'Buy charm', 'Leave'},
        dialogue = 'Welcome to the charm store!',
        animations = {
            ['idle'] = {
                frames = {9, 10, 11, 12, 13},
                interval = 0.15,
                texture = 'character'
            },
        }
    },
    ['mask-merchant'] = {
        interactions = {'Buy mask', 'Leave'},
        dialogue = 'Looking for masks?',
        animations = {
            ['idle'] = {
                frames = {73, 74, 75, 76, 77},
                interval = 0.15,
                texture = 'character'
            },
        }
    },
    ['weapon-merchant'] = {
        interactions = {'Buy weapon', 'Leave'},
        dialogue = 'Here for a weapon?',
        animations = {
            ['idle'] = {
                frames = {137, 138, 139, 140, 141},
                interval = 0.15,
                texture = 'character'
            },
        }
    },
    ['small-enemy'] = {
        animations = {
            ['walk'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8},
                interval = 0.15,
                texture = 'small-monster'
            },
            ['idle'] = {
                frames = {1, 2, 3, 4},
                interval = 0.15,
                texture = 'small-monster'
            },
        },
        walkSpeed = 10,
        health = 1
    },
    ['shoot-straight-enemy'] = {
        animations = {
            ['walk'] = {
                frames = {25, 26, 27, 28, 29, 30, 31, 32},
                interval = 0.15,
                texture = 'small-monster'
            },
            ['idle'] = {
                frames = {25, 26, 27, 28},
                interval = 0.15,
                texture = 'small-monster'
            },
        },
        walkSpeed = 20,
        health = 1
    },
    ['shoot-circle-enemy'] = {
        animations = {
            ['walk'] = {
                frames = {65, 66, 67, 68, 69, 70, 71, 72},
                interval = 0.15,
                texture = 'small-monster'
            },
            ['idle'] = {
                frames = {65, 66, 67, 68},
                interval = 0.15,
                texture = 'small-monster'
            },
        },
        walkSpeed = 20,
        health = 1
    },
    ['berserk-enemy'] = {
        animations = {
            ['walk'] = {
                frames = {89, 90, 91, 92, 93, 94, 95, 96},
                interval = 0.15,
                texture = 'small-monster'
            },
            ['idle'] = {
                frames = {89, 90, 91, 92},
                interval = 0.15,
                texture = 'small-monster'
            },
        },
        walkSpeed = {
            ['walk'] = 20,
            ['berserk'] = 50,
        },
        health = 1
    },
    ['elite-enemy'] = {
        animations = {
            ['walk'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8},
                interval = 0.15,
                texture = 'elite-monster'
            },
            ['idle'] = {
                frames = {1, 2, 3, 4},
                interval = 0.15,
                texture = 'elite-monster'
            },
        }
    },

}