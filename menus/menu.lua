--This file manages the menus part.
--It redirects to the desired state.
--Main menu: New Game / Highscores / Options / Quit
---Players menu: 1 Player / 2 Players / 3 Players / Back

require 'menus.template'

local menu = {}
local arrowsPositionY = MaxWidth/2
local currentMenu = 1

function menu.keypressed(key)
    if love.keyboard.isDown("up", 'z', 'w') and currentMenu ~= 1 then
		arrowsPositionY = arrowsPositionY - 30
		currentMenu = currentMenu - 1
	end
    if love.keyboard.isDown("down", 's') and currentMenu ~= 4 then
		arrowsPositionY = arrowsPositionY + 30
		currentMenu = currentMenu + 1
    end
    if love.keyboard.isDown("return") then
	    if State == 1 then
	    	if currentMenu == 1 then
	    		State = 2
	    	elseif currentMenu == 2 then
	    		State = 6
	    	elseif currentMenu == 3 then
	    		State = 7
	    	elseif currentMenu == 4 then
	    		love.event.push('quit')
	    	end
	    else
	    	if currentMenu == 1 then
	    		State = 3
	    		NewGame = true
	    	elseif currentMenu == 2 then
	    		State = 4
	    		NewGame = true
	    	elseif currentMenu == 3 then
	    		State = 5
	    		NewGame = true
	    	elseif currentMenu == 4 then
	    		State = 1
	    	end
	    end
    	arrowsPositionY = MaxWidth/2
    	currentMenu = 1
    end
	if love.keyboard.isDown('escape') then
		if State == 1 then
			love.event.push('quit')
		else 
			State = 1
		end	
	end
end

function menu:update(dt)
	if State == 1 then
		menuValues = {"New Game", "High scores", "Options", "Quit"}
	else
		menuValues = {"1 Player", "2 Players", "3 Players", "Back"}
	end
end

function menu:draw(dt)
	Template:draw(arrowsPositionY)
	love.graphics.printf(menuValues[1], 0, MaxHeight/2, MaxWidth, 'center')
	love.graphics.printf(menuValues[2], 0, (MaxHeight/2)+30, MaxWidth, 'center')
	love.graphics.printf(menuValues[3], 0, (MaxHeight/2)+60, MaxWidth, 'center')
	love.graphics.printf(menuValues[4], 0, (MaxHeight/2)+90, MaxWidth, 'center')
end 

return menu