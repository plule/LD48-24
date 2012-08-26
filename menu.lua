menu = Gamestate.new()
function menu:init()
	self.music = love.audio.newSource("snd/menu.ogg", "stream")
	self.music:setLooping(true)
end

function menu:enter()
	love.audio.play(self.music)
end

function menu:leave()
	love.audio.stop()
end

function menu:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.print("Controls :\nUp/Down arrows\nF1, F2, F3 to transform.\nPress Enter to start",100, 100)
end

function menu:keypressed(key)
	if(key == "return") then
		Gamestate.switch(game)
	end
end
