Player = Class{
	function(self,id, x, y)
		self.id = id
		self.x = x
		self.y = y
		self.lx = 30
		self.ly = 60
		
		self.spriteLX = 64
		self.spriteLY = 64

		self.speedy = 0
		self.crouchy = 0
		self.crouchid = nil
		self.breathe = 1
		self.airtime = 1
		self.breathing = true
		self.swimming = false
		self.onGround = false
		self.dieText = ""
		self.transformation = nil
		
		self.form = "runner" --siren bird
	end}

local reasons = {
	runner = {
		cactus = "You ran into a stalagmite.\nIt was more aggressive than expected.",
		stalactite = "You should have crouched.\nNow you are dead.",
		bird = "A bird killed you.\nIt's a bad bird.",
		water = "Your lung are full of water.\nYou die.",
		jellyfish = "Somehow you manage to be killed\nby a jellyfish before drowning",
		fall = "You broke your legs.",
		stupidbird = "This bird wasn't aggressive.\nBad place, bad time."
	},
	siren = {
		cactus = "I don't know how it's possible,\nbut a stalagmite killed you while you were a fish.",
		bird = "A water-bird killed you.",
		air = "You can't stay too long\nout of water in this form.",
		fall = "You die under water's pressure.",
		water = "Even a siren can drown.",
		jellyfish = "Be careful of the jellyfishes.\nIt's a bad thing. Really.",
		badfish = "This is a bad fish.\nNot a friend.",
		stupidfish = "Why did you try to\nhug a fish?"},
	
	bird = {
		cactus = "A stalagmite destroyed your wings.\nYou die out of sadness.",
		stalactite = "Nope, birds can't crouch.\nSorry.",
		bird = "This bird was stronger than you.",
		stupidbird = "Avoid other birds.\nThey have hard beak.",
		water = "You are not a flying fish.\nSorry.",
		ground = "You crashed on the ground.\nBe careful.",
		jellyfish = "This is not supposed to happened.",
		ceiling = "Like Icare, you died.",
		fall = "You forgot to use you wings."}
}

function Player:draw()
	love.graphics.setColor(255,255,255)
--	love.graphics.print("level    "..self:getLevel().id, self:getX(), Height-self:getY()-130)
	-- love.graphics.print("breathe  "..tostring(self.breathe), self:getX(), Height-self:getY()-115)
	-- love.graphics.print("swimming "..tostring(self.swimming), self:getX(), Height-self:getY()-100)
	-- love.graphics.print("onGround "..tostring(self.onGround), self:getX(), Height-self:getY()-85)
	-- love.graphics.print("form     "..self.form, self:getX(), Height-self:getY()-70)
	-- love.graphics.print("die      "..self.dieText, self:getX(), Height-self:getY()-55)
	if(self.form == "siren") then
		if(self.speedy > 0) then
			game.animations.sirenup:draw(self:getX()-self.spriteLX/2, Height-self.spriteLY-self:getY())
		else
			game.animations.sirendown:draw(self:getX()-self.spriteLX/2, Height-self.spriteLY-self:getY())
		end
	elseif(self.form == "bird") then
		if(self.speedy > 0) then
			game.animations.birdup:draw(self:getX()-self.spriteLX/2, Height-75-self:getY())
		else
			game.animations.birddown:draw(self:getX()-self.spriteLX/2, Height-75-self:getY())
		end
	elseif(not self.onGround) then
		if(self.speedy > 0) then
			game.animations.jumpup:draw(self:getX()-self.spriteLX/2, Height-self.spriteLY-self:getY())
		else
			game.animations.jumpdown:draw(self:getX()-self.spriteLX/2, Height-75-self:getY())
		end
	elseif(self.crouchid ~= nil) then
--		love.graphics.setColor(255,0,255, 170)
--		if(not self.breathing) then
--			love.graphics.setColor(255, 0, 0, 170)
--		end
--		love.graphics.rectangle(
--			"fill", self:getX()-self:getLX()/2, Height-self:getY()-self:getLY(), self:getLX(), self:getLY())
		game.animations.crouch:draw(self:getX()-self.spriteLX/2, Height-self.spriteLY-self:getY())
	else
		game.animations.runner:draw(self:getX()-self.spriteLX/2, Height-self:getY()-self.spriteLY)
	end
	if(self.transformation) then
		game.animations.magic:draw(self:getX()-self.spriteLX/2, Height-self:getY()-self.spriteLY)
	end
end

function Player:jump()
	if(not self:acting()) then
		self.speedy = 1100
	end
end

function Player:crouch()
	if(not self:acting()) then
		game.animations.crouch:reset()
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
	-- Die conditions
	--if(self.form == "siren" and not self.swimming and self.onGround) then
	--	self:die("air")
	--elseif((self.form == "runner" or self.form == "bird") and self.swimming) then
	--	self:die("water")
	if(self:getY() >= 800) then
		self:die("ceiling")
	elseif(self:getY() <= -500) then
		self:die("fall")
	end

	-- Input
	if(self.form == "siren" and self.swimming) then
		if(love.keyboard.isDown("up")) then
			self.speedy = 500
		elseif(love.keyboard.isDown("down")) then
			self.speedy = -500
		end
	end

	if(not self.breathing) then
		self.breathe = self.breathe - dt / 5
		if(self.breathe < 0) then
			self:die("water")
		end
	else
		self.breathe = 1
	end

	if(self.form == "siren" and not self.swimming) then
		self.airtime = self.airtime - dt / 2
		if(self.airtime < 0) then
			self:die("air")
		end
	else
		self.airtime = 1
	end

	-- Science
	self.y = self.y + self.speedy*dt
	if(not self.swimming) then
		self.speedy = self.speedy-5000*dt-self.speedy*0.01
	elseif(form == "siren") then
		self.speedy = self.speedy-self.speedy*0.05
	else
		self.speedy = self.speedy-5000*dt-self.speedy*0.05
	end
end

function Player:keypressed(key)
	if(key == "f1" or key == "1" or key == "c") then
		self:transformTo("runner")
	elseif(key == "f2" or key == "2" or key == "v") then
		self:transformTo("siren")
	elseif(key == "f3" or key == "3" or key == "b") then
		self:transformTo("bird")
	end
	if(self.form == "runner") then
		if(key == "up") then
			self:jump()
		elseif(key == "down") then
			self:crouch()
		end
	elseif(self.form == "bird" and not self.swimming) then
		if(key == "up") then
			self.speedy = 1000
		end
	end
end

function Player:transformTo(form)
	if(self.transformation) then
		Timer.cancel(self.transformation)
	end
	game.transformsound:play()
	self.transformation = Timer.add(2, function()
										self.form = form
										self.transformation = nil
									   end)
end

function Player:die(reason)
	if(game.winfader == nil) then
		self.dieText = reasons[self.form][reason]
		if(self.dieText == nil) then self.dieText = "You died." end
		Gamestate.switch(gameover, self.dieText, self:getLevel())
	end
end

function Player:inLevel(level, since)
	return (self:getX() > level.x1 + (500*since) and self:getX() < level.x2 + (500*since))
end

function Player:getLevel()
	local level = self:getLevelFind()
	if(game.startlevel ~= nil and game.startlevel.order > level.order) then
		return game.startlevel
	else
		return level
	end
end

function Player:getLevelFind()
	local inlevel = nil
	for _,level in pairs(game.levels) do
		if((level.type == "swim" or level.type == "run" or level.type == "fly") and self:inLevel(level, 3)) then
			return level
		end
	end
	for _,level in pairs(game.levels) do
		if((level.type == "swim" or level.type == "run" or level.type == "fly") and self:inLevel(level, 0)) then
			return level
		end
	end
	return game.startlevel
end
		

function Player:acting()
	return (not self.onGround) or (self.crouchid ~= nil)
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
