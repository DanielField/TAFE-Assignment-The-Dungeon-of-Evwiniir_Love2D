settingState = {}

-- load settings
function settingState.load()
	settings = loadSettings()
	hasAmbience = settings[1]
	hasCheats = settings[2]
	hasHappyTheme = settings[3]
end

function settingState.update(dt)

end

-- Draw toggle buttons
function settingState.draw()
	menu = 
	{	
		buttons = 
		{
			toggleAmbience = {width=w/2,
					height=(h-cellSize)/8,
					xPos=w/4,
					yPos=cellSize*2,
					text="Enable ambience"},
			toggleCheats = {width=w/2,
					height=(h-cellSize)/8,
					xPos=w/4,
					text="Enable cheats",
					yPos=(h-cellSize)/8+cellSize*3},
			toggleHappyTheme = {width=w/2,
					height=(h-cellSize)/8,
					xPos=w/4,
					yPos=(h-cellSize)/8+cellSize*6,
					text="Enable happy theme"},		
			back = {width=w/2,
					height=(h-cellSize)/8,
					xPos=w/4,
					yPos=(h-cellSize)/8+cellSize*9,
					text="Return"},
		}
	}
	if(hasHappyTheme) then
		love.graphics.setBackgroundColor(255,255,255)
		love.graphics.setColor(200,200,0,255)
	else
		love.graphics.setBackgroundColor(0,0,0)
	end
	
	tbl = menu.buttons
	love.graphics.rectangle("fill",tbl.toggleAmbience.xPos,tbl.toggleAmbience.yPos,tbl.toggleAmbience.width,tbl.toggleAmbience.height)
	love.graphics.rectangle("fill",tbl.toggleCheats.xPos,tbl.toggleCheats.yPos,tbl.toggleCheats.width,tbl.toggleCheats.height)
	love.graphics.rectangle("fill",tbl.toggleHappyTheme.xPos,tbl.toggleHappyTheme.yPos,tbl.toggleHappyTheme.width,tbl.toggleHappyTheme.height)
	love.graphics.rectangle("fill",tbl.back.xPos,tbl.back.yPos,tbl.back.width,tbl.back.height)
	love.graphics.setColor(255,255,255,255)
	
	love.graphics.setColor(0,0,255,255)
	
	if(hasAmbience == true) then
		tbl.toggleAmbience.text = "Disable ambience"
	else
		tbl.toggleAmbience.text = "Enable ambience"
	end
	
	if(hasCheats == true) then
		tbl.toggleCheats.text = "Disable cheats"
	else
		tbl.toggleCheats.text = "Enable cheats"
	end
	
	if(hasHappyTheme == true) then
		tbl.toggleHappyTheme.text = "Disable happy theme"
	else
		tbl.toggleHappyTheme.text = "Enable happy theme"
	end
	
	love.graphics.print(tbl.toggleAmbience.text, tbl.toggleAmbience.xPos+tbl.toggleAmbience.width/2-fontLarge:getWidth(tbl.toggleAmbience.text)/2, tbl.toggleAmbience.yPos+tbl.toggleAmbience.height/2-10)
	love.graphics.print(tbl.toggleCheats.text, tbl.toggleCheats.xPos+tbl.toggleCheats.width/2-fontLarge:getWidth(tbl.toggleCheats.text)/2, tbl.toggleCheats.yPos+tbl.toggleCheats.height/2-10)
	love.graphics.print(tbl.toggleHappyTheme.text, tbl.toggleHappyTheme.xPos+tbl.toggleHappyTheme.width/2-fontLarge:getWidth(tbl.toggleHappyTheme.text)/2, tbl.toggleHappyTheme.yPos+tbl.toggleHappyTheme.height/2-10)
	love.graphics.print(tbl.back.text, tbl.back.xPos+tbl.back.width/2-fontLarge:getWidth(tbl.back.text)/2, tbl.back.yPos+tbl.back.height/2-10)
	love.graphics.setColor(255,255,255,255)
end

-- Toggle the settings and save them
function settingState.mousepressed(x,y,btn)
	if  (btn == "l") then
		if(x > menu.buttons.toggleAmbience.xPos and x < menu.buttons.toggleAmbience.xPos + menu.buttons.toggleAmbience.width and
		   y > menu.buttons.toggleAmbience.yPos and y < menu.buttons.toggleAmbience.yPos + menu.buttons.toggleAmbience.height) then
			hasAmbience = not hasAmbience
			saveSettings()
			navigationSound:play()
		elseif(x > menu.buttons.toggleCheats.xPos and x < menu.buttons.toggleCheats.xPos + menu.buttons.toggleCheats.width and
		   y > menu.buttons.toggleCheats.yPos and y < menu.buttons.toggleCheats.yPos + menu.buttons.toggleCheats.height) then
			hasCheats = not hasCheats
			saveSettings()
			navigationSound:play()
		elseif(x > menu.buttons.toggleHappyTheme.xPos and x < menu.buttons.toggleHappyTheme.xPos + menu.buttons.toggleHappyTheme.width and
		   y > menu.buttons.toggleHappyTheme.yPos and y < menu.buttons.toggleHappyTheme.yPos + menu.buttons.toggleHappyTheme.height) then
			hasHappyTheme = not hasHappyTheme
			saveSettings()
			navigationSound:play()
		elseif(x > menu.buttons.back.xPos and x < menu.buttons.back.xPos + menu.buttons.back.width and
		   y > menu.buttons.back.yPos and y < menu.buttons.back.yPos + menu.buttons.back.height) then
			loadState(main)
			main:load()
			navigationSound:play()
		end
	end
end
 
function settingState.keypressed(key)
	if key == "escape" then 
		loadState(main) 
		main:load() 
	end
end

-- save the settings in the appdata\roaming\LOVE folder
function saveSettings()
	settings[1] = hasAmbience
	settings[2] = hasCheats
	settings[3] = hasHappyTheme
	love.filesystem.write("settings", TSerial.pack(settings))
end

-- Load the settings from the settings file if it exists
function loadSettings()
	local tbl = {}
	if love.filesystem.exists("settings") then
		tbl = TSerial.unpack(love.filesystem.read("settings"))
	end
	return tbl
end