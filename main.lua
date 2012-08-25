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
