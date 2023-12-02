- Install [Local Lua Debugger (`tomblind.local-lua-debugger-vscode`)](https://marketplace.visualstudio.com/items?itemName=tomblind.local-lua-debugger-vscode) to VS Code
- Have your `.vscode/launch.json` set up like this:
    ```jsonc
    {
        "version": "0.2.0",
        "configurations": [
            {
                "type": "lua-local",
                "request": "launch",
                "name": "Debug",
                "program": {
                    "command": "love"
                },
                "args": [ "D:\\development\\Kristal", "--mod", "dark_place" ],
                "scriptRoots": ["D:\\development\\Kristal", "."]
            }
        ]
    }
    ```
- Replace the `breakForError` function in `.vscode\extensions\tomblind.local-lua-debugger-vscode-0.3.3\debugger\lldebugger.lua` with the following
    ```lua
    local function breakForError(err, level, propagate)
        local message
        local kristalClassLoaderErrorTreatment -- dobby
        if type(err) == "table" and err.included then
            kristalClassLoaderErrorTreatment = true
            message = mapSources(err.msg)
            err.msg = message
        else
            message = mapSources(
                tostring(err)
            )
        end
        level = (level or 1) + 1
        if skipNextBreak then
            skipNextBreak = false
        elseif not inDebugBreak then
            local thread = getActiveThread()
            Send.debugBreak(
                message,
                "error",
                getThreadId(thread)
            )
            debugBreak(thread, level)
        end
        if propagate then
            skipNextBreak = true
            if kristalClassLoaderErrorTreatment then
                luaError(err, level)
            else
                luaError(message, level)
            end
        end
    end
    ```
- Now you can press F5 to start Kristal quickly and gain some other useful debugging tools