--This file manages the food part.
--It is a function that returns a food position (x, y).

function createFood()
	local isClearSpawn = true
	local isNoMoreFreeCases = false
	local unfreeCases = 0
	FoodPosition = {math.random(0, (MaxWidth/TileSize)-1)*TileSize, math.random(0, (MaxHeight/TileSize)-1)*TileSize}
	for _, value1 in ipairs(Players) do
		unfreeCases = unfreeCases + #value1.positions
		if unfreeCases >= (MaxWidth/16)*(MaxHeight/16)-1 then
			FoodPosition = {-42, -42}
		else
			for __, value2 in ipairs(value1.positions) do
				if FoodPosition[1] == value2[1] and FoodPosition[2] == value2[2] then
					isClearSpawn = false
				end
			end
		end
	end
	for _, value in ipairs(WallPositions) do
		if FoodPosition[1] == value[1] and FoodPosition[2] == value[2] then
			isClearSpawn = false
		end
	end
	if isClearSpawn == false then
		createFood()
	end
	return FoodPosition
end


