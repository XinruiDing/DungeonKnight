'''
Adds numbers to a sprite sheet for easy reference.
'''
from PIL import Image
from PIL import ImageFont
from PIL import ImageDraw

# size of tile sheet on Y and X axis in tiles; replace these with something positive
TILES_HIGH = 16
TILES_WIDE = 8

TILE_SIZE = 16

if __name__ == '__main__':

    # replace 'tiles.png' with your sprite sheet
    img = Image.open('graphics/small_monster.png')
    draw = ImageDraw.Draw(img)

    # custom small font, good for small tile sets
    font = ImageFont.truetype('fonts/font.ttf', 8)
    
    # keep track of which tile we're adding text to
    counter = 1

    for y in range(TILES_HIGH):
        for x in range(TILES_WIDE):
            draw.text((x * TILE_SIZE + 1, y * TILE_SIZE * 1.5), str(counter), (0, 0, 0), font=font)
            draw.text((x * TILE_SIZE, y * TILE_SIZE * 1.5 + 1), str(counter), (0, 0, 0), font=font)
            draw.text((x * TILE_SIZE, y * TILE_SIZE * 1.5), str(counter), (255, 0, 255), font=font)
            counter += 1
    
    # save as renamed tile sheet
    img.save('small_monster_numbered.png')
