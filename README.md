# WoWAPI_ClassicEra

This repository contains two comprehensive files for World of Warcraft Classic Era addon developers, with a special focus on the Hardcore challenge community:

- `wow_classic_hc_lib.lua` – A utility library packed with organized, ready-to-use Lua functions for all major gameplay and Hardcore tracking needs.
- `wow_classic_api_reference.lua` – A reference file listing essential Blizzard WoW API functions, their usage, parameters, and examples for quick lookup and learning.

## Features

### 1. Utility Library (`wow_classic_hc_lib.lua`)
- **Chat & Communication:** Automate messages, whispers, emotes, and addon messaging.
- **Unit & Group Status:** Access health, mana, buffs, group info, and more for player or party/raid.
- **Events & Monitoring:** Register event listeners for death, combat, level up, zone changes, etc.
- **UI & Alerts:** Show warnings, errors, play sounds, display popups, and manage timers.
- **Inventory & Gear:** Scan bags, check equipped items, track durability, item counts.
- **Hardcore Tracking:** Detect death, auto-leave guild, announce milestones, log achievements.
- **Macros & Automation:** Run macros, cast spells, use items (secure actions permitted by Blizzard).
- **Quest & Progress Tracking:** Monitor quest log, objectives, completion.
- **Map & Navigation:** Get location, zone, set waypoints (for compatible map addons).
- **Social & Guild Tools:** Manage guild roster, promote/demote/invite, announce to guild.
- **Miscellaneous:** Export character data, manage SavedVariables, reload UI, logout, etc.

### 2. API Reference (`wow_classic_api_reference.lua`)
- **Quick Lookups:** Blizzard WoW Lua API function calls, with parameter documentation and examples.
- **Sectioned by Use Case:** Easily find functions for chat, events, combat, inventory, quests, social actions, and more.

## Getting Started

1. **Clone this repository** to your WoW Classic Era addon project directory.
2. **Use `wow_classic_hc_lib.lua`** in your addon as a Lua module:
    ```lua
    local HC = require("wow_classic_hc_lib")
    HC.SendChatMessage("Hardcore forever!", "GUILD")
    ```
3. **Consult `wow_classic_api_reference.lua`** for quick API usage and examples when building your own functions and event handlers.

## Contribution

Feel free to fork, submit pull requests, or open issues for improvements, new function ideas, or documentation clarifications.

## License

Open source under the [MIT License](LICENSE).

## Credits

Created by MrJambix for the WoW Classic Era Hardcore community.  
Inspired by the needs of addon authors, challenge runners, and anyone who wants to level up their WoW Lua scripting!

---
**Good luck, and may your Hardcore journey be legendary!**
