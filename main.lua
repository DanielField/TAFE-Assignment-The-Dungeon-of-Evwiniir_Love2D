--[[
	Author: Daniel Field
	Version: 1.0
	Date: 2016/11/04

	The game state system was designed in a similar way to the video referenced below. 
	A few things were done differently, as the example had some issues.
	
	This game uses a tile map system where the game loads a tile map and draws the map based off of that.
	
	0 0 0 0 0
	0 1 0 0 0
	0 0 0 F 0 
	0 0 0 0 0 
	0 0 2 0 0
	
	Each character in the tile map is a 32x32 block that has a texture. The player also moves along the grid, 
	and it checks the tiles around it to determine where it can move.
	
	Game states video: https://www.youtube.com/watch?v=L_OrFXyorwI
	Gridlocked Player tutorial: https://love2d.org/wiki/Tutorial:Gridlocked_Player
--]]

require("utilities")
require("tserial") -- Used for saving a table to a text file.

-- State files
require("states/game/game")
require("states/settings/settings")
require("states/help/help")
require("states/winner/winner")
--

require("input")

function love.load()
	loadState(main) -- Load the menu
	
	-- Load the settings
	settings = loadSettings()
	hasAmbience = settings[1]
	hasCheats = settings[2]
	hasHappyTheme = settings[3]
	
	-- Fonts being used throughout the game
	fontSmall = love.graphics.newFont(8)
	fontRegular = love.graphics.newFont(12)
	fontLarge = love.graphics.newFont(20)
	fontXLarge = love.graphics.newFont(25)
	love.graphics.setFont(fontLarge)
	
	navigationSound = love.audio.newSource("states/game/audio/navSound.wav","static") -- http://opengameart.org/content/menu-selection-click
end

main = {} -- Main state. this is the menu.

function main.load()
	love.audio.stop()
end

function main.update(dt)
	-- Nothing needs to be updated, however it is necessary for the state system to work.
end

w,h = love.graphics.getDimensions()
cellSize = 32 -- Virtually everything in the game uses 32 pixels for positioning and sizing

love.graphics.setBackgroundColor(0,0,0)

--[[
	Draws the buttons on the screen along with some text.
--]]
function main.draw()

	menu = 
	{	
		buttons = 
		{
			play = {width=w/2,
					height=(h-cellSize)/8,
					xPos=w/4,
					yPos=cellSize*2,
					text="Play"},
			settings = {width=w/2,
					height=(h-cellSize)/8,
					xPos=w/4,
					yPos=(h-cellSize)/8+cellSize*3,
					text="Settings"},
			help = {width=w/2,
					height=(h-cellSize)/8,
					xPos=w/4,
					yPos=(h-cellSize)/8+cellSize*6,
					text="Help"},
			quit = {width=w/2,
					height=(h-cellSize)/8,
					xPos=w/4,
					yPos=(h-cellSize)/8+cellSize*9,
					text="Quit"},
		}
	}
	
	if(hasHappyTheme) then
		love.graphics.setBackgroundColor(255,255,255)
		love.graphics.setColor(200,200,0,255)
	else
		love.graphics.setBackgroundColor(0,0,0)
	end

	tbl = menu.buttons
	love.graphics.rectangle("fill",tbl.play.xPos,tbl.play.yPos,tbl.play.width,tbl.play.height)
	love.graphics.rectangle("fill",tbl.settings.xPos,tbl.settings.yPos,tbl.settings.width,tbl.settings.height)
	love.graphics.rectangle("fill",tbl.help.xPos,tbl.help.yPos,tbl.help.width,tbl.help.height)
	love.graphics.rectangle("fill",tbl.quit.xPos,tbl.quit.yPos,tbl.quit.width,tbl.quit.height)
	love.graphics.setColor(255,255,255,255)
	
	love.graphics.setColor(0,0,255,255)
	love.graphics.print(tbl.play.text, tbl.play.xPos+tbl.play.width/2-fontLarge:getWidth(tbl.play.text)/2, tbl.play.yPos+tbl.play.height/2-10)
	love.graphics.print(tbl.settings.text, tbl.settings.xPos+tbl.settings.width/2-fontLarge:getWidth(tbl.settings.text)/2, tbl.settings.yPos+tbl.settings.height/2-10)
	love.graphics.print(tbl.help.text, tbl.help.xPos+tbl.help.width/2-fontLarge:getWidth(tbl.help.text)/2, tbl.help.yPos+tbl.help.height/2-10)
	love.graphics.print(tbl.quit.text, tbl.quit.xPos+tbl.quit.width/2-fontLarge:getWidth(tbl.quit.text)/2, tbl.quit.yPos+tbl.quit.height/2-10)
	
	love.graphics.setColor(255,50,50,255)
	love.graphics.setFont(fontXLarge)
	love.graphics.print("The Dungeon of Evwiniir", w/2-fontXLarge:getWidth("The dungeon of Evwiniir")/2, 10)
	love.graphics.setFont(fontLarge)
	love.graphics.setColor(255,255,255,255)
end
 
function main.keypressed(key)
	if key == "escape" then love.event.quit() end
end

--[[
	Checking for button clicks/touches, if a button is clicked it goes to the relevent game state
--]]
function main.mousepressed(x,y,btn)
	if  (btn == "l") then
		if(x > menu.buttons.play.xPos and x < menu.buttons.play.xPos + menu.buttons.play.width and
		   y > menu.buttons.play.yPos and y < menu.buttons.play.yPos + menu.buttons.play.height) then
			navigationSound:play()	
			player.score = 0
			loadState(gameState)
			gameState:load()
			return
		elseif(x > menu.buttons.settings.xPos and x < menu.buttons.settings.xPos + menu.buttons.settings.width and
		   y > menu.buttons.settings.yPos and y < menu.buttons.settings.yPos + menu.buttons.settings.height) then
			navigationSound:play()
			loadState(settingState)
			settingState:load()
			return
		elseif(x > menu.buttons.help.xPos and x < menu.buttons.help.xPos + menu.buttons.help.width and
		   y > menu.buttons.help.yPos and y < menu.buttons.help.yPos + menu.buttons.help.height) then
			navigationSound:play()
			loadState(helpState)
			helpState:load()
			return
		elseif(x > menu.buttons.quit.xPos and x < menu.buttons.quit.xPos + menu.buttons.quit.width and
		   y > menu.buttons.quit.yPos and y < menu.buttons.quit.yPos + menu.buttons.quit.height) then
			navigationSound:play()
			love.event.quit()
			return
		end
	end
end

