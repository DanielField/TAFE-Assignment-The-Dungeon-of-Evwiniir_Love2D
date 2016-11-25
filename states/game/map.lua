w, h = love.window.getDimensions()

columns = 28
rows = 15
cell_w = 32
cell_h = 32
	
map = {}

--[[
	This function allows for a multiple level system. It can theoretically support virtually any amount of levels.
	
	Adding new levels requires no code at all, it just requires a tile map file that follows the correct naming format and tile format
	Example:
		1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
		1 7 T T T T T T T T T T T T T T T T T T T T T T T T 8 1
		1 L s 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 R 1
		1 L 0 W W W W W W W W W W W W W W W W W W W W W W 0 R 1
		1 L 0 0 0 W 0 0 0 0 0 W 0 0 0 0 W 0 0 0 0 0 0 0 W 0 R 1
		1 L 0 W 0 W 0 W 0 W 0 W 0 W W F W 0 W W W W W 0 W 0 R 1
		1 L 0 W 0 W W W 0 W 0 W 0 0 W W W 0 W 0 0 W 0 0 W 0 R 1
		1 L 0 W 0 0 0 W 0 W 0 W W 0 W 0 0 0 0 0 W W W 0 W 0 R 1
		1 L 0 W 0 W 0 0 0 W 0 0 W G W 0 W W W 0 W | W 0 W 0 R 1
		1 L 0 W 0 W 0 0 0 W W W W 0 0 0 W 0 W W W 0 W 0 W 0 R 1
		1 L 0 W 0 0 W W 0 0 0 0 0 0 W 0 W 0 0 0 0 0 0 0 W 0 R 1
		1 L 0 W W W W W W W W W W W W W W W W W W W W W W 0 R 1
		1 L 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 R 1
		1 5 B B B B B B B B B B B B B B B B B B B B B B B B 6 1
		1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
	
	If the map exists, loop through each tile and put them in a two dimensional table
	if there is no map, display a victory screen
--]]
function loadMap(mapNumber)
	if love.filesystem.exists("states/game/map" .. mapNumber .. ".txt") then
		map = {}
		for y, line in love.filesystem.lines("states/game/map" .. mapNumber .. ".txt") do
			mapRow = {}
			print(y)
			for x, c in ipairs(split(y, " ")) do
				table.insert(mapRow, c)
			end
			table.insert(map, mapRow)
			mapRow = {}
		end
	else -- If the file does not exist, display the victory state
		currentLvl = 1
		switched = false
		lever = leverOff
		gate = gateUp
		love.audio.stop()
		loadState(winnerState)
		winnerState:load()
	end
end