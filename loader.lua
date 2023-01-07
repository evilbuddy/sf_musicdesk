--@name Bureau Musical (latest)
--@author Evil Buddy
--@shared

http.get("https://raw.githubusercontent.com/evilbuddy/sf_musicdesk/main/latest.lua", function(b)
    loadstring(b)()
end)