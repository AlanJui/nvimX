

# DAP Client

nvim-dap is a debug adapter protocol client, or "debugger", or "debug-frontend".

With the help of a debug-adapter it can:

- Launch an application to debug
- Attach to running applications to debug them
- Set breakpoints and step through code
- Inspect the state of the application

A debug-adapter is a facilitator between nvim-dap (the client), and a
language specific debugger:


    DAP-Client ----- Debug Adapter ------- Debugger ------ Debugee
    (nvim-dap)  |   (per language)  |   (per language)    (your app)
                |                   |
                |        Implementation specific communication
                |        Debug-adapter and debugger could be the same process
                |
         Communication via debug adapter protocol


To debug applications, you need to configure two things per language:

- A debug adapter (|dap-adapter|)
- How to launch your application to debug or how to attach to a running
  application (|dap-configuration|)


Available Debug Adapters:
  https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/

Adapter configuration and installation instructions:
  https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

Debug Adapter protocol:
  https://microsoft.github.io/debug-adapter-protocol/

# Reference

 - [Nvim DAP Document](https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt)
