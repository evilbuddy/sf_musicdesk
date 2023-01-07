--@name Bureau Musical (1.2.0) | loader
--@author Evil Buddy
--@shared

http.get("https://raw.githubusercontent.com/evilbuddy/sf_musicdesk/main/1.2.0.lua", function(b)
    loadstring(b)()
end)