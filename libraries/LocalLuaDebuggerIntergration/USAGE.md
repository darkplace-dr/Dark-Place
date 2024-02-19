- Install LÖVE to PATH
- Install this *specifically patched* version of [Local Lua Debugger](https://github.com/Dobby233Liu/local-lua-debugger-vscode/releases/tag/latest) (`tomblind.local-lua-debugger-vscode`) in VS Code
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
- Now you can press F5 to start Kristal quickly and gain some other useful debugging tools