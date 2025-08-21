# takenncs-bodycam

[![FiveM](https://img.shields.io/badge/FiveM-Compatible-brightgreen)](https://fivem.net/)
[![Lua](https://img.shields.io/badge/Lua-Script-blue)](https://www.lua.org/)
[![License](https://img.shields.io/badge/License-MIT-yellow)](#license)

A **QBCore bodycam script** for FiveM, designed for police jobs. It allows police officers to toggle a body camera on/off, display time, and set the camera position on the screen.

---

## Features

- Toggle bodycam on and off  
- Display player info, rank, and callsign on the bodycam  
- Show current date and time in GMT+3  
- Move the bodycam position (left or right)  
- Restrict usage to police job only  
- Notifications for toggling and position changes  

---

## Installation

1. Place the `takenncs-bodycam` folder in your `resources` directory.  
2. Add the resource to your `server.cfg`:

```cfg
ensure takenncs-bodycam
