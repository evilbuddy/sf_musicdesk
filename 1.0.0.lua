--@name Bureau Musical (1.0.0)
--@author Evil Buddy
--@shared

-- Change this to put your own songs :3
local musics = {
    {
        name = "Allah, Syria & Bashar",
        color = Color(128, 128, 128),
        url = "https://cdn.discordapp.com/attachments/792155548643491860/875333987898359819/Allah_Syria_and_Bashar.mp3"
    },
    {
        name = "Issou Night Club",
        color = Color(0, 255, 0),
        url = "https://cdn.discordapp.com/attachments/792155548643491860/1061063848964149299/OFFICIAL_VIDEO_Risitas_-_Issou_Night_Club.mp3"
    }
}

if CLIENT then
    local music = nil

    net.receive("PlayMusic", function()
        bass.loadURL(net.readString(), "noplay", function(s)
            if isValid(s) then
                if isValid(music) then
                    music:stop()
                end
            
                s:play()
                music = s
            end
        end)
    end)
    
    local function addButton(text, url, color, ID)
        local ScrW, ScrH = render.getResolution()
        local posY = 5 + ID * 5 + ID * 20
        
        render.setColor(color)
        render.drawRect(5, posY, ScrW - 10, 20)
        
        render.setColor(Color(0, 0, 0))
        render.drawText(ScrW / 2, posY + 1, text, 1)
    end
    
    hook.add("render", "screen", function()
        local ScrW, ScrH = render.getResolution()
        local curX, curY = render.cursorPos()
        buttons = 0
        
        for i, v in pairs(musics) do
            addButton(v.name, v.url, v.color, i - 1)
        end
            
        if curX and curY then
            lastclk = clk
            clk = player():keyDown(3)
            
            if clk and not lastclk then
                for i, v in pairs(musics) do
                    i = i - 1
                    
                    local posY = 5 + i * 5 + i * 20
                
                    if curX > 5 and curX < ScrW - 5 and
                    curY > posY and curY < posY + 20 then
                            net.start("PlayMusic")
                            net.writeString(v.url)
                            net.send()
                    end
                end
            end
        end 
    end)
end

if SERVER then
    wire.adjustOutputs({"Color"}, {"Vector"})
    
    local hue = 0
    
    timer.create("lights", 0.010, 0, function()
        hue = hue + 1
        
        if hue > 360 then
            hue = 0
        end
        
        local col = Color(hue, 1, 0.5):hsvToRGB()
    
        wire.ports["Color"] = Vector(col.r, col.g, col.b)
    end)
    
    net.receive("PlayMusic", function()
        net.start("PlayMusic")
        net.writeString(net.readString())
        net.send()
    end)
end