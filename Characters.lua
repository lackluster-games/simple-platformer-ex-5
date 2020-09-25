CHARACTER = { x = nil, y = nil, speed = nil, icon = nil, ox = nil, oy = nil }    --Character class
CHARACTER.__index = CHARACTER                                    --make sure index points to CHARACTER class
ENEMY             = {move_r = nil}   --enemy class
setmetatable(ENEMY,CHARACTER)        --set enemy metatable to character metatable. this makes enemy a subclass of character
ENEMY.__index     = ENEMY

PLAYER             = {}                --player class
setmetatable(PLAYER,CHARACTER)        --set player metatable to character metatable. this makes player a subclass of character
PLAYER.__index     = PLAYER


--create a new chracter object
function CHARACTER:new(x,y,speed,icon)
    local o = o or {}
    setmetatable(o,self)
    o.x      = x
    o.speed  = speed  --determines how fast a charcter moves around
    o.icon   = icon
    o.ox     = o.icon:getWidth() / 2   --get the middle x of icon
    o.oy     = o.icon:getHeight() / 2  --get the middle y of icon
    o.y      = y - o.oy
    return o
end

--create a new player object
function PLAYER:new(x,y,speed,icon)
    local o = CHARACTER:new(x,y,speed,icon)
    setmetatable(o,self)
    return o
end

--create a new enemy object
function ENEMY:new(x,y,speed,icon)
    local o = CHARACTER:new(x,y,speed,icon)
    setmetatable(o,self)
    o.move_r = true  --if true, then charcter move to the right
    return o
end

--draw the character to screen
function CHARACTER:draw()
    love.graphics.draw(self.icon,self.x,self.y,0,1,1,self.ox,self.oy)
end

--check to see if an enemy collides with player, if so, then return true. 
function ENEMY:collision()
    --check if bottom of player is below top of enemy and top of playe is above bottom of enemy
    if (player.y + player.oy > self.y - self.oy) and (player.y - player.oy < self.y + self.oy) then
        --check if right side of player is to the right of left side of enemy and left side of player is to the left of right side of enemy.
        if (player.x + player.ox > self.x - self.ox) and (player.x - player.ox < self.x + self.ox) then
            --if both conditions are true then return true
            return true
        end
    end
    return false
end

--move the enemy left and right across screen.
function ENEMY:move()
    if self.move_r == true then               --while move right is true
        self.x = self.x + self.speed 
        if self.x + self.ox > WIDTH then       --when enemy reaches the right hand boundary
            self.x      = WIDTH - self.ox
            self.move_r = false
        end
    else
        self.x = self.x - self.speed
        if self.x - self.ox < 0 then          --when enemy reaches the left hand side
            self.x      = self.ox
            self.move_r = true
        end
    end
end

function PLAYER:moveUp()
    self.y = self.y - self.speed 
    if self.y - self.oy < 0 then     --if player ties to go above the upper boundary
        self.y = self.oy
    end
end

function PLAYER:moveDown()
    self.y = self.y + self.speed 
    if self.y + self.oy > HEIGHT then   --if player tries to go below lower boundary
        self.y = HEIGHT - self.oy
    end
end

function PLAYER:moveLeft()
    self.x = self.x - self.speed  
    if self.x - self.ox < 0 then      --if player tries to go pass the left hand boundary
        self.x = self.ox
    end
end

function PLAYER:moveRight()
    self.x = self.x + self.speed  
    if self.x + self.ox > WIDTH then  --if player tries to go pass the right hand boundary
        self.x = WIDTH - self.ox
    end
end

