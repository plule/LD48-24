require "game"

gameover = Gamestate.new()

function gameover:init()

end

function gameover:enter(previous, message, level)
	self.previous = previous
	self.message = message
	self.level = level
end

function gameover:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.setFont(SmallFont)
	love.graphics.print("Game Over : "..self.message, 10, 50)
	love.graphics.print("Press Enter to retry", 10, 500)
end

function gameover:keypressed(key)
	if(key == "return") then
		Gamestate.switch(self.previous, self.level)
	end
end
