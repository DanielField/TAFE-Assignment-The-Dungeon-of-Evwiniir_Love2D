--[[
	Loads a state by taking functions from the specified table and replacing the love callback functions.

	tbl - Table that contains all of the necessary functions to replace the love callbacks
--]]
function loadState(tbl)
	love.update = tbl.update
	love.draw = tbl.draw
	love.keypressed = tbl.keypressed
	love.mousepressed = tbl.mousepressed
	love.mousereleased = tbl.mousereleased
end