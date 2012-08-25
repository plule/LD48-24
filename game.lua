Gamestate = require "hump.gamestate"

require "player"
require "level"

game = Gamestate.new()
function game:init()
end

function game:enter()
	self.time = 0
	self.player = Player(100, 500)
	self.levels = {
		Level("run", 0, 10000)
	}
	self.levels[1]:setObstacles({{x=500,type="cactus"},{x=800,type="cactus"},{x=1200,type="cactus"})
	self.currLevel = self.levels[1]
end

function game:update(dt)
	self.time = self.time + dt
	self.player.y = self.currLevel:getY(self.player.x)
	self.player.x = self:getX()
end

function game:draw()
	love.graphics.translate(-self.player.x+50, 0)

	self.currLevel:draw()
	self.player:draw()
end

function game:getX()
	return self.time*400
end
