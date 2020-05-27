local bird={}
function bird.load(  )
	height=500
	weidth=500
	love.window.setMode(height,weidth)

	score=0

	piller_x=weidth
	place={50,200,350}
	piller_y=place[love.math.random(1,3)]

	gravity=0
	speed=200
	
	-- body
end


function bird.update(dt)
	--gravity = gravity + (516 * dt)
    gravity=gravity+(500*dt)
    speed=speed+(gravity*dt)

    piller_x=piller_x-(300*dt)

    --if--collision logic
    if piller_x<30 then
    	if speed>piller_y and speed<piller_y+100-30 then

    		score=(score+1)
    	else
    		print("score"..score)	
    		love.load()
    	end
    end



    if piller_x<-100 then
    	piller_x=weidth
    	piller_y=place[love.math.random(1,3)]
    end





end

function bird.draw()
	love.graphics.print(score/27)
	love.graphics.setColor(0,255,0)--green
	love.graphics.rectangle("fill",piller_x,0,100,height)--piller_xiller
	love.graphics.setColor(0, 0, 0)--black
	love.graphics.rectangle("fill",piller_x,piller_y,100,100)--blank space
	love.graphics.setColor(255,255,0)--yellow
	love.graphics.rectangle("fill",10,speed,30,30)--player
end

function bird.keypressed(key)
	if(key=="space") then
		gravity=-200
	end
	if(key=="escape") then
		love.load()
	end
	
end


return bird;

