require("obstacle")

Level = Class{
	function(self, order, id, type, x1, x2, y)
		self.order = order
		self.id = id
		self.x1 = x1
		self.x2 = x2
		self.y = y
		self.type = type
		self.slope = 500
		self.obstacles = {}
	end}

Level.DefaultForms = {
	run = "runner",
	swim = "siren",
	fly = "bird"
}

function Level:draw()
	local y = Height-self.y
	local x1 = self.x1
	local x2 = self.x2
	
	if(self.type == "run") then
		love.graphics.setColor(150,150,150)
		local slope = self.slope
		love.graphics.polygon("fill",x1+slope,y, x2-slope,y, x2,Height, x2,3000, x1,3000, x1,Height)
	elseif(self.type == "swim") then
		love.graphics.setColor(75,106,110)
		love.graphics.rectangle("fill", x1, y, x2-x1, 10000)
	elseif(self.type == "ceiling") then
		love.graphics.setColor(150,150,150)
		love.graphics.polygon("fill", x1,y, x2,y, x2,y-1000, x1,y-1000)
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
			if(player.speedy < 0) then player.speedy = 0 end
			player.onGround = true
		end
		if(px > self.x1 and px < self.x2 and player.y <= self:getY(player.x)+3) then
			player.onGround = true
		end
	elseif(self.type == "swim") then
		local breathing = true
		if(px > self.x1 and px < self.x2 and py+ply < self:getY(player.x)) then
			player.swimming = true
		end
		if(px > self.x1 and px < self.x2 and py+ply < self:getY(game:getX())) then
			player.breathing = false
		end
	elseif(self.type == "ceiling") then
		if(px > self.x1 and px < self.x2 and player.y+player:getLY() >= self:getY(player.x)) then
			player.y = self:getY(player.x)-player:getLY()
			player.onCeiling = true
		end
	end


end

function Level:setObstacles(obstacles)
	for _,obstacle in ipairs(obstacles) do
		local y = obstacle.y
		local x = obstacle.x + obstacleOffset
		obstacleOffset = x
		if(y == nil) then
			y = self:getY(x)
			if (obstacle.type == "bird") then
				y = y+50
			elseif (obstacle.type == "stalactite") then
				y = y-105
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
