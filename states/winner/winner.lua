--[[
	Displays when the player runs out of levels to complete (or picks an invalid level via cheating)
--]]

winnerState = {}

function winnerState.load()

	victory = love.audio.newSource("states/game/audio/WellDone.ogg","static")-- http://opengameart.org/content/well-done
		
	levelComplete:play()
	victory:play()

	buttons = 
	{
		back = {width=100,
				height=60,
				xPos=w-110,
				yPos=10,
				text="Return"},
	}

end

function winnerState.update(dt)

end

function winnerState.draw()
	if(hasHappyTheme) then
		love.graphics.setBackgroundColor(255,255,255)
		love.graphics.setColor(200,200,0,255)
	else
		love.graphics.setBackgroundColor(0,0,0)
	end

	love.graphics.print("Congratulations! You have successfully escaped the dungeon of Evwiniir!", 10, 10)
	
	love.graphics.rectangle("fill",buttons.back.xPos,buttons.back.yPos,buttons.back.width,buttons.back.height)
	love.graphics.setColor(255,255,255,255)
	
	love.graphics.setColor(0,0,255,255)
	love.graphics.print(buttons.back.text, buttons.back.xPos+buttons.back.width/2-fontLarge:getWidth(buttons.back.text)/2, buttons.back.yPos+buttons.back.height/2-10)
	love.graphics.setColor(255,255,255,255)
end
 
function winnerState.keypressed(key)
	if key == "escape" then 
		loadState(main)
		main:load() 
	end
end

function winnerState.mousepressed(x,y,btn)
	if  (btn == "l") then
		if(x > buttons.back.xPos and x < buttons.back.xPos + buttons.back.width and
		   y > buttons.back.yPos and y < buttons.back.yPos + buttons.back.height) then
			navigationSound:play()
			loadState(main)
			main:load()
		end
	end
end