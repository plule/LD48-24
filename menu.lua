menu = Gamestate.new()
function menu:init()
	self.music = love.audio.newSource("snd/menu.ogg", "stream")
	self.music:setLooping(true)
	local img = love.graphics.newImage("img/runner.png")
	img:setFilter("nearest", "nearest")
	self.anim = newAnimation(img, 64, 64, 0.07, 0)
end

function menu:enter(previous)
	if(previous == self) then
		love.event.quit()
	end
	love.audio.stop()
	love.audio.play(self.music)
end

function menu:leave()
	love.audio.stop()
end

function menu:update(dt)
	self.anim:update(dt)
end

function menu:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("fill",0,0,Width,Height)
	love.graphics.push()
	love.graphics.scale(6,6)
	self.anim:draw(20, 5)
	love.graphics.pop()
	love.graphics.setColor(0,0,0, 230)
	love.graphics.rectangle("fill",0,0,Width,Height)
	love.graphics.setColor(255,255,255)
	love.graphics.setFont(BigFont)
	title = "Run and Transform"
	love.graphics.print(title, Width/2-BigFont:getWidth(title)/2, 20)
	love.graphics.setFont(Font)
	love.graphics.print("A Ludum Dare game made in 48h by Pierre Lulé", 10, 100)
	love.graphics.print("You are escaping. You can change your form.\nYou can be a runner, a fish or a bird.", 10, 150)
	love.graphics.print("Controls :\nUp/Down arrows\nF1, F2, F3 (or 1,2,3 or C,V,B) to transform.\nEscape to quit\nPress Enter to start",10, 300)
end

function menu:keypressed(key)
	if(key == "return") then
		Gamestate.switch(game)
	end
end
