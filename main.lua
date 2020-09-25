--part 2 of a series on building a simple platformer using love 2d.
--code hosted at: https://github.com/lackluster-games/simple-platformer-ex-5
--licensed inde the GPL
--  Copyright (C) <2020>  <return5>
--
--   This program is free software: you can redistribute it and/or modify
--   it under the terms of the GNU General Public License as published by
--   the Free Software Foundation, either version 3 of the License, or
--   (at your option) any later version.
--
--   This program is distributed in the hope that it will be useful,
--   but WITHOUT ANY WARRANTY; without even the implied warranty of
--   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--   GNU General Public License for more details.
--
--   You should have received a copy of the GNU General Public License
--   along with this program.  If not, see <https://www.gnu.org/licenses/>.

--tell lua about 'Characters.lua'
require "Characters"
require "Tiles"

--function to draw each enemy to screen
local function drawEnemies()
    --for every enemy in enemy_list
    for _,enemy in ipairs(ENEMY_LIST) do
        enemy:draw()  --call draw function on enemy object
    end
end

--move each enemy on screen
local function moveEnemies()
    --for each enemy in enemy_list
    for _,enemy in ipairs(ENEMY_LIST) do
        enemy:move()  --cal move function on enemy object
    end
end

--fill enemy_list with enemy objects
local function makeEnemies()
    local enemy_icon = love.graphics.newImage("/images/enemy.png")
    --loop through three times
    for i=1,3,1 do
        ENEMY_LIST[i] = ENEMY:new(i*100,HEIGHT,1,enemy_icon)  --make new enemy object for each 'i' index in enemy_list
    end
end

--for each enemy, check to see if they collide with player
local function checkForCollision()
    for i,enemy in ipairs(ENEMY_LIST) do
        --if player and enemy collide, remove enemy from game. 
       if enemy:collision() then     
           table.remove(ENEMY_LIST,i)
       end
   end
end

--handle keyboard input
local function keyboardInput()
    --if player holds down a key 'wasd' then move the player
    if love.keyboard.isDown("w") then
        player:moveUp()
    elseif love.keyboard.isDown("s") then
        player:moveDown()
    elseif love.keyboard.isDown("a") then
        player:moveLeft()
    elseif love.keyboard.isDown("d") then
        player:moveRight()
    end

end

--load this stuff when program starts
function love.load()
    HEIGHT = 272  --height of map
    WIDTH  = 510  --right hand boundary
    --make a player object
    player = PLAYER:new(30,HEIGHT,10,love.graphics.newImage("/images/player.png"))   
    ENEMY_LIST = {}  --holds list of enemies
    makeEnemies()  --fill enemy_list with enemy objects 
    Icon_List:populate()
end

--draw stuff each frame
function love.draw()
    player:draw()  --draw player to screen
    drawEnemies()  --draw the enemies to screen
    drawTileMap()
end

--updates every frame
function love.update()
    moveEnemies()   --move each enemy each frame
    keyboardInput() --get keyboard input
    checkForCollision()
end

