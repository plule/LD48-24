menu = Gamestate.new()
function menu:init()

end

function menu:enter()

end

function menu:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.print("Controls :\nUp/Down arrows\nF1, F2, F3 to transform.\nPress Enter to start",100, 100)
end

function menu:keypressed(key)
	if(key == "return") then
		Gamestate.switch(game)
	end
end
