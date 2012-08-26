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
		run1=Level("run1", "run", 0, 9000, 100),
		swim1=Level("swim1", "swim", 8000, 21000, 70),
		run2=Level("run2", "run", 20000, 23000, 100),
		run3=Level("run3", "run", 35000, 45000, 100),
		swim2=Level("swim2", "swim", 44000, 50000, 70),
		run4=Level("run4", "run", 48000, 55000, 70),

		ceiling=Level("ceiling", "ceiling", 0, 22000, 260),
		ceiling2=Level("ceiling2", "ceiling", 36000, 47000, 260),
		air = Level("air", "air", 0, 50000, 0)
	}
	local levels = self.levels
	obstacleOffset = 0
	self.levels.run1:setObstacles(
		{{x=1000,type="cactus"},{x=1000,type="cactus"}, {x=300, type="cactus"}, {x=2500, type="cactus"},{x=600,type="cactus"},{x=800,type="cactus"},{x=800,type="cactus"},{x=400,type="cactus"}})

	obstacleOffset = 0
	self.levels.ceiling:setObstacles({{x=3300, type="stalactite"},{x=1000, type="stalactite"},{x=800, type="stalactite"}, {x=800, type="stalactite"}, {x=800, type="stalactite"}})

	obstacleOffset = self.levels.swim1.x1
	self.levels.swim1:setObstacles({{type="stupidfish",x=3000,y=0},{type="stupidfish",x=800,y=50},{type="stupidfish",x=800,y=0},{type="stupidfish",x=500,y=-100},{type="stupidfish",x=500,y=0},{type="stupidfish",x=500,y=0},{type="stupidfish",x=0,y=-100},{type="stupidfish",x=800,y=50},{type="stupidfish",x=0,y=-100},{type="stupidfish",x=200,y=0},{type="stupidfish",x=0,y=-150},{type="stupidfish",x=200,y=50},{type="stupidfish",x=0,y=-100}, {type="badfish",x=600,y=0}, {type="badfish", x=400,y=0}, {type="badfish", x=700,y=0}, {type="badfish", x=0, y=-300},{type="badfish", x=700,y=0}, {type="badfish", x=0, y=-300},{type="badfish", x=700,y=65}, {type="badfish", x=0, y=-300}})

	obstacleOffset = self.levels.run2.x1
	self.levels.ceiling:setObstacles({{x=1000, type="stalactite"},
									  {x=4000, y=400, type="stupidbird"},
									  {x=100, y=200, type="stupidbird"},
									  {x=100, y=100, type="stupidbird"},
									  {x=100, y=50, type="stupidbird"},
									  {x=100, y=0, type="stupidbird"},
									  {x=500, y=200, type="stupidbird"},
									  {x=100, y=100, type="stupidbird"},
									  {x=100, y=50, type="stupidbird"},
									  {x=500, y=70, type="stupidbird"},
									  {x=100, y=100, type="stupidbird"},
									  {x=100, y=150, type="stupidbird"},
									  {x=500, y=110, type="stupidbird"},
									  {x=100, y=100, type="stupidbird"},
									  {x=100, y=120, type="stupidbird"},
									  {x=700, y=120, type="bird"},
									  {x=700, y=120, type="bird"},
									  {x=100, y=120, type="stupidbird"},
									  {x=700, y=120, type="bird"},
									  {x=50, y=0, type="bird"},
									  {x=0, y=120, type="stupidbird"},
									  {x=5, y=140, type="stupidbird"},
									  {x=5, y=130, type="stupidbird"},
									  {x=50, y=200, type="bird"},
									  {x=800, y=100, type="stupidbird"},
									  {x=50, y=200, type="stupidbird"},
									  {x=50, y=0, type="stupidbird"},
									  {x=50, y=50, type="stupidbird"},
									  {x=50, y=70, type="bird"},
									  {x=50, y=170, type="stupidbird"},
									  {x=50, y=-170, type="stupidbird"},
									  {x=50, y=-100, type="stupidbird"},
									 })

	obstacleOffset = self.levels.run3.x1
	levels.run3:setObstacles({{x=1000, type="cactus"}, {x=400, type="cactus"}})
	levels.ceiling2:setObstacles({{x=400, type="stalactite"}})
	levels.run3:setObstacles({{x=400, type="cactus"}, {x=400, type="cactus"}})
	levels.ceiling2:setObstacles({{x=400, type="stalactite"}})
	levels.run3:setObstacles({{x=400, type="cactus"}, {x=400, type="cactus"}})
	levels.run3:setObstacles({{x=250, type="cactus"}, {x=250, type="cactus"}})
	levels.run3:setObstacles({{x=250, type="cactus"}, {x=250, type="cactus"}})
	levels.ceiling2:setObstacles({{x=250, type="stalactite"}})
	levels.run3:setObstacles({{x=250, type="cactus"}, {x=250, type="cactus"}, {x=500, y=120, type="stupidbird"},{x=300, y=150, type="stupidbird"},{x=120,type="cactus"}})
	levels.ceiling2:setObstacles({{x=300,type="stalactite"}})
	levels.run3:setObstacles({{x=300,type="cactus"}})
	levels.ceiling2:setObstacles({{x=300,type="stalactite"}})
	levels.run3:setObstacles({{x=300,type="cactus"}})
	levels.ceiling2:setObstacles({{x=300,type="stalactite"}})
	levels.run3:setObstacles({{x=300,type="cactus"}})
	obstacleOffset = levels.swim2.x1
	levels.swim2:setObstacles({{x=1800, y=-100, type="stupidfish"},{x=50, y=0, type="stupidfish"},{x=100, y=-100, type="badfish"},{x=50, y=0, type="badfish"}})
	levels.swim2:setObstacles({{x=500, y=-100, type="stupidfish"},{x=50, y=0, type="stupidfish"},{x=100, y=-100, type="badfish"},{x=50, y=0, type="badfish"}})
	levels.swim2:setObstacles({{x=500, y=-100, type="stupidfish"},{x=50, y=0, type="stupidfish"},{x=50, y=50, type="stupidfish"},{x=100, y=-100, type="badfish"},{x=50, y=0, type="badfish"}})
	levels.run4:setObstacles({{x=1800, y=120, type="stupidbird"},{x=0, y=150, type="stupidbird"},{ x=200, y=150, type="bird"}})
--	self.levels.air:setObstacles({{x=3300, y=500, type="bird"}, {x=4500, y=500, type="stupidbird"}})
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
