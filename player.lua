Player = Class{
	function(self,id, x, y)
		self.id = id
		self.x = x
		self.y = y
		self.lx = 32
		self.ly = 32
		self.speedy = 0
		self.jumpy = 0
		self.jumpid = nil
		self.crouchy = 0
		self.crouchid = nil
		self.breathe = 1
		self.breathing = true
	end}

function Player:draw()
	love.graphics.setColor(255,0,255, 170)
	if(not self.breathing) then
		love.graphics.setColor(255, 0, 0, 170)
	end
	love.graphics.rectangle(
		"fill", self:getX()-self:getLX()/2, Height-self:getY()-self:getLY(), self:getLX(), self:getLY())
end

function Player:jump()
	if(not self:acting()) then
		self.jumpid = tween(0.25, self, {jumpy = 64}, 'outCubic',
							function()
								self.jumpid = tween(0.25, self, {jumpy = 0}, 'inCubic',
													function()
														self.jumpid = nil
													end)
							end)
	end
end

function Player:crouch()
	if(not self:acting()) then
		self.crouchid = tween(0.25, self, {crouchy = 16}, 'outCubic',
							function()
								self.crouchid = tween(0.25, self, {crouchy = 0}, 'inCubic',
													function()
														self.crouchid = nil
													end)
							end)
	end
end

function Player:update(dt)
	self.y = self.y + self.speedy*dt
end

function Player:acting()
	return (self.jumpid ~= nil) or (self.crouchid ~= nil)
end

function Player:getX()
	return self.x
end
function Player:getY()
	return self.y+self.jumpy
end
function Player:getLX()
	return self.lx
end
function Player:getLY()
	return self.ly-self.crouchy
end
