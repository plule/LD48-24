require "game"

gameover = Gamestate.new()

function gameover:init()

end

function gameover:enter(previous, message)
	self.previous = previous
	self.message = message
end

function gameover:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.print("Game Over : "..self.message.."\nPress Enter to retry", 100, 100)
end

function gameover:keypressed(key)
	if(key == "return") then
		Gamestate.switch(self.previous)
	end
end
