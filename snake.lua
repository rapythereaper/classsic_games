local snake={}

function snake.load()
	screen={weidth=500,height=500}
	love.window.setMode(screen.height,screen.weidth)

	player={x=500/2,y=500/2};
	temp={x=-22,y=0}
	body={{x=0,y=0},{x=0,y=0}}

	--body2={x=body.x-22,y=body.y}
	food={x=25*love.math.random(2,19),y=25*love.math.random(2,19)}	
	speed={x=25,y=0,speed=25}
	a=0;b=0;
	timer=0
	score=0

end

function snake.update(dt)
	timer=timer+dt

	if(timer>7.5) then
		for i=1,#body,1 do

			if(player.x==body[i].x and player.y==body[i].y) then
				print("score:"..score);
				love.load()

			elseif(i==1) then
				a=body[i].x
				b=body[i].y
				body[i].x=player.x
				body[i].y=player.y
			else
				temp.x=a
				temp.y=b
				a=body[i].x
				b=body[i].y
				body[i].x=temp.x
				body[i].y=temp.y


				
			end

		end

		if(food.x==player.x and food.y==player.y) then
			body[#body+1]={x=0,y=0}
			score=score+1
			food.x=25*love.math.random(2,19)
			food.y=25*love.math.random(2,19)
		end

		if(player.x>screen.height or player.x<0 )then
			if(player.x>500)then
				player.x=player.x-player.x
			else
				player.x=player.x+500
			end

		elseif(player.y>500 or player.y<0 )then
			if(player.y>500)then
				player.y=player.y-player.y
			else
				player.y=player.y+500
			end

		else
			player.x=player.x+speed.x

			player.y=player.y+speed.y
		end
		--print("player: ",food.x,food.y)

		timer=0



	end

	timer=timer+1
	--body2.x=body.x-temp.x
	--body2.y=body.y-temp.y

	--body.x=player.x-temp.x

	--body.y=player.y-temp.y
	--body.y=

	--body.y=player.y



end

function snake.draw()
	love.graphics.print(score)

	love.graphics.setColor(1,.3,.3)--red

	love.graphics.rectangle("fill",food.x,food.y,20,20)

	love.graphics.setColor(.6,1,.32)--green
	love.graphics.rectangle("fill",player.x,player.y,20,20)
	--love.graphics.setColor(255,255,.2)
	for i=1,#body,1 do
		love.graphics.rectangle("fill",body[i].x,body[i].y,20,20)
	end
	


end


function snake.keypressed(key)
	if(key=="w" and speed.y~=speed.speed) then
		--body.y=body.y-speed.speed


		speed.y=(-speed.speed)
		speed.x=0

	end

	if(key=="a" and speed.x~=speed.speed) then
		speed.x=(-speed.speed)
		speed.y=0

	end

	if(key=="s" and speed.y~=(-speed.speed)) then
		speed.y=speed.speed
		speed.x=0

	end

	if(key=="d"and speed.x~=(-speed.speed)) then
		speed.x=speed.speed
		speed.y=0


	end

	if(key=="escape") then
		love.load()
	end
	-- body
end

return snake