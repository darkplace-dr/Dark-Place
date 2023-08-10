local lib = {}
LLDbg = lib

function lib:preInit()
    if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" and not package.loaded["lldebugger"] then
        require("lldebugger")
    end

    self:startDebugger()
end

function lib:startDebugger()
    if package.loaded["lldebugger"] then
        lldebugger.start()
    end
end

function lib:breakpoint()
    if package.loaded["lldebugger"] then
        lldebugger.requestBreak()
    end
end
lib.bp = lib.breakpoint

function lib:stopDebugger()
    if package.loaded["lldebugger"] then
        lldebugger.finish()
    end
end

function lib:unload()
    self:stopDebugger()
end

return lib