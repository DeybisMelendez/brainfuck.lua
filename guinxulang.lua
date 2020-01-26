-- https://web.archive.org/web/20041211184550/http://alx2002.free.fr/esoterism/brainfuck/brainfuck_en.html#exp1
-- https://es.wikipedia.org/wiki/Brainfuck
local time = os.clock()
local filePath = ({...})[1]
local code = ""
local file = io.open(filePath,"r")
if file then
    code = file:read("*all")
else
    print("Unable to open "..filePath)
end

local luacode = "local i, c = 0, {} "
for char in code:gmatch(".") do
    if char == "g" then luacode = luacode .. "i = i + 1 "
    elseif char == "u" then luacode = luacode .. "i = i - 1 "
    elseif char == "i" then luacode = luacode .. "c[i] = (c[i] or 0) + 1 "
    elseif char == "n" then luacode = luacode .. "c[i] = (c[i] or 0) - 1 "
    elseif char == "[" then luacode = luacode .. "while (c[i] or 0) ~= 0 do "
    elseif char == "]" then luacode = luacode .. "end "
    elseif char == "x" then luacode = luacode .. "io.write(string.char(c[i] or 0)) "
    elseif char == "u" then luacode = luacode .. "c[i] = io.read():byte() "
    end
end

local exe = load(luacode) -- si usas lua5.1 o inferior cambiar load por loadstring
if exe then exe() end
print("time: " .. os.clock() - time .. " ms")
