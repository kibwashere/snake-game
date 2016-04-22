--This file manages the template part.
--It is a function that draws the title and the pre-selected menu.

Template = {}

function Template:draw(arrowsPositionY)
  	love.graphics.draw(TitleImage, (MaxWidth/2)-(173/2), 50)
  	if State ~= 6 then
		love.graphics.printf("->", 0, arrowsPositionY, (MaxWidth/2)-70, 'right')
		love.graphics.printf("<-", (MaxHeight/2)+70, arrowsPositionY, (MaxWidth/2)-70)
	end
end
