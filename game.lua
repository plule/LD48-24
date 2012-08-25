require "player"
require "level"

game = Gamestate.new()
function game:init()
end

function game:enter()
	self.time = 0
	self.player = Player("player", 100, 500)
	self.levels = {
		Level("run1", "swim", 0, 10000)
	}
--	self.levels[1]:setObstacles(
--		{{x=500,type="cactus"},{x=800,type="cactus"},{x=1200,type="cactus"},
--		 {x=700, type="bird"},{x=1000, type="bird"}})
	self.levels[1]:setObstacles({})
	self.currLevel = self.levels[1]
end

function game:update(dt)
	self.time = self.time + dt
	self.player.x = self:getX()
	self.currLevel:update(dt, self.player)
end

function game:draw()
	love.graphics.translate(-self.player.x+50, 0)

	self.currLevel:draw()
	self.player:draw()
end

function game:getX()
	return self.time*400
end

function game:keypressed(key)
	self.currLevel:keypressed(key, self.player)
end
