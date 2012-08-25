function love.load()
	time = 0
end

function love.update(dt)
	time = time+dt
end

function love.draw()
	love.graphics.print(time, 100, 100)
end
