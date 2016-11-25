-- Functions for determining whether a point is inside a triangle
-- http://www.gamedev.net/topic/295943-is-this-a-better-point-in-triangle-test-2d/
function sameSide(p1x,p1y, p2x,p2y, p3x,p3y)
    return (p1x - p3x) * (p2y - p3y) - (p2x - p3x) * (p1y - p3y) -- Used to determine which side of the line the point is on (I cannot confirm whether that is actually what it does, but it works)
end
function isPointInTriangle(mx,my, v1x,v1y, v2x,v2y, v3x,v3y)
    b1 = sameSide(mx,my, v1x,v1y, v2x,v2y) < 0.0
    b2 = sameSide(mx,my, v2x,v2y, v3x,v3y) < 0.0
    b3 = sameSide(mx,my, v3x,v3y, v1x,v1y) < 0.0
    return ((b1 == b2) and (b2 == b3)) -- return true if b1, b2, and b3 are all equal
end
-- end triangle functions

-- Spacing between each button point
xSpacing = w/3
ySpacing = h/3

buttonPoints = {
	-- Define the points used for the buttons
	topLeft = {x=0,y=0}, -- 32 pixel offset due to the status bar being there
	topRight = {x=w,y=0},
	bottomLeft = {x=0,y=h},
	bottomRight = {x=w,y=h},
	centre = {x=w/2,y=h/2},
}

-- The third point gets implicitly called in the checkPress function to neaten up the code.
-- Each button has the centre point as the third point
button = { 
	left = {p1 = buttonPoints.topLeft, p2 = buttonPoints.bottomLeft}, 
	up = {p1 = buttonPoints.topLeft, p2 = buttonPoints.topRight},
	down = {p1 = buttonPoints.bottomLeft, p2 = buttonPoints.bottomRight},
	right = {p1 = buttonPoints.topRight, p2 = buttonPoints.bottomRight},
}

-- This function checks whether the mouse/touch point is within the bounds of one of the triangular buttons
-- Returns a number (1 = left, 2 = right, 3 = up, 4 = down)
function button:checkPress(clickPoint, playerX, playerY)
	-- left
	if isPointInTriangle(clickPoint.x,clickPoint.y, self.left.p1.x,self.left.p1.y, self.left.p2.x,self.left.p2.y, playerX*32-16,playerY*32-16) then
		return 1
	end
	
	-- right
	if isPointInTriangle(clickPoint.x,clickPoint.y, self.right.p1.x,self.right.p1.y, self.right.p2.x,self.right.p2.y, playerX*32-16,playerY*32-16) then
		return 2
	end
	
	-- up
	if isPointInTriangle(clickPoint.x,clickPoint.y, self.up.p1.x,self.up.p1.y, self.up.p2.x,self.up.p2.y, playerX*32-16,playerY*32-16) then
		return 3
	end
	
	-- down
	if isPointInTriangle(clickPoint.x,clickPoint.y, self.down.p1.x,self.down.p1.y, self.down.p2.x,self.down.p2.y, playerX*32-16,playerY*32-16) then
		return 4
	end
end