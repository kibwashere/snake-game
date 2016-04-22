--This file manages the obstacles part.
--It is a function that returns NbWall obstacles positions.

function createWall()
	local isClearSpawn = true
	local wallPositions = {}
	if ObstaclesOn then
		NbWall = 25
	else
		NbWall = 0
	end
	for i=1, NbWall do
		local xCoordd = math.random(0, (MaxWidth/TileSize)-4)*TileSize
		local yCoordd = math.random(0, (MaxHeight/TileSize)-4)*TileSize
		for _, value in ipairs(Players) do
			if xCoordd == value.x and yCoordd == value.y-16 then
				isClearSpawn = false
			end
		end
		if isClearSpawn == true then
			wallPositions[#wallPositions+1] = {xCoordd, yCoordd}
		end
		isClearSpawn = true
	end
	return wallPositions
end
