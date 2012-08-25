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

function Level:update(dt)
	for _,obstacle in ipairs(self.obstacles) do
		obstacle:update(dt)
	end
end

function Level:setObstacles(obstacles)
	self.obstacles = {}
	for _,obstacle in ipairs(obstacles) do
		local x = obstacle.x
		local y = 0
		local lx = 32
		local ly = 0
		if(obstacle.type == "cactus") then
			y = self:getY(x)
			ly = 60
		elseif(obstacle.type == "bird") then
			y = self:getY(x)+30
			ly = 10
		end
		table.insert(self.obstacles, Obstacle(obstacle.type, obstacle.type, x,y,lx,ly))
	end
end

function Level:getY(x)
	return self.y
end

function Level:keypressed(key, player)
	if(key == "up") then
		player:jump()
	elseif(key == "down") then
		player:crouch()
	end
end
