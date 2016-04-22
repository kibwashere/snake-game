--This file allows to edit some parameters.
--Sound / Obstacle mode activated or not

require 'menus.template'

local options = {}
local optionValues = {"Obstacles", "Sound", "Back"}
local currentMenu = 1
local arrowsPositionY = MaxWidth/2

function options.keypressed(key)
    if love.keyboard.isDown("up", 'z', 'w') and currentMenu ~= 1 then
		arrowsPositionY = arrowsPositionY - 30
		currentMenu = currentMenu - 1
	end
    if love.keyboard.isDown("down", 's') and currentMenu ~= 3 then
		arrowsPositionY = arrowsPositionY + 30
		currentMenu = currentMenu + 1
    end
    if love.keyboard.isDown("return") then
    	if currentMenu == 1 then
    		ObstaclesOn = not ObstaclesOn
    	elseif currentMenu == 2 then
    		if SoundOn then
    			SoundOn = false
    			love.audio.stop()
    		else
    			SoundOn = true
    			playSound("sounds/intro.mp3")
    		end
    	elseif currentMenu == 3 then
    		State = 1
	    	arrowsPositionY = MaxWidth/2
			currentMenu = 1
    	end
    end
	if love.keyboard.isDown('escape') then
		State = 1
	end
end

function options:update(dt)
end

function options:draw(dt)
	Template:draw(arrowsPositionY)
	if ObstaclesOn then
		love.graphics.printf(optionValues[1] .. " ON", 0, MaxHeight/2, MaxWidth, 'center')
	else
		love.graphics.printf(optionValues[1] .. " OFF", 0, MaxHeight/2, MaxWidth, 'center')
	end
	if SoundOn then
		love.graphics.printf(optionValues[2] .. " ON", 0, (MaxHeight/2)+30, MaxWidth, 'center')
	else
		love.graphics.printf(optionValues[2] .. " OFF", 0, (MaxHeight/2)+30, MaxWidth, 'center')
	end
	love.graphics.printf(optionValues[3], 0, (MaxHeight/2)+60, MaxWidth, 'center')
end 

return options