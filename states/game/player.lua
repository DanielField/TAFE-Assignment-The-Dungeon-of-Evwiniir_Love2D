player = {
		-- Physical position in grid
		x = 0,
		y = 0,
		
		-- Desired position in grid (Having two points allows for smooth transitioning between the tiles)
		target_x = 0,
		target_y = 0,
		
		-- How fast the player can move
		speed = 3,
		
		score = 0, -- time taken (may change in future versions)
		
		playerStill = love.graphics.newImage("states/game/sprites/blu.png"), -- His name is Blu
		
		switched = false -- Boolean for the lever
}

function checkInput()
	-- If the person touches/clicks one of the buttons, it will check if the player can move there. If so, it will move one cell over. (32x32)
	if love.mouse.isDown("l") then
		local mouseX,mouseY = love.mouse.getPosition()
		local returnedButton = button:checkPress({x=mouseX,y=mouseY},player.x,player.y) 
		if returnedButton == 3 then
			if testMap(0, -1) then
				player.y = player.y - 1
			end
		end
		if returnedButton == 4 then
			if testMap(0, 1) then
				player.y = player.y + 1
			end
		end
		if returnedButton == 1 then
			if testMap(-1, 0) then
				player.x = player.x - 1
			end
		end
		if returnedButton == 2 then
			if testMap(1, 0) then
				player.x = player.x + 1
			end
		end
	end
	
	-- keyboard input
	if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
		if testMap(0, -1) then
			player.y = player.y - 1
		end
	end
	if love.keyboard.isDown("down") or love.keyboard.isDown("s") then
		if testMap(0, 1) then
			player.y = player.y + 1
		end
	end
	if love.keyboard.isDown("left") or love.keyboard.isDown("a") then
		if testMap(-1, 0) then
			player.x = player.x - 1
		end
	end
	if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
		if testMap(1, 0) then
			player.x = player.x + 1
		end
	end
end

function player:update(dt)
	-- Smoothly animate to the target x and y
	player.target_y = player.target_y - ((player.target_y - player.y) * player.speed * dt)
	player.target_x = player.target_x - ((player.target_x - player.x) * player.speed * dt)
	
	-- Prevents race car kind of movement.
	if (getDifference(player.x, player.target_x) <= 1) and (getDifference(player.y, player.target_y) <= 1) then
		checkInput()
	end
	
	player.score = player.score + dt
end

--[[
	Draw the player and time taken to complete the game
--]]
function player:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(player.playerStill, (player.target_x-1) * cell_w, (player.target_y-1) * cell_h)
	
	love.graphics.setFont(fontRegular)
	strScore = math.floor(player.score + 0.5)
	love.graphics.print("Time taken: " .. strScore .. " sec.", w/2-fontRegular:getWidth("Time taken: " .. strScore .. " sec.")/2,10)
	love.graphics.setFont(fontLarge)
end