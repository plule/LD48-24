Obstacle = Class{
	function(self, id, type, x, y, lx, ly, color)
		self.id = id
		self.type = type
		self.x = x
		self.y = y
		self.lx = lx
		self.ly = ly
		self.color = color
	end}

function Obstacle:draw()
	love.graphics.setColor(self.color)
	if(collide(game.player, self)) then
		love.graphics.setColor(255,0,0,170)
	end
	love.graphics.rectangle("fill", self.x-self:getLX()/2, Height-self:getY() - self:getLY(), self:getLX(), self:getLY())
end

function Obstacle.create(type, x, y)
	if(type == "cactus") then
		return Obstacle(type, type, x, y, 32, 60, {0,255,255,170})
	elseif(type == "bird") then
		return Obstacle(type, type, x, y, 32, 10, {200, 200, 200, 170})
	elseif(type == "jellyfish") then
		return Obstacle(type, type, x, y, 32, 40, {50, 50, 200, 170})
	end
end

function Obstacle:update(dt)
end

function Obstacle:getX()
	return self.x
end
function Obstacle:getY()
	return self.y
end
function Obstacle:getLX()
	return self.lx
end
function Obstacle:getLY()
	return self.ly
end
