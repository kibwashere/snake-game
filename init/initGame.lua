--This file initializes every global variables that will be used in this game.

local initGame = {}

function initGame:create(dt)
	--Window parameters
	MaxWidth = math.floor(love.graphics.getWidth())
	MaxHeight = math.floor(love.graphics.getHeight())
	TileSize = 16
	--Background color
	love.graphics.setBackgroundColor(28, 28, 28)
	--Sprites/Textures
	TitleImage = love.graphics.newImage('img/title.png')
	Tileset = love.graphics.newImage('img/tileset.png')
	local tileW, tileH = 16, 16
	local tilesetW, tilesetH = Tileset:getWidth(), Tileset:getHeight()
	------Wall
		WallQuad1 = love.graphics.newQuad(0,  0, tileW, tileH, tilesetW, tilesetH)
	------Snakes
		local snakeQuad1 = love.graphics.newQuad(16,  0, tileW, tileH, tilesetW, tilesetH)
		local snakeQuad2 = love.graphics.newQuad(32,  0, tileW, tileH, tilesetW, tilesetH)
		local snakeQuad3 = love.graphics.newQuad(48,  0, tileW, tileH, tilesetW, tilesetH)
		SnakesQuad = {snakeQuad1, snakeQuad2, snakeQuad3}
	------Foods
		local appleQuad = love.graphics.newQuad(0,  16, tileW, tileH, tilesetW, tilesetH)
		local bananaQuad = love.graphics.newQuad(16,  16, tileW, tileH, tilesetW, tilesetH)
		local cherryQuad = love.graphics.newQuad(32,  16, tileW, tileH, tilesetW, tilesetH)
		local orangeQuad = love.graphics.newQuad(48,  16, tileW, tileH, tilesetW, tilesetH)
		FruitsQuad = {appleQuad, bananaQuad, cherryQuad, orangeQuad}
	--Some game parameters
	State = 1
	Paused = false
	NewGame = false
	SoundOn = true
	ObstaclesOn = false
	--Cheat mode!
	Konami = false
	konamicode = require("play.konamicode")(function() Konami = true playSound("sounds/konami.mp3") end)
	--Get highscores
	Highscores = {}
	if not love.filesystem.exists("scores.lua") then
		scores = love.filesystem.newFile("scores.lua")
		Highscores = {0, 0, 0}
	end
	for lines in love.filesystem.lines("scores.lua") do
		table.insert(Highscores, lines)
	end
	table.sort(Highscores, function(a, b) return tonumber(a) < tonumber(b) end)
end

return initGame