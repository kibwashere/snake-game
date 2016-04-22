--This file manages the sound part.
--It is a function that plays the sound informed in parameter.

function playSound(name)
	if SoundOn == true then
		love.audio.stop()
		local sound = love.audio.newSource(name)
		sound:setLooping(true)
		sound:setPitch(1.0)
		sound:setVolume(0.4)
		if name == "sounds/konami.mp3" then
			sound:setVolume(0.2)
		end
		sound:play()
	end
end
