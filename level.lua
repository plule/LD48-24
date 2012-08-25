require("obstacle")

Level = Class{
	function(self, id, type, x1, x2)
		self.id = id
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
		love.graphics.setColor(255,255,255, 170)
		love.graphics.rectangle("fill", self.x1, self.drawy, self.x1+self.x2, self.wheight)
		for _,obstacle in ipairs(self.obstacles) do
			obstacle:draw()
		end
	end
end

function Level:setObstacles(obstacles)
	self.obstacles = {}
	print("---------")
	for _,obstacle in ipairs(obstacles) do
		print(obstacle.x)
		table.insert(self.obstacles, Obstacle("cactus", obstacle.type, obstacle.x, self:getY(obstacle.x), 32, 60))
	end
end

function Level:getY(x)
	return self.y
end
