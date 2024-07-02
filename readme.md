## ✨ Final Project for CS50 Game

## **DUNGEON KNIGHT**

### ✨ Introduction
Combining rouguelike and RPG gameplay, in contrast to the course content, the player can advance infinitely in all directions, weapons can be fired diagonally, and a weapon system is introduced whereby more powerful weapons and extra lives can be purchased through gold coins! As long as clear GUI!

[Demo video:](https://youtu.be/jg6ZI-0Km-0)

### ✨ Design
- The main map has three merchants — Charm Merchant, Mask Merchant (each mask represents an extra life), and a Weapons Upgrade Merchant (upgraded sword provides more damage) — alongside the dungeon entrance. 
- Each dungeon randomly generates four rooms. 
- In each dungeon journey, player will yield monster-dropped gold. 
- Each run culminates in a battle against an elite monster, after which the player will get a gem. 
- If player fail in battle, spoils will not get lost but can be spent on the main map. 
- After collecting three gems, player can fight the final boss.
- Finally, player defeat the last boss to win the game, or face a reset and start a new adventure.
- scalability: The game keeps all major objects in data form and has highly abstract parent classes, providing a convenient interface for expanding functionality and more merchants and monsters

### ✨ Function Showed in Video
- talk with three different merchant
- fight enemy, Movement is not restricted to up and down, left and right directions
- different enemy has different health(s), Different monsters need to be attacked a different number of times before they die
- Kill all the monsters before the door opens.
- advanced monster's AI, will automatically chase the player
- enter next room
- win the elite monster and get a gem
- Show GUI
    - character's health, money, and weapon changed through the game and drades with merchant!
- fight the final monster and restart the game.

### ✨ Tasks and Issues
- [x] write a simple introduction to my game.
- [x] roughly design the game structure.
- [x] find free or cheap visual sourse.
    - [x] character
    - [x] dungeon
    - [x] elite monsters(the big three) and normal monsters
    - [x] masks(replace with skulls)
    - [x] charms(books)
    - [x] gems
    - [x] void heart(octagonal gem)
    - [x] merchants and sages
- [x] background picture: Zelda
- [ ] use bfxr to design voice sourse.
- [x] find free background music
- [x] add fonts
    - [x] add to dependences.
- [x] write `dependences.lua`
    - [x] **REMEMBER** to add all file to dependences!
- [x] build the main map.
- [x] build dungeon.
- [x] build character upgrading mechanics.
- [x] build state stack and state machine.
- [x] design normal monster.
- [x] design three elite monster.
- [x] design last monster.
- reuse of code in courses:
    - `Animation`, `Textbox`, `Selection`, `Menu`, `Panel`, `entity`, `entityWalkState` in Pokemon.
    - `gameObject` in Zelda
    - `drawnums.py` script

### ✨ Used resources
#### ✨ graphics
- DawnLike - 16x16 Universal Rogue-like tileset v1.81
    - author: DragonDePlatino
    - origin: [opengameart](https://opengameart.org/content/dawnlike-16x16-universal-rogue-like-tileset-v181)
    - lisence: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)


- dungeontileset-ii
    - author: 0x72
    - origin: [itch.io](https://0x72.itch.io/dungeontileset-ii)
    - lisence: [CC-0](https://www.tldrlegal.com/license/creative-commons-cc0-1-0-universal)

- Gems / Coins Free
    - author: La Red Games
    - origin: [itch.io](https://laredgames.itch.io/gems-coins-free)
    - lisence: 
        - You can use this asset for personal and commercial purpose.
        - Credit is not required but would be appreciated. 
        - Modify as you will.

- 16x16 Fantasy RPG Characters
    - author: SuperDark
    - origin: [itch.io](https://superdark.itch.io/16x16-free-npc-pack)
    - lisence: These assets are completely free so you can use them however you like, in free and commercial projects and you can even modify them to suit your needs, you don't need to credit me but it is greatly appreciated if you do, and don't forget: have fun

- Kyrise's Free 16x16 RPG Icon Pack
    - author: Kyrise
    - origin: [itch.io](https://kyrise.itch.io/kyrises-free-16x16-rpg-icon-pack)
    - lisence: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)

- Background: cs50game - Zelda's `background.png`

#### ✨ sounds
- 16-Bit Starter Pack
    - author: Bit By Bit Sound / Bert Cole
    - origin: [itch.io](https://bit-by-bit-sound.itch.io/16-bit-starter-pack)
        - [author's page](bitbybitsound.com)
    - lisence:

        All tracks are offered on a non-exclusive license. All music is original and composed by Bert Cole.

        Upon recieving this license, you can use the music anywhere you like and across multiple projects as long as you adhere to the restrictions outlined below.

        Please credit me clearly as the composer wherever the music is used. Credit should read as music composed by Bert Cole?and include a link to my homepage. 

        bitbybitsound.com

        Linking to my Twitter or Patreon account is optional (but very much appreciated!) :D  

        Patreon: patreon.com/bitbybitsound
        Twitter: @BitByBitSound

        Restrictions:

        Each license and purchase is applicable to one company or one person only. It is forbidden to re-sell any of these works (e.g. as part of a soundtrack or in any other form). 
        It is forbidden to create or sell any derivative works.

#### ✨ fonts
- just use cs50game - Zelda's font.

