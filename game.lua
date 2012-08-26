require "player"
require "level"
require "AnAL"

game = Gamestate.new()
function game:init()
	self.sprites = {
		jellyfish = love.graphics.newImage("img/jellyfish.png"),
		cactus = love.graphics.newImage("img/cactus.png"),
		runner = love.graphics.newImage("img/runner.png")
	}
	for _,pic in pairs(self.sprites) do
		pic:setFilter("nearest", "nearest")
	end
	self.animations = {
		jellyfish = newAnimation(self.sprites.jellyfish, 16, 32, 0.3, 0),
		runner = newAnimation(self.sprites.runner, 64, 64, 0.07, 0)
	}
	self.animations.jellyfish:setMode("bounce")
end

function game:enter()
	self.time = 0
	self.player = Player("player", 0, 100)
	self.player.form = "runner"
	self.levels = {
		run1=Level("run1", "run", 0, 3000, 100),
--		swim1=Level("swim1", "swim", 2500, 5000, 70),
--		run2=Level("run2", "run", 4000, 5000, 100),
--		run3=Level("run3", "run", 5000, 6000, 100),
--		swim2=Level("swim2", "swim", 5500, 7000, 70),
		ceiling=Level("ceiling", "ceiling", 0, 2000, 260)
	}
	obstacleOffset = 0
	self.levels.run1:setObstacles(
		{{x=800,type="cactus"},{x=600,type="cactus"},
		 {x=600, type="cactus"}})
--[[	obstacleOffset = self.levels.swim1.x1
	self.levels.swim1:setObstacles({{x=1000, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"}})
	obstacleOffset = self.levels.run2.x1
	self.levels.run2:setObstacles(
		{{x=500,type="cactus"},{x=800,type="cactus"},{x=1200,type="cactus"},
		 {x=700, type="bird"},{x=1000, type="bird"}})
	self.levels.run3:setObstacles({})
	self.levels.swim2:setObstacles({})]]
	obstacleOffset = self.levels.ceiling.x1
	self.levels.ceiling:setObstacles({{x=1100, type="stalactite"},{x=600, type="stalactite"}})--,{x=600, type="stalactite"},{x=600, type="stalactite"}})
end

function game:update(dt)
	self.time = self.time + dt

	for _,animation in pairs(self.animations) do
		animation:update(dt)
	end
	local player = self.player
	player.x = self:getX()
	self.player:update(dt)

	for _,level in pairs(self.levels) do
		level:update(dt, self.player)
	end
	player.onGround = false
	player.swimming = false
	player.breathing = true
	player.onCeiling = false
	for _,level in pairs(self.levels) do
		level:act_on(self.player)
	end
end

function game:draw()
--	love.graphics.scale(2,2)
	local cx = -self.player:getX()+100
	local cy = self.player:getY()-Height/2
	if(cy < -400) then cy = -400 end
	if(cy > 200) then cy = 200 end
	love.graphics.push()
	love.graphics.translate(cx, cy)
	love.graphics.setColor(200,200,200, 50)
	love.graphics.rectangle("fill",0,0,100000,100000)
	love.graphics.rectangle("fill",0,500,100000,100000)
	love.graphics.rectangle("fill",0,700,100000,100000)
	love.graphics.rectangle("fill",0,1000,100000,100000)
	for _,level in pairs(self.levels) do
		if(level.type == "swim") then
			level:draw()
		end
	end
	for _, level in pairs(self.levels) do
		if(level.type ~= "swim") then
			level:draw()
		end
	end

	self.player:draw()
	love.graphics.pop()
	love.graphics.setColor(255,255,0)
	love.graphics.print(cy, 100, 100)
	love.graphics.print(self.player:getY(), 100, 120)
end

function game:getX()
	return self.time*500
end

function game:keypressed(key)
	self.player:keypressed(key)
end
