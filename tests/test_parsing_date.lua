local new_set = MiniTest.new_set
local eq = MiniTest.expect.equality
local vrd_parse_iso = require("virtual-relative-date.parse_iso").parse_iso

local T = new_set()

T["random string"] = function()
    eq(vrd_parse_iso("some noise"), nil)
end

T["YYYY-MM-DD"] = new_set({ parametrize = { { "2025-01-30" }, { "some 2025-01-30 noise" } } })
T["YYYY-MM-DD"]["parses"] = function(input)
    local parsed = vrd_parse_iso(input)
    eq(parsed, { date = { year = 2025, month = 01, day = 30 }, time = nil })
end

T["YYYYMMDDhhmmss"] = new_set({ parametrize = { { "20250130185158" }, { "some 20250130185158 noise" } } })
T["YYYYMMDDhhmmss"]["parses"] = function(input)
    local parsed = vrd_parse_iso(input)
    eq(parsed, { date = { year = 2025, month = 01, day = 30 }, time = { hour = 18, minute = 51, second = 58 } })
end

T["YYYY-MM-DDThh:mm:ss"] = new_set({ parametrize = { { "2025-01-30T18:54:03" }, { "some 2025-01-30T18:54:03 noise" } } })
T["YYYY-MM-DDThh:mm:ss"]["parses"] = function(input)
    local parsed = vrd_parse_iso(input)
    eq(parsed, { date = { year = 2025, month = 01, day = 30 }, time = { hour = 18, minute = 54, second = 03 } })
end

return T
