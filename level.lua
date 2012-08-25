Class = require "hump.class"

Level = Class{
	function(self, type, x1, x2)
		self.x1 = x1
		self.x2 = x2
		self.y = 100
		self.type = type
		self.wheight = love.graphics.getHeight()		
		if(self.type == "run") then
			self.drawy = self.wheight - self.y
		end

	end}

function Level:draw()
	if(self.type == "run") then
		love.graphics.setColor(255,255,255)
		love.graphics.rectangle("fill", self.x1, self.drawy, self.x1+self.x2, self.wheight)
		for _,obstacle in ipairs(self.obstacles) do
			if(obstacle.type == "cactus") then
				love.graphics.setColor(0,255,0)
				love.graphics.rectangle("fill", obstacle.x-16, self.drawy, 32, -64)
			end
		end
	end
end

function Level:setObstacles(obstacles)
	self.obstacles = obstacles
end

function Level:getY(x)
	return self.y
end
