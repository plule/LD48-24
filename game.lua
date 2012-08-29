require "player"
require "level"
require "AnAL"

game = Gamestate.new()
function game:init()
	self.sprites = {
		jellyfish = love.graphics.newImage("img/jellyfish.png"),
		cactus = love.graphics.newImage("img/stalagmite.png"),
		runner = love.graphics.newImage("img/runner.png"),
		crouch = love.graphics.newImage("img/crouch.png"),
		jumpup = love.graphics.newImage("img/jump.png"),
		jumpdown = love.graphics.newImage("img/jumpdown.png"),
		stalactite = love.graphics.newImage("img/stalactite.png"),
		fish = love.graphics.newImage("img/fish.png"),
		bird = love.graphics.newImage("img/bird.png"),
		bubble = love.graphics.newImage("img/bubble.png"),
		airbubble = love.graphics.newImage("img/air-bubble.png"),
		sirenup = love.graphics.newImage("img/sirenup.png"),
		sirendown = love.graphics.newImage("img/sirendown.png"),
		birdup = love.graphics.newImage("img/birdup.png"),
		birddown = love.graphics.newImage("img/birddown.png"),
		instructions = love.graphics.newImage("img/instructions.png"),
		fleches = love.graphics.newImage("img/fleches.png"),
		magic = love.graphics.newImage("img/magic.png")
	}
	for _,pic in pairs(self.sprites) do
		pic:setFilter("nearest", "nearest")
	end
	self.animations = {
		jellyfish = newAnimation(self.sprites.jellyfish, 16, 32, 0.3, 0),
		runner = newAnimation(self.sprites.runner, 64, 64, 0.07, 0),
		crouch = newAnimation(self.sprites.crouch, 64, 64, 0.1, 0),
		jumpup = newAnimation(self.sprites.jumpup, 64, 64, 0.07, 0),
		jumpdown = newAnimation(self.sprites.jumpdown, 64, 75, 0.07,0),
		fish = newAnimation(self.sprites.fish, 16, 16, 0.5, 0),
		bird = newAnimation(self.sprites.bird, 32, 16, 0.1, 0),
		sirenup = newAnimation(self.sprites.sirenup,64, 64, 0.07, 0),
		sirendown = newAnimation(self.sprites.sirendown, 64, 64, 0.07, 0),
		birdup = newAnimation(self.sprites.birdup, 64, 75, 0.07, 0),
		birddown = newAnimation(self.sprites.birddown, 64, 75, 0.07, 0),
		magic = newAnimation(self.sprites.magic, 64, 64, 0.07, 0)
	}
	self.animations.jellyfish:setMode("bounce")
	self.animations.magic:setMode("bounce")
--	self.animations.crouch:setMode("once")
	self.transformsound = love.audio.newSource("snd/chouing2.ogg", "static")
	self.transformsound:setVolume(0.3)
end

function game:enter(previous, level)
	self.wincolor = {255,255,255,0}
	self.music = Music
	self.player = Player("player", 0, 100)
	self.music:rewind()
	self.player.form = "runner"
	self.startlevel = level
	self.time = 0
	self.winfader = nil
	self.wintext = nil
	self.wincolor = {255,255,255,0}
	if(level ~= nil) then
		self.x = level.x1
		self.time = self:getTime(self.x)
		self.player.form = Level.DefaultForms[level.type]
		self.music:seek(self.time, "seconds")
	end

	love.audio.play(self.music)
	self.levels = {
		run1=Level(1,"run1", "run", 0, 9000, 100),
		swim1=Level(2,"swim1", "swim", 8000, 21000, 70),
		run2=Level(3,"run2", "run", 20000, 23000, 100),
		fly=Level(4,"fly1", "fly", 23000, 35000, 100),
		run3=Level(5,"run3", "run", 35000, 45000, 100),
		swim2=Level(6,"swim2", "swim", 44000, 50000, 70),
		run4=Level(7,"run4", "run", 48000, 55000, 70),

		ceiling=Level(8,"ceiling", "ceiling", 0, 22000, 260),
		ceiling2=Level(9,"ceiling2", "ceiling", 36000, 47000, 260),
		air = Level(10,"air", "air", 0, 50000, 0)
	}
	local levels = self.levels
	obstacleOffset = 0
	self.levels.run1:setObstacles(
		{{x=1000,type="cactus"},{x=1000,type="cactus"}, {x=300, type="cactus"}, {x=2500, type="cactus"},{x=600,type="cactus"},{x=800,type="cactus"},{x=800,type="cactus"},{x=400,type="cactus"}})

	obstacleOffset = 0
	self.levels.ceiling:setObstacles({{x=3300, type="stalactite"},{x=1000, type="stalactite"},{x=800, type="stalactite"}, {x=800, type="stalactite"}, {x=800, type="stalactite"}})

	obstacleOffset = self.levels.swim1.x1
	self.levels.swim1:setObstacles({{type="jellyfish",x=3000,y=0},{type="stupidfish",x=800,y=50},{type="stupidfish",x=800,y=0},{type="jellyfish",x=500,y=-100},{type="stupidfish",x=500,y=0},{type="stupidfish",x=500,y=0},{type="stupidfish",x=0,y=-100},{type="stupidfish",x=800,y=50},{type="stupidfish",x=0,y=-100},{type="stupidfish",x=200,y=0},{type="jellyfish",x=0,y=-150},{type="stupidfish",x=200,y=50},{type="stupidfish",x=0,y=-100}, {type="badfish",x=600,y=0}, {type="badfish", x=400,y=0}, {type="badfish", x=700,y=0}, {type="badfish", x=0, y=-300},{type="badfish", x=700,y=0}, {type="badfish", x=0, y=-300},{type="badfish", x=700,y=65}, {type="badfish", x=0, y=-300}})

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
									  {x=200, y=200, type="stupidbird"},
									  {x=50, y=0, type="stupidbird"},
									  {x=50, y=50, type="stupidbird"},
									  {x=50, y=70, type="bird"},
									  {x=50, y=170, type="stupidbird"},
									  {x=50, y=-170, type="stupidbird"},
									  {x=50, y=-100, type="stupidbird"},
									  {x=100, y=100, type="stupidbird"},
									  {x=100, y=120, type="stupidbird"},
									  {x=700, y=120, type="bird"},
									  {x=700, y=120, type="bird"},
									  {x=100, y=120, type="stupidbird"},
									  {x=700, y=120, type="bird"},
									  {x=50, y=0, type="bird"}
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
	levels.swim2:setObstacles({{x=1800, y=-100, type="jellyfish"},{x=50, y=0, type="jellyfish"},{x=100, y=-100, type="badfish"},{x=50, y=0, type="badfish"}})
	levels.swim2:setObstacles({{x=500, y=-100, type="stupidfish"},{x=50, y=0, type="stupidfish"},{x=100, y=-100, type="badfish"},{x=50, y=0, type="badfish"}})
	levels.swim2:setObstacles({{x=500, y=-100, type="stupidfish"},{x=50, y=0, type="jellyfish"},{x=50, y=50, type="stupidfish"},{x=100, y=-100, type="badfish"},{x=50, y=0, type="badfish"}})
	levels.run4:setObstacles({{x=1800, y=120, type="stupidbird"},{x=0, y=150, type="stupidbird"},{ x=200, y=150, type="bird"}})
end

function game:update(dt)
	if(self:getX() > 50000 and self.winfader == nil) then
		self:win()
	end
	self.time = self.time + dt
	if(self.winfader ~= nil) then
		self.winfader(dt)
	end
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

function game:win()
	self.winfader = Timer.Interpolator(5, function(frac)
								   self.wincolor = {255,255,255,frac*255}
								  end)
	Timer.add(5, function() self.wintext = "Congratulations,\nand thanks for playing!\n" end)
	Timer.add(5, function()
				  self.music:stop()
				  menu.music:play()
				  end)
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
	love.graphics.setColor(255,255,255)
	if(self.player.breathe <= 0.9) then
		nbBubbles = math.floor(self.player.breathe*10)
		for i=1,nbBubbles do
			love.graphics.draw(game.sprites.bubble, 20, Height/2 + i * 10)
		end
	end
	if(self.player.airtime <= 0.9) then
		nbBubbles = math.floor(self.player.airtime*10)
		for i=1,nbBubbles do
			love.graphics.draw(game.sprites.airbubble, 30, Height/2 + i * 10)
		end
	end
	love.graphics.draw(self.sprites.instructions, Width/2-128, Height-70)
	love.graphics.draw(self.sprites.fleches, Width-70, Height/2-70)
	love.graphics.setColor(self.wincolor)
	love.graphics.rectangle("fill",0,0,Width,Height)
	if(self.wintext ~= nil) then
		love.graphics.setFont(Font)
		love.graphics.setColor(200,200,200)
		love.graphics.print(self.wintext, Width/2-Font:getWidth(self.wintext)/2, 100)
	end
end

function game:getX()
	return self.time*500
end

function game:getTime(x)
	return x/500
end

function game:keypressed(key)
	self.player:keypressed(key)
end
