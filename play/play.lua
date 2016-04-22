--This file handles all the game show.

require 'init.initPlay'
require 'play.createFood'
require 'play.createWall'

local play = {}

function play.keypressed(key)
	--Players 1
	if love.keyboard.isDown("left") and Players[1].direction ~= "right" and Players[1].moveAllowed == true then
		Players[1].direction = "left"
		Players[1].moveAllowed = false
	elseif love.keyboard.isDown("right") and Players[1].direction ~= "left" and Players[1].moveAllowed == true then
		Players[1].direction = "right"
		Players[1].moveAllowed = false
	elseif love.keyboard.isDown("up") and Players[1].direction ~= "down" and Players[1].moveAllowed == true then
		Players[1].direction = "up"
		Players[1].moveAllowed = false
	elseif love.keyboard.isDown("down") and Players[1].direction ~= "up" and Players[1].moveAllowed == true then
		Players[1].direction = "down"
		Players[1].moveAllowed = false
    end
    --Players2
    if Players[2] then
		if love.keyboard.isDown('q', 'a') and Players[2].direction ~= "right" and Players[2].moveAllowed == true then
			Players[2].direction = "left"
		Players[2].moveAllowed = false
		elseif love.keyboard.isDown('d') and Players[2].direction ~= "left" and Players[2].moveAllowed == true then
			Players[2].direction = "right"
		Players[2].moveAllowed = false
		elseif love.keyboard.isDown('z', 'w') and Players[2].direction ~= "down" and Players[2].moveAllowed == true then
			Players[2].direction = "up"
		Players[2].moveAllowed = false
		elseif love.keyboard.isDown('s') and Players[2].direction ~= "up" and Players[2].moveAllowed == true then
			Players[2].direction = "down"
		Players[2].moveAllowed = false
	    end
	end
	--Players3
    if Players[3] then
		if love.keyboard.isDown('j') and Players[3].direction ~= "right" and Players[3].moveAllowed == true then
			Players[3].direction = "left"
			Players[3].moveAllowed = false
		elseif love.keyboard.isDown('l') and Players[3].direction ~= "left" and Players[3].moveAllowed == true then
			Players[3].direction = "right"
			Players[3].moveAllowed = false
		elseif love.keyboard.isDown('i') and Players[3].direction ~= "down" and Players[3].moveAllowed == true then
			Players[3].direction = "up"
			Players[3].moveAllowed = false
		elseif love.keyboard.isDown('k') and Players[3].direction ~= "up" and Players[3].moveAllowed == true then
			Players[3].direction = "down"
			Players[3].moveAllowed = false
	    end
	end
	--Pause and quit
	if love.keyboard.isDown('escape') and GameOver == false then
		love.audio.pause()
		if Paused == true then
			playSound("sounds/intro.mp3")
			GameOver = true
		end
		Paused = not Paused
	elseif love.keyboard.isDown('escape') and GameOver == true then
		State = 1
	end
	if love.keyboard.isDown('p') and GameOver == false then
		if Paused == true then
			love.audio.resume()
		else
			love.audio.pause()
		end
		Paused = not Paused
	end
	--Restart
    if love.keyboard.isDown("r") and GameOver == true then
    	NewGame = true
    end
end

function play:update(dt)
	--Restarted
	if NewGame then
		Init:update()
	end
	--Save in solo mode when game is over
	if GameOver == true and #Players == 1 then
		if WinnerScore > tonumber(Highscores[#Highscores-2]) and SaveScores == true then
			saveScore(WinnerScore)
			SaveScores = false
		end		
	end
	--Ingame
	if not Paused and not GameOver then
		MoveTimer = MoveTimer - (1 * dt)
		if MoveTimer < 0 then
			MoveTimer = 0.1
			--Parameters of Players
			for _, player in ipairs(Players) do
				if player.dead == false then	
					--Directions
					if player.direction == "left" then
						player.x = player.x - TileSize
						player.moveAllowed = true
					elseif player.direction == "right" then
						player.x = player.x + TileSize
						player.moveAllowed = true
					elseif player.direction == "up" then
						player.y = player.y - TileSize
						player.moveAllowed = true
					elseif player.direction == "down" then
						player.y = player.y + TileSize
						player.moveAllowed = true
					end
					--Dead:
					----Outside window 
						if player.x >= MaxWidth or player.x < 0 or player.y >= MaxHeight or player.y < 0 then
							player.dead = true
						end
					----Body of a same player
						for __, position in ipairs(player.positions) do
							if player.x == position[1] and player.y == position[2] then
								player.dead = true
							end
						end
					----Bodies of others Players
						for i=1, #Players do
							for __, position in ipairs(Players[i].positions) do
								if player.x == position[1] and player.y == position[2] then
									player.dead = true
								end
							end
						end
					----Inside wall
						for __, position in ipairs(WallPositions) do
				  			if player.x == position[1] and player.y == position[2] then
								player.dead = true
				  			end
						end
					--New position
					player.positions[#player.positions+1] = {player.x, player.y}
					if #player.positions >= player.score+2 then
						table.remove(player.positions, 1)
					end
					--Eat Food
					if Konami == false then
						if player.x == FoodPosition[1] and player.y == FoodPosition[2] then
							repeat
								FoodPosition = createFood()
							until FoodPosition ~= false
							player.score = player.score + 1
							RandomFruits = math.random(1, 4)
						end
					else
						--Eat Food Konami
						for i, __ in ipairs(FoodsPosition) do
							if player.x == FoodsPosition[i][1] and player.y == FoodsPosition[i][2] then
								player.score = player.score + 1
								table.remove(FoodsPosition, i)
							end	
						end	
						createFood()
						FoodsPosition[#FoodsPosition+1] = {FoodPosition[1], FoodPosition[2]}
					end
					--When you get every foods!
					if FoodPosition[1] == -42 then
						SuchWow = true
					end
					--A Players is dead?
					local deadPlayer = 0
					local max = 0
					for i, __ in ipairs(Players) do
						if Players[i].score > max then
							max = Players[i].score
							idWinner = i
							WinnerScore = Players[i].score
						end
						if Players[i].dead == true then
							deadPlayer = deadPlayer + 1
							if deadPlayer == #Players then
								if #Players ~= 1 then
									if WinnerScore == Players[(idWinner%#Players)+1].score then
										Exaequo = true
									end
								end
							GameOver = true
							playSound("sounds/intro.mp3")
							end
						end
					end
				end
			end
		end
	end
end

function play:draw(dt)
	if Ready == true then
		--Snake & Score (Players)
		for _, player in ipairs(Players) do
			for __, position in ipairs(player.positions) do
		  		love.graphics.draw(Tileset, player['quad'], position[1], position[2])
			end
			love.graphics.setColor(player.color[1], player.color[2], player.color[3])
			love.graphics.print("Score: " .. tostring(player.score), player.scorePosition, 10)
			if #Players == 1 then
				if WinnerScore > tonumber(Highscores[#Highscores]) then
					love.graphics.print("Highscore: " .. tostring(WinnerScore), MaxWidth-100, 10)
				else
					love.graphics.print("Highscore: " .. tostring(Highscores[#Highscores]), MaxWidth-100, 10)
				end
			end
			love.graphics.setColor(255,255,255)
		end
		--Food (FoodPosition / FoodsPosition)
		if Konami == false then
			love.graphics.draw(Tileset, FruitsQuad[RandomFruits], FoodPosition[1], FoodPosition[2])
		elseif GameOver == false then
			for _, position in ipairs(FoodsPosition) do
		  		love.graphics.draw(Tileset, FruitsQuad[2], position[1], position[2])
			end
	  	end
	  	if GameOver == false then
			--Wall (WallPositions)
			for _, position in ipairs(WallPositions) do
	  			love.graphics.draw(Tileset, WallQuad1, position[1], position[2])
			end
		end
		if Paused then
			love.graphics.printf("~ Unpause with P or exit with Escape ~", 0, MaxHeight-20, MaxWidth, 'center')
		end
		if GameOver == true then
			--Game over
			if State == 3 then
				love.graphics.draw(TitleImage, (MaxWidth/2)-(173/2), 50)
				love.graphics.setColor(Players[idWinner].color[1], Players[idWinner].color[2], Players[idWinner].color[3])
				love.graphics.printf("You ate " .. WinnerScore .. " fruits!", 0, MaxHeight/2, MaxWidth, 'center')
				--Winner!
				if SuchWow == true then
					love.graphics.setColor(255,0,255)
					love.graphics.printf("You deserve a cookie!", 0, MaxHeight/2+30, MaxWidth, 'center')
				end
				love.graphics.setColor(255,255,255)
			else
				love.graphics.draw(TitleImage, (MaxWidth/2)-(173/2), 50)
				if Exaequo then
					love.graphics.printf("Ex aequo!", 0, MaxHeight/2, MaxWidth, 'center')
				else
					love.graphics.setColor(Players[idWinner].color[1], Players[idWinner].color[2], Players[idWinner].color[3])
					love.graphics.printf("Mr. Snake " .. idWinner .. " wins!", 0, MaxHeight/2, MaxWidth, 'center')
				end
				love.graphics.setColor(255,255,255)
			end
			love.graphics.printf("Let's play again!\n\nPress R", 0, MaxHeight/2+60, MaxWidth, 'center')
		end
	end
end

return play