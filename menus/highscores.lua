--This file shows the top 3 highsscores in solo player mode.

require 'menus.template'

local highscores = {}

function highscores.keypressed(key)
	if love.keyboard.isDown('escape') or love.keyboard.isDown("return") then
		State = 1
	end
end

function highscores:update(dt)
end

function highscores:draw(dt)
	Template:draw()
	love.graphics.printf("Top3 high scores:", 0, (MaxHeight/2)-40, MaxWidth, 'center')
	love.graphics.printf(Highscores[#Highscores], 0, MaxHeight/2, MaxWidth, 'center')
	if Highscores[#Highscores-1] then
		love.graphics.printf(Highscores[#Highscores-1], 0, (MaxHeight/2)+30, MaxWidth, 'center')
	end
	if Highscores[#Highscores-2] then
		love.graphics.printf(Highscores[#Highscores-2], 0, (MaxHeight/2)+60, MaxWidth, 'center')
	end
	love.graphics.printf("Press Enter to exit", 0, (MaxHeight/2)+150, MaxWidth, 'center')
end 

return highscores