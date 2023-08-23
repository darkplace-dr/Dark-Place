---@class Log
local Log = {}

---@alias LoggerMsgLevels
---| "log"
---| "warn"
---| "error"

-- Prints `msg` to the console with message level `msg_level`.
---@param msg any will be converted to a string
---@param msg_level? LoggerMsgLevels `log` by default
function Log:print(msg, msg_level)
    msg = tostring(msg)
    msg_level = msg_level or "log"

    local prefixs = {
        warn = "[WARNING] ",
        error = "[ERROR] "
    }
    local prefixs_rich = {
        warn = "[color:yellow][WARNING] ",
        error = "[color:red][ERROR] "
    }

    local prefixed_msg = (prefixs[msg_level] or "")..msg
    print(prefixed_msg)

    if Kristal.Console then
        local prefixed_msg_rich = (prefixs_rich[msg_level] or "")..msg
        Kristal.Console:push(prefixed_msg_rich)
    end
end

-- Prints `msg` to the console with message level `msg_level`, with a little extra trace info about the caller added.
---@param msg any will be converted to a string
---@param msg_level? LoggerMsgLevels `log` by default
---@param stack_level? integer|function which level of stack to print about, is where the caller is at by default
function Log:trace(msg, msg_level, stack_level)
    msg_level = msg_level or "log"
    stack_level = stack_level or 2
    msg = tostring(msg)

    local stack_info = debug.getinfo(stack_level, "Snl")
    local func_name = stack_info.name
    local line = stack_info.currentline
    local src = stack_info.short_src
    if Utils.startsWith(stack_info.source, "@") then
        local ok, src_n = Utils.startsWith(stack_info.source:sub(2), Mod.info.path.."/")
        if ok then
            src = src_n
        else
            src = "[kristal]/" .. src
        end
    end

    local msg_prefix = (stack_info.what ~= "main" and func_name)
        and string.format("%s:%d (%s): ", src, line, func_name)
        or string.format("%s:%d: ", src, line)
    msg = msg_prefix .. msg

    self:print(msg, msg_level)
end

return Log