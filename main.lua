Class = require "hump.class"
Timer = require "hump.timer"
Gamestate = require "hump.gamestate"
tween = require "tween"

require "game"

function love.load()
	Height = love.graphics.getHeight()
	Gamestate.switch(game)
end

function love.update(dt)
	if(dt > 0) then
		tween.update(dt)
		Gamestate.update(dt)
	end
end

function love.draw()
	Gamestate.draw()
end

function love.keypressed(key)
	Gamestate.keypressed(key)
end

-- Collision detection function.
-- Checks if a and b overlap.
-- w and h mean width and height.
function CheckCollision(ax1,ay1,aw,ah, bx1,by1,bw,bh)

  local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
  return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end

function collide(obj1, obj2)
	return CheckCollision(obj1:getX(), obj1:getY(), obj1:getLX(), obj1:getLY(),
						  obj2:getX(), obj2:getY(), obj2:getLX(), obj2:getLY())
end
