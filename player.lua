Player = Class{
	function(self, x, y)
		self.x = x
		self.y = y
		self.lx = 32
		self.ly = 32
		self.jumping = false
		self.jumpy = 0
		self.jumpid = nil
	end}

function Player:draw()
	love.graphics.setColor(255,0,255, 170)
	love.graphics.print(self.jumpy, self.x,50)
	love.graphics.rectangle("fill", self.x-self.lx/2, Height-self.y-self.ly-self.jumpy, self.lx, self.ly)
end

function Player:jump()
	self.jumping = true
	if(self.jumpid == nil) then
		self.jumpid = tween(0.25, self, {jumpy = 64}, 'outCubic',
							function()
								self.jumpid = tween(0.25, self, {jumpy = 0}, 'inCubic',
													function()
														self.jumpid = nil
														self.jumping = false
													end)
							end)
	end
end
