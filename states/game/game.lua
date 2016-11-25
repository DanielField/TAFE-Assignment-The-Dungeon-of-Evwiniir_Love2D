require("states/game/utilities")
require("states/game/map")
require("states/game/player")

currentLvl = 1

gameState = {
	load = function()
		-- Load the settings
		s = loadSettings()
		hasMusic = s[1]
		hasCheats = s[2]
		hasHappyTheme = s[3]
		
		love.graphics.setBackgroundColor(0,0,0)
	
		player.switched = false -- controls the state of the lever that opens the gate

		loadMap(currentLvl)

		-- Load textures
		ground = love.graphics.newImage("states/game/sprites/ground.png")
		cliffTop = love.graphics.newImage("states/game/sprites/cliffTop.png")
		cliffLeft = love.graphics.newImage("states/game/sprites/cliffLeft.png")
		cliffRight = love.graphics.newImage("states/game/sprites/cliffRight.png")
		cliffBottom = love.graphics.newImage("states/game/sprites/cliffBottom.png")
		cliffTopRight = love.graphics.newImage("states/game/sprites/cliffTopRight.png")
		cliffTopLeft = love.graphics.newImage("states/game/sprites/cliffTopLeft.png")
		cliffBottomLeft = love.graphics.newImage("states/game/sprites/cliffBottomLeft.png")
		cliffBottomRight = love.graphics.newImage("states/game/sprites/cliffBottomRight.png")
		bricks = love.graphics.newImage("states/game/sprites/bricks.png")
		spawn = love.graphics.newImage("states/game/sprites/spawn.png")
		finish = love.graphics.newImage("states/game/sprites/finish.png")
		dungeonExit = love.graphics.newImage("states/game/sprites/exit.png")
		
		leverOff = love.graphics.newImage("states/game/sprites/leverOff.png")
		leverOn = love.graphics.newImage("states/game/sprites/leverOn.png")
		
		gateUp = love.graphics.newImage("states/game/sprites/gate.png")
		gateDown = love.graphics.newImage("states/game/sprites/gateDown.png")
		
		gate = gateUp -- Close the gate
		lever = leverOff -- set lever to off
		
		-- happy theme
		ground2 = love.graphics.newImage("states/game/sprites/ground2.png")
		cliffTop2 = love.graphics.newImage("states/game/sprites/cliffTop2.png")
		cliffLeft2 = love.graphics.newImage("states/game/sprites/cliffLeft2.png")
		cliffRight2 = love.graphics.newImage("states/game/sprites/cliffRight2.png")
		cliffBottom2 = love.graphics.newImage("states/game/sprites/cliffBottom2.png")
		cliffTopRight2 = love.graphics.newImage("states/game/sprites/cliffTopRight2.png")
		cliffTopLeft2 = love.graphics.newImage("states/game/sprites/cliffTopLeft2.png")
		cliffBottomLeft2 = love.graphics.newImage("states/game/sprites/cliffBottomLeft2.png")
		cliffBottomRight2 = love.graphics.newImage("states/game/sprites/cliffBottomRight2.png")
		bricks2 = love.graphics.newImage("states/game/sprites/bricks2.png")
		spawn2 = love.graphics.newImage("states/game/sprites/spawn2.png")
		finish2 = love.graphics.newImage("states/game/sprites/finish2.png")
		dungeonExit2 = love.graphics.newImage("states/game/sprites/exit2.png")
		leverOff2 = love.graphics.newImage("states/game/sprites/leverOff2.png")
		leverOn2 = love.graphics.newImage("states/game/sprites/leverOn2.png")
		gateUp2 = love.graphics.newImage("states/game/sprites/gate2.png")
		gateDown2 = love.graphics.newImage("states/game/sprites/gateDown2.png")
		
		gate2 = gateUp2 -- Close the gate
		lever2 = leverOff2 -- set lever to off
		-- end happy theme
		
		-- load sounds
		gameAmbience = love.audio.newSource("states/game/audio/dungeon002.ogg") -- http://opengameart.org/content/dungeon-ambience
		leverSound = love.audio.newSource("states/game/audio/lever.ogg", "static")-- http://opengameart.org/content/bowling-ball-rolling
		levelComplete = love.audio.newSource("states/game/audio/levelComplete.wav", "static") -- http://opengameart.org/content/spell-1

		-- If ambience is enabled in the settings (originally had music, but was changed due to the music sounding bad)
		if hasMusic then
			gameAmbience:setVolume(2)
			gameAmbience:play()
		end
		
		-- Put the player on the spawn point
		for y=1, #map do
			for x=1, #map[y] do
				if map[y][x] == "s" then
					player.x = x
					player.y = y
				end
			end
		end
	end
}

function gameState.update(dt)
	player:update(dt)
end

function gameState.draw()
	love.graphics.setColor(255,255,255)
	for y=1, #map do
		for x=1, #map[y] do
			if hasHappyTheme then
				-- IF THE HAPPY THEME IS ENABLED, DRAW HAPPY TEXTURES
				if map[y][x] == "1" then
					--love.graphics.draw(bricks, (x-1) * cell_w, (y-1) * cell_h)
					
				-- Cliffs (borders)
				elseif map[y][x] == "L" then -- LEFT
					love.graphics.draw(cliffLeft2, (x-1) * cell_w, (y-1) * cell_h)
				elseif map[y][x] == "R" then -- RIGHT
					love.graphics.draw(cliffRight2, (x-1) * cell_w, (y-1) * cell_h)
				elseif map[y][x] == "T" then -- TOP
					love.graphics.draw(cliffTop2, (x-1) * cell_w, (y-1) * cell_h)
				elseif map[y][x] == "B" then -- BOTTOM
					love.graphics.draw(cliffBottom2, (x-1) * cell_w, (y-1) * cell_h)
				elseif map[y][x] == "7" then -- TOP LEFT
					love.graphics.draw(cliffTopLeft2, (x-1) * cell_w, (y-1) * cell_h)
				elseif map[y][x] == "5" then -- BOTTOM LEFT
					love.graphics.draw(cliffBottomLeft2, (x-1) * cell_w, (y-1) * cell_h)
				elseif map[y][x] == "6" then -- BOTTOM RIGHT
					love.graphics.draw(cliffBottomRight2, (x-1) * cell_w, (y-1) * cell_h)
				elseif map[y][x] == "8" then -- TOP RIGHT
					love.graphics.draw(cliffTopRight2, (x-1) * cell_w, (y-1) * cell_h)
				--
				
				-- lever
				elseif map[y][x] == "|" then
					love.graphics.draw(lever2, (x-1) * cell_w, (y-1) * cell_h)
				
				-- ground
				elseif map[y][x] == "0" then
					love.graphics.draw(ground2, (x-1) * cell_w, (y-1) * cell_h)
				-- Finish
				elseif map[y][x] == "F" then
					love.graphics.draw(finish2, (x-1) * cell_w, (y-1) * cell_h)
				-- Dungeon exit
				elseif map[y][x] == "*" then
					love.graphics.draw(dungeonExit2, (x-1) * cell_w, (y-1) * cell_h)
				-- Gate
				elseif map[y][x] == "G" then
					love.graphics.draw(gate2, (x-1) * cell_w, (y-1) * cell_h)
				-- brick wall
				elseif map[y][x] == "W" then
					love.graphics.draw(bricks2, (x-1) * cell_w, (y-1) * cell_h)
				-- spawn point
				elseif map[y][x] == "s" then
					love.graphics.draw(spawn2, (x-1) * cell_w, (y-1) * cell_h)
				end
			else -- IF THE HAPPY THEME IS DISABLED, DRAW THE REGULAR STUFF
				if map[y][x] == "1" then
					--love.graphics.draw(bricks, (x-1) * cell_w, (y-1) * cell_h)
					
				-- Cliffs (borders)
				elseif map[y][x] == "L" then -- LEFT
					love.graphics.draw(cliffLeft, (x-1) * cell_w, (y-1) * cell_h)
				elseif map[y][x] == "R" then -- RIGHT
					love.graphics.draw(cliffRight, (x-1) * cell_w, (y-1) * cell_h)
				elseif map[y][x] == "T" then -- TOP
					love.graphics.draw(cliffTop, (x-1) * cell_w, (y-1) * cell_h)
				elseif map[y][x] == "B" then -- BOTTOM
					love.graphics.draw(cliffBottom, (x-1) * cell_w, (y-1) * cell_h)
				elseif map[y][x] == "7" then -- TOP LEFT
					love.graphics.draw(cliffTopLeft, (x-1) * cell_w, (y-1) * cell_h)
				elseif map[y][x] == "5" then -- BOTTOM LEFT
					love.graphics.draw(cliffBottomLeft, (x-1) * cell_w, (y-1) * cell_h)
				elseif map[y][x] == "6" then -- BOTTOM RIGHT
					love.graphics.draw(cliffBottomRight, (x-1) * cell_w, (y-1) * cell_h)
				elseif map[y][x] == "8" then -- TOP RIGHT
					love.graphics.draw(cliffTopRight, (x-1) * cell_w, (y-1) * cell_h)
				--
				
				-- lever
				elseif map[y][x] == "|" then
					love.graphics.draw(lever, (x-1) * cell_w, (y-1) * cell_h)
				
				-- ground
				elseif map[y][x] == "0" then
					love.graphics.draw(ground, (x-1) * cell_w, (y-1) * cell_h)
				-- Finish
				elseif map[y][x] == "F" then
					love.graphics.draw(finish, (x-1) * cell_w, (y-1) * cell_h)
				-- Dungeon exit
				elseif map[y][x] == "*" then
					love.graphics.draw(dungeonExit, (x-1) * cell_w, (y-1) * cell_h)
				-- Gate
				elseif map[y][x] == "G" then
					love.graphics.draw(gate, (x-1) * cell_w, (y-1) * cell_h)
				-- brick wall
				elseif map[y][x] == "W" then
					love.graphics.draw(bricks, (x-1) * cell_w, (y-1) * cell_h)
				-- spawn point
				elseif map[y][x] == "s" then
					love.graphics.draw(spawn, (x-1) * cell_w, (y-1) * cell_h)
				end
			end
		end
	end
	player:draw()
	
	-- Draw text indicating that the player has cheats enabled
	if hasCheats then
		love.graphics.setFont(fontRegular)
		love.graphics.print("Cheats enabled. Read cheats.txt for details on how to cheat.")
		love.graphics.setFont(fontLarge)
	end
end
 
function gameState.keypressed(key)
	if key == "escape" then -- Load the menu on ESC press
		love.audio.stop()
		loadState(main) 
	end
	
	-- Load the specified level if cheats are enabled. (supports up to level 10)
	-- Each time you skip a level, it resets all of the values
	if(hasCheats) then
		if key == "1" then
			currentLvl = 1 
			switched = false
			lever = leverOff
			lever2 = leverOff2
			gate = gateUp
			gate2 = gateUp2
			love.audio.stop()
			loadState(gameState)
			gameState:load()
		end
		
		if key == "2" then
			currentLvl = 2 
			switched = false
			lever = leverOff
			lever2 = leverOff2
			gate = gateUp
			gate2 = gateUp2
			love.audio.stop()
			loadState(gameState)
			gameState:load()
		end
		
		if key == "3" then
			currentLvl = 3
			switched = false
			lever = leverOff
			lever2 = leverOff2
			gate = gateUp
			gate2 = gateUp2
			love.audio.stop()
			loadState(gameState)
			gameState:load()
		end
		
		if key == "4" then
			currentLvl = 4
			switched = false
			lever = leverOff
			lever2 = leverOff2
			gate = gateUp
			gate2 = gateUp2
			love.audio.stop()
			loadState(gameState)
			gameState:load()
		end
		
		if key == "5" then
			currentLvl = 5
			switched = false
			lever = leverOff
			lever2 = leverOff2
			gate = gateUp
			gate2 = gateUp2
			love.audio.stop()
			loadState(gameState)
			gameState:load()
		end
		
		if key == "6" then
			currentLvl = 6
			switched = false
			lever = leverOff
			lever2 = leverOff2
			gate = gateUp
			gate2 = gateUp2
			love.audio.stop()
			loadState(gameState)
			gameState:load()
		end
		
		if key == "7" then
			currentLvl = 7
			switched = false
			lever = leverOff
			lever2 = leverOff2
			gate = gateUp
			gate2 = gateUp2
			love.audio.stop()
			loadState(gameState)
			gameState:load()
		end
		
		if key == "8" then
			currentLvl = 8
			switched = false
			lever = leverOff
			lever2 = leverOff2
			gate = gateUp
			gate2 = gateUp2
			love.audio.stop()
			loadState(gameState)
			gameState:load()
		end
		
		if key == "9" then
			currentLvl = 9
			switched = false
			lever = leverOff
			lever2 = leverOff2
			gate = gateUp
			gate2 = gateUp2
			love.audio.stop()
			loadState(gameState)
			gameState:load()
		end
		
		if key == "0" then
			currentLvl = 10
			switched = false
			lever = leverOff
			lever2 = leverOff2
			gate = gateUp
			gate2 = gateUp2
			love.audio.stop()
			loadState(gameState)
			gameState:load()
		end
	end
end
 
 --[[
	Tests whether there is an object at the specified location relative to the player.
	
	Usage example: 
		testMap(-1,0)
		This would check whether the tile on the left of the player contains one of the objects.
	
	NOTE: This could be cleaned up by using a parameter for the tile value
 --]]
function testMap(x, y)
	if map[(player.y) + y][(player.x) + x] == "1" or -- Invisible wall
		(map[(player.y) + y][(player.x) + x] == "G" and (not switched)) or -- Gate
		map[(player.y) + y][(player.x) + x] == "W" then -- Brick wall
		return false
	elseif (map[(player.y) + y][(player.x) + x] == "|" and (not switched)) then -- lever
		switched = true
		lever2 = leverOn2
		gate2 = gateDown2
		lever = leverOn
		gate = gateDown
		leverSound:play()
		return false
	elseif (map[player.y + y][player.x + x] == "F") or (map[player.y + y][player.x + x] == "*") then -- Level and game completion
		currentLvl = currentLvl+1
		switched = false
		lever = leverOff
		lever2 = leverOff2
		gate = gateUp
		gate2 = gateUp2
		love.audio.stop()
		levelComplete:play()
		loadState(gameState)
		gameState:load()
		return false
	end
	return true
end

