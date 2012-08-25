require("obstacle")

Level = Class{
	function(self, id, type, x1, x2, y)
		self.id = id
		self.x1 = x1
		self.x2 = x2
		self.y = y
		self.type = type
		self.slope = 500
		if(self.type == "run") then
			self.drawy = Height - self.y
		elseif(self.type == "swim") then
			self.drawy = Height - self.y
		end

	end}

function Level:draw()
	if(self.type == "run") then
		love.graphics.setColor(255,255,255, 170)
		local y = Height-self.y
		local x1 = self.x1
		local x2 = self.x2
		local slope = self.slope
		love.graphics.polygon("fill",x1+slope,y, x2-slope,y, x2,Height, x1,Height)
	elseif(self.type == "swim") then
		love.graphics.setColor(0,0,255, 50)
		love.graphics.rectangle("fill", self.x1, self.drawy, self.x2, 10000)
	end
	for _,obstacle in ipairs(self.obstacles) do
		obstacle:draw()
	end
end

function Level:update(dt, player)
	for _,obstacle in ipairs(self.obstacles) do
		obstacle:update(dt)
	end
	
	if(self.type == "run") then
		player.y = self:getY(player.x)
	end
	if(self.type == "swim") then
		player.speedy = 0
		if(love.keyboard.isDown("up")) then
			   player.speedy = 150
		end
		if(love.keyboard.isDown("down")) then
			   player.speedy = -150
		end
		local breathing = true
		if(player:getY()+player:getLY() < self:getY(game:getX())) then
			breathing = false
		end
		player.breathing = breathing
	end
	player:update(dt)
	if(self.type == "swim") then
		if(player:getY() > self:getY(game:getX()) - player:getLY()/2) then
			player.y = self:getY(game:getX()) - player:getLY()/2
		end
	end
end

function Level:setObstacles(obstacles)
	self.obstacles = {}
	for _,obstacle in ipairs(obstacles) do
		local y = obstacle.y
		local x = obstacle.x + self.x1
		if(y == nil) then
			y = self:getY(x)
			if (obstacle.type == "bird") then
				y = y+20
			end
		end
		table.insert(self.obstacles, Obstacle.create(obstacle.type, x, y))
	end
end

function Level:getY(x)
	local x1, x2, y, slope = self.x1, self.x2, self.y, self.slope
	if(self.type == "run") then
		if(x < x1+slope) then return y-(x1+slope-x)*(y/slope) end
		if(x > x2-slope) then return y-(x-x2+slope)*(y/slope) end
	end
	return y
end

function Level:keypressed(key, player)
	if(self.type == "run") then
		if(key == "up") then
			player:jump()
		elseif(key == "down") then
			player:crouch()
		end
	end
end
