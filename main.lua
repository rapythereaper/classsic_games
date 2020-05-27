function love.load(par)

	GameState="menu";Game=nil;choice=1
	if par~="play" then
		love.window.setMode(500,500)
	-- body
		games={{name="snake"},{name="pong"},{name="pac_man"},{name="flappy_bird"}}
	else
		Game.load()
	end
end


function love.update(dt)
	if GameState=="menu" then
	

	else
		Game.update(dt)
	end
end

function love.draw( ... )
	if GameState=="menu" then
		for i,game in ipairs(games) do
			if(choice==i)then
				love.graphics.setColor(1,1,1)
			else
				love.graphics.setColor(0.192,0.192,0.192)
			end
			--love.graphics.setColor(0.192,0.192,0.192)
			love.graphics.rectangle("fill",500/2-80,(i)*50+i*10,90*2,50)
			love.graphics.setColor(0,1,0)
			love.graphics.print(game.name,500/2-30,(i)*50+i*10+10)
		end
	else
		Game.draw()
	end

	-- body
end


function love.keypressed(key)
	if(GameState=="menu") then
		if(key=="w" and choice>1) then
			choice=choice-1

		end

		if(key=="s" and choice<(#games)) then
			choice=choice+1

		end

		if(key=="return")then
			print(games[choice].name)
			Game=require(games[choice].name)
			print()
			GameState="play"
			Game.load()
		end
	else
		Game.keypressed(key)
	end

	-- body
end