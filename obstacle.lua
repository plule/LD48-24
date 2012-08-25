Obstacle = Class{
	function(self, id, type, x, y, lx, ly, color, animation, sprite)
		self.id = id
		self.type = type
		self.x = x
		self.y = y
		self.lx = lx
		self.ly = ly
		self.color = color
		self.animation = animation
		self.sprite = sprite
		local speed = 0
	end}

function Obstacle:draw()
	love.graphics.setColor(self.color)
--	if(collide(game.player, self)) then
--		love.graphics.setColor(255,0,0,170)
--	end
	local x,y = self.x-self:getLX()/2, Height-self:getY() - self:getLY()
	if(self.animation ~= nil) then
		love.graphics.setColor(255,255,255)
		self.animation:draw(x,y)
	elseif(self.sprite ~=nil) then
		love.graphics.setColor(255,255,255)
		love.graphics.draw(self.sprite, x,y)
	else
		love.graphics.rectangle("fill", x,y, self:getLX(), self:getLY())
	end
end

function Obstacle.create(type, x, y)
	if(type == "cactus") then
		return Obstacle(type, type, x, y, 32, 60, {0,255,255,170}, nil, game.sprites.cactus)
	elseif(type == "bird") then
		return Obstacle(type, type, x, y, 32, 64, {200, 200, 200, 170})
	elseif(type == "jellyfish") then
		return Obstacle(type, type, x, y, 16, 32, {50, 50, 200, 170}, game.animations.jellyfish)
	elseif(type == "badfish") then
		local fish = Obstacle(type, type, x, y, 16, 16, {250, 50, 200, 170})
		fish.speed = math.random(100,200)
		return fish
	end
end

function Obstacle:update(dt)
	if (self.type == "badfish") then
		local player = game.player
		if(player.swimming) then
			local speed
			if(player:getY() > self:getY()) then
				speed = self.speed
			else
				speed = -self.speed
			end

			self.y = self:getY()+speed*dt
		end
	end
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
