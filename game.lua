require "player"
require "level"

game = Gamestate.new()
function game:init()
end

function game:enter()
	self.time = 0
	self.player = Player("player", 100, 500)
	self.levels = {
		Level("run1", "run", 0, 2000, 100),
		Level("swim", "swim", 2000, 5000, 70),
		Level("run2", "run", 5000, 6000, 100)
	}
	self.levels[1]:setObstacles(
		{{x=500,type="cactus"},{x=800,type="cactus"},{x=1200,type="cactus"},
		 {x=700, type="bird"},{x=1000, type="bird"}})
	self.levels[2]:setObstacles({{x=500, y=200, type="jellyfish"},{x=1000,y=100, type="jellyfish"}})
	self.levels[3]:setObstacles(
		{{x=500,type="cactus"},{x=800,type="cactus"},{x=1200,type="cactus"},
		 {x=700, type="bird"},{x=1000, type="bird"}})
	self.currLevel = self.levels[1]
end

function game:update(dt)
	self.time = self.time + dt
	self.player.x = self:getX()

	for _,level in ipairs(self.levels) do
		local x = self.player:getX()
		if(x > level.x1 and x < level.x2) then
			self.currLevel = level
		end
	end

	self.currLevel:update(dt, self.player)
end

function game:draw()
	love.graphics.translate(-self.player:getX()+50, self.player:getY()-Height/2)
	self.levels[2]:draw()
	self.levels[1]:draw()
	self.levels[3]:draw()

	self.player:draw()
end

function game:getX()
	return self.time*400
end

function game:keypressed(key)
	self.currLevel:keypressed(key, self.player)
end
