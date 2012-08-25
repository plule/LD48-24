Obstacle = Class{
	function(self, id, type, x, y, lx, ly)
		self.id = id
		self.type = type
		self.x = x
		self.y = y
		self.lx = lx
		self.ly = ly
	end}

function Obstacle:draw()
	love.graphics.setColor(0,255,0,170)
	if(collide(game.player, self)) then
		love.graphics.setColor(255,0,0,170)
	end
	love.graphics.rectangle("fill", self.x-self.lx/2, Height - self.y - self.ly, self.lx, self.ly)
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
