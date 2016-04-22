--This file initializes every global variables that will be used ingame.

Init = {}

function Init:update(dt)
	--Sound
	if Konami == true then
		playSound("sounds/konami.mp3")
	else
		playSound("sounds/play.mp3")
	end
	--Speed of the game
	MoveTimer = 0.5
	--Players config
	if State == 3 then
		Players = { {x = TileSize*(math.floor(MaxWidth/16/2)), y = MaxHeight-16, quad = SnakesQuad[1], dead = false, color = {51,102,255}, direction = "up", moveAllowed = true, score = 1, scorePosition = 10, positions = {}} }
	elseif State == 4 then
		Players = { {x = TileSize*(math.floor(MaxWidth/16/3)), y = MaxHeight-16, quad = SnakesQuad[1], dead = false, color = {51,102,255}, direction = "up", moveAllowed = true, score = 1, scorePosition = 10, positions = {}}, {x = TileSize*(math.floor(MaxWidth/16/1.5)), y = MaxHeight-16, quad = SnakesQuad[2], dead = false, color = {51,153,102}, direction = "up", scorePosition = 90, moveAllowed = true, score = 1, positions = {}} }
	elseif State == 5 then
		Players = { {x = TileSize*(math.floor(MaxWidth/16/4)), y = MaxHeight-16, quad = SnakesQuad[1], dead = false, color = {51,102,255}, direction = "up", moveAllowed = true, score = 1, scorePosition = 10, positions = {}}, {x = TileSize*(math.floor(MaxWidth/16/2)), y = MaxHeight-16, quad = SnakesQuad[2], dead = false, color = {51,153,102}, direction = "up", scorePosition = 90, moveAllowed = true, score = 1, positions = {}}, {x = TileSize*(math.floor(MaxWidth/16/1.3)), y = MaxHeight-16, quad = SnakesQuad[3], dead = false, color = {255,0,0}, direction = "up", scorePosition = 170, moveAllowed = true, score = 1, positions = {}} }
	end
	--Fruit & walls
	math.randomseed(os.time())
	RandomFruits = math.random(1, 4)
	WallPositions = createWall()
	createFood()
	FoodsPosition = {}
	--Game
	GameOver = false
	NewGame = false 
	Exaequo = false
	SaveScores = true
 	WinnerScore = 0
	SuchWow = false
	Ready = true
end

function saveScore(score)
	table.insert(Highscores, score)
	table.sort(Highscores, function(a, b) return tonumber(a) < tonumber(b) end)
	table.remove(Highscores, 1)
	love.filesystem.write("scores.lua", Highscores[#Highscores-2] .. "\n" .. Highscores[#Highscores-1] .. "\n" .. Highscores[#Highscores])
end
