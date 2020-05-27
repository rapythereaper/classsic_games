
--poloish ai 
--diff speed
local pong = {}

function  pong.load()
	screen={height=500,weidth=500}
	love.window.setMode(screen.height,screen.weidth)
	player={x=5,y=10,score=0}

	sound=love.audio.newSource("pong.wav","static")

	enemy={x=500-10,y=10,score=0}

	ball={x=400,y=100,speed={x=3,y=0}}
end

function reset()

	player.y=500/2
	enemy.y=500/2
	ball.x=(500/2)+10
	ball.y=(500/2)+10
	ball.speed.x=5
	ball.speed.y=0
	-- body+
end



function pong.update(dt)

	ball.x=ball.x-(ball.speed.x+dt)
	ball.y=ball.y-(ball.speed.y+dt)
	--win
	if(player.score==10 or enemy.score==10) then
		print("you:"..player.score.." enemy:"..enemy.score)
		love.load()
	end



	--ai
	if(ball.x>500/2) then--ball.speed.x<0 ) then
		--if(ball.speed.y>0 and enemy.y>10 ) then
		if(ball.y<enemy.y) then --and enemy.y>ball.y) then
			enemy.y=enemy.y-(5+dt)
			--print("up")
		--elseif(ball.speed.y<0 and (enemy.y)+50<500-10) then
		elseif(ball.y>enemy.y ) then--and (enemy.y+50)<ball.y) then
			enemy.y=enemy.y+(5+dt)
		end

	end
	--enemy.speed=0

	--ball  out of screen 
	if(ball.y<5 or ball.y+10>500) then
		ball.speed.y=(-ball.speed.y)
		sound:play()
	end






	--ball strick
	if(ball.x<player.x+5)then
		if((ball.y>player.y and ball.y<player.y+50) or (ball.y+10>player.y and ball.y+10<player.y+50)  ) then
			ball.speed.x=(-ball.speed.x)
			--tst for angel
			if((ball.y+10)>player.y+25) then
				ball.speed.y=5--(ball.y-player.y)-50--up
			else 
				ball.speed.y=-5--(ball.y-player.y)--(-player.y/50)
			end
			sound:play()
		else
			enemy.score=enemy.score+1
			reset()

		end
	end

	if(ball.x+10>enemy.x)then
		if(ball.y>enemy.y and ball.y<enemy.y+50 or (ball.y+10>enemy.y and ball.y+10<enemy.y+50)) then
			ball.speed.x=(-ball.speed.x)
			sound:play()
		else
			player.score=player.score+1
			reset()
		end
	end

	--ai
	--if(ball.x>500/2) then
	--	enemy.speed=5*(ball.speed.y/ball.speed.y)


	--end


	--key mapping
	if(love.keyboard.isDown("w") and player.y>10 ) then
		player.y=player.y-(5+dt)

		
	end

	if(love.keyboard.isDown("s") and (player.y+50)<500-10) then
		player.y=player.y+(5+dt)

		

	end
	-- body
end



function pong.draw()
	love.graphics.print(player.score,20,10,0,2,2)
	love.graphics.print(enemy.score,500-40,10,0,2,2)
	love.graphics.setColor(.6,1,.32)--green
	love.graphics.rectangle("fill",player.x,player.y,5,50)

	love.graphics.setColor(1,.3,.3)--red
	love.graphics.rectangle("fill",enemy.x,enemy.y,5,50)

	love.graphics.setColor(255,255,255)--white
	love.graphics.rectangle("fill",ball.x,ball.y,10,10)

end

function pong.keypressed(key)
	if(key=="escape") then
		love.load()
	end
end


return pong