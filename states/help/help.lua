helpState = {}

function helpState.load()

	buttons = 
	{
		back = {width=100,
				height=60,
				xPos=w-110,
				yPos=10,
				text="Return"},
	}

end

function helpState.update(dt)
	-- No need to update anything
end

--[[
	Draw help and the return button
--]]
function helpState.draw()
	if(hasHappyTheme) then
		love.graphics.setBackgroundColor(255,255,255)
		
		love.graphics.setColor(0,0,0,255)
		love.graphics.setFont(fontLarge)
		love.graphics.print("Help", 10, 10)
		love.graphics.setFont(love.graphics.newFont(15))
		love.graphics.print("Hello, adventurer! Earlier today you stumbled across a stone that teleported you to another realm.\n"..
							"You seem to be stuck in some kind of dungeon that is surrounded by cliffs that appear to fall into nothingness.\n\n"..
							"In order to escape you must:\n"..
							"	- Try to find an exit\n"..
							"		- There may be gates that block your path to the exit. Try to reach the lever to open the gates\n"..
							"	- There are multiple dungeons within this realm, work your way through them all and you will escape\n\n"..
							"Controls (Android & PC):\n"..
							"	touch above, below, or on the left or right of the player to move in those directions.\n\n"..
							"Controls (PC only):\n"..
							"	W/Up arrow - Moves the player up.\n"..
							"	S/Down arrow - Moves the player down.\n"..
							"	A/Left arrow - Moves the player left.\n"..
							"	D/Right arrow - Moves the player right.\n"
							, 10, 50)
		love.graphics.setFont(fontLarge)
		
		love.graphics.setColor(200,200,0,255)
	else
		love.graphics.setBackgroundColor(0,0,0)
		love.graphics.setColor(150,150,255,255)
		love.graphics.setFont(fontLarge)
		love.graphics.print("Help", 10, 10)
		love.graphics.setFont(love.graphics.newFont(15))
		love.graphics.print("Hello, adventurer! Earlier today you stumbled across a stone that teleported you to another realm.\n"..
							"You seem to be stuck in some kind of dungeon that is surrounded by cliffs that appear to fall into nothingness.\n\n"..
							"In order to escape you must:\n"..
							"	- Try to find an exit\n"..
							"		- There may be gates that block your path to the exit. Try to reach the lever to open the gates\n"..
							"	- There are multiple dungeons within this realm, work your way through them all and you will escape\n\n"..
							"Controls (Android & PC):\n"..
							"	touch above, below, or on the left or right of the player to move in those directions.\n\n"..
							"Controls (PC only):\n"..
							"	W/Up arrow - Moves the player up.\n"..
							"	S/Down arrow - Moves the player down.\n"..
							"	A/Left arrow - Moves the player left.\n"..
							"	D/Right arrow - Moves the player right.\n"
							, 10, 50)
		love.graphics.setFont(fontLarge)
		
		love.graphics.setColor(255,255,255,255)
	end
	
	love.graphics.rectangle("fill",buttons.back.xPos,buttons.back.yPos,buttons.back.width,buttons.back.height)
	
	love.graphics.setColor(0,0,255,255)
	love.graphics.print(buttons.back.text, buttons.back.xPos+buttons.back.width/2-fontLarge:getWidth(buttons.back.text)/2, buttons.back.yPos+buttons.back.height/2-10)
	love.graphics.setColor(255,255,255,255)
end
 
 --[[
	ESC loads the menu state
 --]]
function helpState.keypressed(key)
	if key == "escape" then 
		loadState(main)
		main:load() 
	end
end

function helpState.mousepressed(x,y,btn)
	if  (btn == "l") then -- Return to main menu
		if(x > buttons.back.xPos and x < buttons.back.xPos + buttons.back.width and
		   y > buttons.back.yPos and y < buttons.back.yPos + buttons.back.height) then
			loadState(main)
			main:load()
			navigationSound:play()
		end
	end
end