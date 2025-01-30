local M = {}

--- @class Date
--- @field year number
--- @field month number
--- @field day number

--- @class Time
--- @field hour number
--- @field minute number
--- @field second number

--- @class DateTime
--- @field date Date
--- @field time Time?

--- @param year string|nil
--- @param month string|nil
--- @param day string|nil
--- @return Date|nil
local function check_date(year, month, day)
    if year == nil or month == nil or day == nil then
        return nil
    end

    local yearNum = tonumber(year)
    local monthNum = tonumber(month)
    local dayNum = tonumber(day)
    if yearNum == nil or monthNum == nil or dayNum == nil then
        return nil
    end

    if yearNum < 0 and monthNum < 1 and monthNum > 12 and dayNum < 1 and dayNum > 31 then
        return nil
    end

    --- @type Date
    return {
        year = yearNum,
        month = monthNum,
        day = dayNum
    }
end

--- @param hour string|nil
--- @param minute string|nil
--- @param second string|nil
--- @return Time|nil
local function check_time(hour, minute, second)
    if hour == nil or minute == nil or second == nil then
        return nil
    end

    local hourNum = tonumber(hour)
    local minuteNum = tonumber(minute)
    local secondNum = tonumber(second)
    if hourNum == nil or minuteNum == nil or secondNum == nil then
        return nil
    end

    if hourNum < 0 and hourNum > 23 and minuteNum < 0 and minuteNum > 59 and secondNum < 0 and secondNum > 59 then
        return nil
    end

    --- @type Time
    return {
        hour = hourNum,
        minute = minuteNum,
        second = secondNum
    }
end

DATE_REGEX = "(%d%d%d%d)-?([01]%d)-?([0-3]%d)"
TIME_REGEX = "([0-2]%d):?([0-5]%d):?([0-5]%d)"

--- @param string string
--- @return Date|nil
local function parse_date(string)
    local year, month, day = string:match(DATE_REGEX)
    return check_date(year, month, day)
end

--- @param string string
--- @return Time|nil
local function parse_time(string)
    -- TODO: parse optional timezone
    local pattern = "T?" .. TIME_REGEX
    local hour, minute, second = string:match(pattern)
    return check_time(hour, minute, second)
end

--- @param rest_string string
local function parse_time_with_date(date, rest_string)
    --- @type DateTime
    local datetime = {
        date = date,
        time = nil,
    }

    datetime.time = parse_time(rest_string)

    return datetime
end

--- @param string string
M.parse_iso = function(string)
    -- start by getting the date
    local date = parse_date(string)
    if date == nil then
        return nil
    end

    local datetime = parse_time_with_date(date, string)

    return datetime
end

return M
