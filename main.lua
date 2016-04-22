--Have fun :)

--This file is the main file of this project.
--It allows to initalizing, updating and drawing the game. 

local initGame = require 'init.initGame'
function love.load(arg)
	initGame:create()
	local menu = require 'menus.menu'
	local options = require 'menus.options'
	local highscores = require 'menus.highscores'
	local play = require 'play.play'
	require 'init.playSound'
	--There are different states:
	--[1]:main menu, [2]:players menu, [3]:1player, [4]:2player,
	--[5]:3player, [6]:highscores, [7]:options
	States = {menu, menu, play, play, play, highscores, options}
	CurrentState = States[1]
	playSound("sounds/intro.mp3")
end

function love.keypressed(k, unicode)
	konamicode.keypressed(k)
    CurrentState:keypressed(k)
end

function love.update(dt)
	CurrentState:update(dt)
	CurrentState = States[State]
end

function love.focus(b)
	if not b then
		Paused = true;
		love.audio.pause()
	else
		Paused = false;
		love.audio.resume()
	end
end

function love.draw(dt)	
	CurrentState:draw(dt)
end 

function love.quit()
	love.event.quit()
	--Reset highscores:
	--love.filesystem.write("scores.lua", "0\n0\n0")
end