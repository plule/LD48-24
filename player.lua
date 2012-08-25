Class = require "hump.class"

Player = Class{
	function(self, x, y)
		self.x = x
		self.y = y
		self.lx = 32
		self.ly = 32
	end}

function Player:draw()
	love.graphics.setColor(255,0,255)
	love.graphics.rectangle("fill", self.x-self.lx/2, Height-self.y-self.ly, self.lx, self.ly)
	print("fill", self.x-self.lx/2, Height-self.y-self.ly, self.lx, self.ly)
end
