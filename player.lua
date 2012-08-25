Player = Class{
	function(self,id, x, y)
		self.id = id
		self.x = x
		self.y = y
		self.lx = 32
		self.ly = 32
		self.speedy = 0
		self.crouchy = 0
		self.crouchid = nil
		self.breathe = 1
		self.breathing = true
		self.swimming = false
		self.onGround = false
	end}

function Player:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.print("swimming "..tostring(self.swimming), self:getX(), Height-self:getY()-100)
	love.graphics.print("onGround "..tostring(self.onGround), self:getX(), Height-self:getY()-70)
	love.graphics.setColor(255,0,255, 170)
	if(not self.breathing) then
		love.graphics.setColor(255, 0, 0, 170)
	end
	love.graphics.rectangle(
		"fill", self:getX()-self:getLX()/2, Height-self:getY()-self:getLY(), self:getLX(), self:getLY())
end

function Player:jump()
	self.speedy = 1000
end

function Player:crouch()
	self.crouchid = tween(0.25, self, {crouchy = 16}, 'outCubic',
						  function()
							  self.crouchid = tween(0.25, self, {crouchy = 0}, 'inCubic',
													function()
														self.crouchid = nil
													end)
						  end)
end

function Player:update(dt)
	-- Input
	if(self.swimming) then
		if(love.keyboard.isDown("up")) then
			self.speedy = 500
		elseif(love.keyboard.isDown("down")) then
			self.speedy = -500
		end
	end

	-- Science
	self.y = self.y + self.speedy*dt
	if(not self.swimming) then
		self.speedy = self.speedy-5000*dt
	else
		self.speedy = self.speedy-0.01*self.speedy
	end
end

function Player:keypressed(key)
	if(self.onGround) then
		if(key == "up") then
			self:jump()
		elseif(key == "down") then
			self:crouch()
		end
	end
end

function Player:acting()
	return (self.jumpid ~= nil) or (self.crouchid ~= nil)
end

function Player:getX()
	return self.x
end
function Player:getY()
	return self.y
end
function Player:getLX()
	return self.lx
end
function Player:getLY()
	return self.ly-self.crouchy
end
