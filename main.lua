-- happy-piano

-- hide status bar
display.setStatusBar( display.HiddenStatusBar )
-- dir paths
local imageDir = "images"
local audioDir = "audio"
-- setup background image
local backgroundImg = display.newImageRect( imageDir .. "/Background.png", 960, 640 )
backgroundImg.x = 480
backgroundImg.y = 320

-- keyboard
local widget = require( "widget" )
local keyboard = display.newGroup()
local numOfKeys = 8
-- offsets
local firstX = 108
local firstY = 398
local paddingX = 106
-- label names
local keyNames = {
    [1] = "Do",
    [2] = "Re",
    [3] = "Me",
    [4] = "Fa",
    [5] = "So",
    [6] = "La",
    [0] = "Te"
}

-- temp collection of keyboard
local keyboardTable = {}
-- recursively create keyboard
for count = 1, numOfKeys, 1 do
    keyboardTable[count] = {}
    -- handle on key pressed
    local sound = audio.loadSound(audioDir .. "/" .. count .. ".mp3")
    keyboardTable[count]["onPressed"] = function (event)
        audio.play(sound)
    end
    local keyOpt = {
        -- image button
        width = 105,
        height = 325,
        defaultFile = imageDir .. "/" .. count .. ".png",
        overFile = imageDir .. "/" .. count .. "P.png",
        onPress = keyboardTable[count]["onPressed"],
        -- label
        labelColor = { default = { 60/255, 60/255, 60/255, 0 }, over = { 1, 1, 1, 1 } },
        font = native.systemFontBold,
        fontSize = 30
    }
    local key = widget.newButton( keyOpt )
    -- set offset
    if count == 1 then
        key.x = firstX
        key.y = firstY
    else
        key.x = keyboardTable[count - 1]["key"].x + paddingX
        key.y = firstY
    end
    key:setLabel( keyNames[ count%7 ] )
    keyboardTable[count]["key"] = key
    keyboard:insert( key )
end
