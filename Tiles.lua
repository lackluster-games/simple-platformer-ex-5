
Tile_Map = {
             {3,3,3,3,3,3,0,0,0,3,3,3,3,3,3},
             {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
             {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
             {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
             {0,0,1,1,1,0,0,0,0,0,0,2,2,2,0},
             {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
             {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
             {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
             {3,3,3,3,3,3,0,0,0,3,3,3,3,3,3}
         }

Tile_Map.__index = Tile_Map
setmetatable(Tile_Map,Tile_Map)

Icon_List         = {}
Icon_List.__index = Icons

Icon         = {icon = nil,width = nil, height = nil}
Icon.__index = Icon

function Icon:draw(i,j)
    love.graphics.draw(self.icon,j * self.width - 32,i * self.height - 32)
end

function drawTileMap()
    for i,tiles in ipairs(Tile_Map) do
        for j,tile in ipairs(tiles) do
            if tile ~= 0 then
                Icon_List[tile]:draw(i,j)
            end
        end
    end
end
    

function Icon:new(icon_path)
    local o  = setmetatable({},self)
    o.icon   = love.graphics.newImage(icon_path)
    o.width  = o.icon:getWidth()
    o.height = o.icon:getHeight()
    return o
end

function Icon_List:populate()
    table.insert(self,Icon:new("/images/tile1.png")) 
    table.insert(self,Icon:new("/images/tile2.png"))
    table.insert(self,Icon:new("/images/tile3.png"))
end

