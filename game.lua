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
		Level("run", 0, 1000)
	}
	self.levels[1]:setObstacles({{x=100,type="cactus"},{x=200,type="cactus"}})
	self.currLevel = self.levels[1]
end

function game:update(dt)
	self.time = self.time + dt
	self.player.y = self.currLevel:getY(self.player.x)
end

function game:draw()
	self.currLevel:draw()
	self.player:draw()
end
