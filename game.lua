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
		runner = newAnimation(self.sprites.runner, 64, 64, 0.05, 0)
	}
	self.animations.jellyfish:setMode("bounce")
end

function game:enter()
	self.time = 0
	self.player = Player("player", 0, 100)
	self.player.form = "siren"
	self.levels = {
--		Level("run1", "run", 0, 3000, 100),
		Level("swim1", "swim", 0, 5000, 70),
--		Level("run2", "run", 4000, 5000, 100),
--		Level("run3", "run", 5000, 6000, 100),
--		Level("swim2", "swim", 5500, 7000, 70)
	}
	obstacleOffset = 0
--	self.levels[1]:setObstacles(
--		{{x=300,type="cactus"},{x=300,type="bird"},{x=300,type="cactus"},
--		 {x=500, type="bird"},{x=500, type="bird"}})
	obstacleOffset = 0
	self.levels[1]:setObstacles({{x=1000, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"},{x=100, y=100, type="badfish"}})
--	self.levels[3]:setObstacles(
--		{{x=500,type="cactus"},{x=800,type="cactus"},{x=1200,type="cactus"},
--		 {x=700, type="bird"},{x=1000, type="bird"}})
--	self.levels[4]:setObstacles({})
--	self.levels[5]:setObstacles({})
end

function game:update(dt)
	self.time = self.time + dt

	for _,animation in pairs(self.animations) do
		animation:update(dt)
	end
	local player = self.player
	player.x = self:getX()
	self.player:update(dt)
	for _,level in ipairs(self.levels) do
		level:update(dt, self.player)
		player.onGround = false
		player.swimming = false
		player.breathing = true

		level:act_on(self.player)
	end
end

function game:draw()
--	love.graphics.scale(2,2)
	love.graphics.translate(-self.player:getX()+100, self.player:getY()-Height/1.5)
--	self.levels[2]:draw()
	self.levels[1]:draw()
--	self.levels[3]:draw()

	self.player:draw()
end

function game:getX()
	return self.time*500
end

function game:keypressed(key)
	self.player:keypressed(key)
end
