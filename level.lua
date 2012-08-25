require("obstacle")

Level = Class{
	function(self, id, type, x1, x2)
		self.id = id
		self.x1 = x1
		self.x2 = x2
		self.y = 100
		self.type = type
		if(self.type == "run") then
			self.y = 100
			self.drawy = Height - self.y
		elseif(self.type == "swim") then
			self.y = 500
			self.drawy = Height - self.y
		end

	end}

function Level:draw()
	if(self.type == "run") then
		love.graphics.setColor(255,255,255, 170)
		love.graphics.rectangle("fill", self.x1, self.drawy, self.x1+self.x2, Height)
		for _,obstacle in ipairs(self.obstacles) do
			obstacle:draw()
		end
	elseif(self.type == "swim") then
		love.graphics.setColor(0,0,255, 50)
		love.graphics.rectangle("fill", self.x1, self.drawy, self.x1+self.x2, Height)
	end
end

function Level:update(dt, player)
	for _,obstacle in ipairs(self.obstacles) do
		obstacle:update(dt)
	end
	
	if(self.type == "run") then
		self.player.y = self.currLevel:getY(self.player.x)
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
	if(self.type == "run") then
		if(key == "up") then
			player:jump()
		elseif(key == "down") then
			player:crouch()
		end
	end
end
