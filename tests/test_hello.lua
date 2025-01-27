local new_set = MiniTest.new_set
local expect, eq = MiniTest.expect, MiniTest.expect.equality

local T = new_set()

T['works'] = function()
    local x = 1 + 1
    MiniTest.expect.equality(x, 2)
end

return T
