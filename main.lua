Class = require "hump.class"

require "game"

function love.load()
	Height = love.graphics.getHeight()
	Gamestate.switch(game)
	Gamestate.registerEvents()
end

function love.update(dt)
end

function love.draw()
end
