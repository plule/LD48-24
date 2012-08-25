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
		if(collide(obstacle,player)) then
			player:die(obstacle.type)
		end
	end
end


function Level:act_on(player)
	local px,py,plx,ply = player:getX(), player:getY(), player:getLX(), player:getLY()
	if(self.type == "run") then
		if(px > self.x1 and px < self.x2 and player.y <= self:getY(player.x)) then
			player.y = self:getY(player.x)
			player.onGround = true
		end
	end

	if(self.type == "swim") then
		local breathing = true
		if(px > self.x1 and px < self.x2 and py+ply < self:getY(player.x)) then
			player.swimming = true
		end
		if(px > self.x1 and px < self.x2 and py+ply < self:getY(game:getX())) then
			player.breathing = false
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
