--distance
local pac_man = {}
function pac_man.load()


Map={{'#','#','#','#','#','#','#','#','#','#','#','#','#','#','#'},
     {'#','0','0','0','0','0','#','#','#','0','0','0','0','0','#'},
     {'#','0','#','#','#','0','0','0','0','0','#','#','0','0','#'},
     {'#','0','#','0','#','0','#','0','#','0','0','#','#','0','#'},
     {'#','0','0','0','0','0','0','0','#','0','0','0','0','0','#'},
     {'#','0','#','0','#','0','#','0','#','0','#','0','#','0','#'},
     {'#','0','0','0','#','0','#','0','#','0','#','0','#','0','#'},
     {'#','#','#','#','#','0','#','0','#','0','#','0','#','0','#'},
     {'#','0','0','0','#','0','#','0','#','0','#','0','#','0','#'},
     {'#','0','#','0','#','0','0','0','#','0','#','0','#','0','#'},
     {'#','0','0','0','0','0','#','0','#','0','0','0','0','0','#'},
     {'#','0','#','0','#','0','0','0','#','0','0','#','#','0','#'},
     {'#','0','#','#','#','0','0','0','0','0','#','#','0','0','#'},
     {'#','0','0','0','0','0','#','#','#','0','0','0','0','0','#'},
     {'#','#','#','#','#','#','#','#','#','#','#','#','#','#','#'},
     }

     coins=110
     temp={x=0,y=0,temp=0}
     spawn={x=350,y=350}

	love.window.setMode(50*15,50*15)
	ghosts={
		red={x=350,y=350,mode="static",speed={x=0,y=-5},color={1,0,0},dest={static={x=2,y=2},chace={x=0,y=0}}},--palyer position

		blue={x=350,y=350,mode="static",speed={x=0,y=-5},color={0.135,1.06,1.35},dest={static={x=14,y=2},chace={x=2,y=2}}}, --+2 player  --- -180 from red

		pink={x=350,y=350,mode="static",speed={x=0,y=-5},color={1,0.09,0.9},dest={static={x=2,y=14},chace={x=4,y=4}}},--player position +1

		yello={x=350,y=350,mode="static",speed={x=0,y=-5},color={0,1,0},dest={static={x=14,y=14},chace={x=1,y=1}}}, -- +1 player position if yello is 8 time away from player else scater mode
	}

	dest={x=2,y=2}

	player={x=7*50,y=13*50,speed={x=0,y=0},score=0};

	distance={}
end


function reset()
	player.x=7*50;player.y=13*50;
	for p,ghost in pairs(ghosts) do
		ghost.mode="static";
		ghost.x=spawn.x;ghost.y=spawn.y;
	end
end

function path(x,y,ghost)
	local speed = {}
	speed.x=ghosts[ghost].speed.x
	speed.y=ghosts[ghost].speed.y
	--print(speed.x.. " "..speed.y)
	if(Map[x+speed.y/5][y+speed.x/5]=="#") then--left/rightt; y=- X=-
		distance[1]=999
	else
		distance[1]=((x+speed.y/5)-dest.x)^2 + ((y+speed.x/5)-dest.y)^2
	end

	if(Map[x-speed.y/5][y-speed.x/5]=="#") then --left/rightt; Y=
		distance[2]=999
	else
		distance[2]=((x-speed.y/5)-dest.x)^2 + ((y-speed.x/5)-dest.y)^2

	end

	if(Map[x+speed.x/5][y+speed.y/5]=="#") then --stright
		distance[3]=999
	else
		distance[3]=((x+speed.x/5)-dest.x)^2 + ((y+speed.y/5)-dest.y)^2
	end
	-- body
		temp.temp=speed.x
		--print(distance[1].." "..distance[2].." ".. distance[3])
	if (distance[1]<distance[2] and distance[1]<distance[3]) then
		speed.x=speed.y
		speed.y=temp.temp

	elseif (distance[2]<distance[1] and distance[2]<distance[3]) then
		speed.x=(-speed.y)
		speed.y=(-temp.temp) 

	elseif (distance[2]==distance[1] and distance[1]==distance[3]) then
		speed.x=(-speed.x)
		speed.y=(-speed.y)
	else

		speed.x=speed.x
		speed.y=speed.y
	end
	--print(speed.x.. " "..speed.y)
	return speed.x, speed.y

end

function pac_man.update(dt)

if(player.y%50==0 and player.x%50==0) then
	--coin
	if(Map[player.x/50+1][player.y/50+1]=="0") then
		Map[player.x/50+1][(player.y/50)+1]="."
		player.score=player.score+1
		if(player.score==coins) then
			love.load()
		end
	end

	if(temp.x>0) then
		if(Map[math.modf((player.x)/50)+2][math.modf(player.y/50)+1]~="#")then
			player.speed.x=temp.x
			player.speed.y=temp.y
		else
			player.speed.x=0

			--err
		--	player.speed.y=0
			
		end
	end

	if(temp.x<0) then
		if(Map[math.modf((player.x)/50)][math.modf(player.y/50)+1]~="#")then
			player.speed.x=temp.x
			player.speed.y=temp.y
		else
			player.speed.x=0
			--player.speed.y=0
			
		end
	end


	if(temp.y<0) then
		if(Map[math.modf((player.x)/50)+1][math.modf(player.y/50)]~="#") then

			player.speed.x=temp.x
			player.speed.y=temp.y
		else

			player.speed.y=0
			--player.speed.x=0
		end
	end

	if(temp.y>0) then
		if(Map[math.modf((player.x)/50)+1][math.modf(player.y/50)+2]~="#") then

			player.speed.x=temp.x
			player.speed.y=temp.y
		else

			player.speed.y=0
			--player.speed.x=0
		end
	end

	if(Map[(player.x/50)+1+player.speed.x/5][(player.y/50)+1+player.speed.y/5]=="#") then
		player.speed.x=0
		player.speed.y=0
	end
end

	player.x=player.x+player.speed.x

	player.y=player.y+player.speed.y
	--dest.x=player.x/50+1

	--dest.y=player.y/50+1
	--print(player.x .." ".. player.y )
	
	-- body


---ai
	--d=(ghosts.red.position.x+-player.x)^2 +(ghosts.red.position.y-player.y)^2

	for ghost,property in pairs(ghosts) do
		if (property.x%50==0 and property.y%50==0)then

			if(property.x/50+1==property.dest.static.x and property.y/50+1==property.dest.static.y) then
				property.mode="chace"

			end

			if(property.x==spawn.x and property.y==spawn.y) then
				property.mode="static"
				--print("spawn reached")

			end

			if(property.mode=="static") then
				dest.x=property.dest.static.x
				dest.y=property.dest.static.y
			end

			if(property.mode=="chace") then
				dest.x=player.x/50+1+(player.speed.x)/5*(property.dest.chace.x)
				dest.y=player.y/50+1+(player.speed.y)/5*(property.dest.chace.y)

				if(ghost=="blue") then
					temp.temp=dest.x
					dest.x = (-1) * ((ghosts.red.x/50+1) - dest.x) - 0 * ((ghosts.red.y/50+1)-dest.y) + dest.x
					dest.y = 0 * ((ghosts.red.x/50+1) - temp.temp) + (-1) * ((ghosts.red.y/50+1) - dest.y) + dest.y;
				end

			end



--			if(ghost=="yellow") then

--			end

			property.speed.x,property.speed.y=path((property.x/50)+1,(property.y/50)+1,ghost)
		end

		property.x=property.x+property.speed.x
		property.y=property.y+property.speed.y	
		--print(player.x/50+1 .." " .. ghosts.blue.x/50+1)

	
		--collison
		ray=((property.x+25)-(player.x+25))^2 +((property.y+25)-(player.y+25))^2
		if(ray<250) then
			--print(ray)
			reset()

		end
	end


end



function pac_man.draw()
	for i=1,15 do
		for j=1,15 do
			if(Map[i][j]=="#") then
				love.graphics.setColor(0.192,0.192,0.192)
				love.graphics.rectangle("fill",(i-1)*50,(j-1)*50,50,50)
			end

			if(Map[i][j]=="0")then
				love.graphics.setColor(236,254,0)
				love.graphics.rectangle("fill",(i-1)*50+20,(j-1)*50+20,5,5,5,5)
			end
		end
	end
	love.graphics.setColor(236,254,0)
	--love.graphics.print(ghosts.red.x.." "..ghosts.red.y)
	love.graphics.print("coins:"..player.score)

	love.graphics.rectangle("fill",player.x,player.y,50,50,50,50)

	for ghost,property in pairs(ghosts) do 
		love.graphics.setColor(property.color)
		--print(ghost)
		love.graphics.rectangle("fill",property.x,property.y,50,50,20,20)

	end



end


function pac_man.keypressed(key)
	if(key=="w")then
		temp.x=0
		temp.y=-5

	end

	if(key=="a")then
		temp.x=-5
		temp.y=0
	end

	if(key=="s")then
		temp.x=0
		temp.y=5

	end

	if(key=="d")then
		temp.x=5
		temp.y=0

	end

	if(key=="escape") then
		love.load()
	end

end

return pac_man