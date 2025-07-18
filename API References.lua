-- WoW Classic Era API Reference for Hardcore Addon Development

----------------------------------------------------------------------
-- 1. Chat & Communication
----------------------------------------------------------------------

-- SendChatMessage
-- Sends a message to a chat channel.
-- Usage: SendChatMessage("message", "channelType", language, target)
-- Example: SendChatMessage("Hello!", "PARTY")
-- channelType: "SAY", "YELL", "PARTY", "RAID", "GUILD", "WHISPER", etc.
-- language: nil for default (optional)
-- target: player name for WHISPER (optional)

-- DoEmote
-- Makes your character perform an emote.
-- Usage: DoEmote("emote")
-- Example: DoEmote("wave")

-- C_ChatInfo.SendAddonMessage
-- Sends an addon message to a channel.
-- Usage: C_ChatInfo.SendAddonMessage("prefix", "message", "channel", "target")
-- Example: C_ChatInfo.SendAddonMessage("MyAddon", "Hello", "WHISPER", "PlayerName")

-- RegisterAddonMessagePrefix
-- Registers your addon message prefix before sending messages.
-- Usage: C_ChatInfo.RegisterAddonMessagePrefix("prefix")

----------------------------------------------------------------------
-- 2. Unit & Group Status
----------------------------------------------------------------------

-- UnitHealth
-- Returns current health for a unit.
-- Usage: UnitHealth("unitID")
-- Example: UnitHealth("player") or UnitHealth("party1")

-- UnitHealthMax
-- Returns maximum health for a unit.
-- Usage: UnitHealthMax("unitID")

-- UnitPower
-- Returns current mana/rage/energy for a unit.
-- Usage: UnitPower("unitID", powerType)
-- powerType: 0 = mana, 1 = rage, 3 = energy

-- UnitPowerMax
-- Returns maximum resource for a unit.
-- Usage: UnitPowerMax("unitID", powerType)

-- UnitClass
-- Returns class of a unit.
-- Usage: local className, classFilename, classID = UnitClass("unitID")

-- UnitLevel
-- Returns level of a unit.
-- Usage: UnitLevel("unitID")

-- UnitBuff / UnitDebuff
-- Returns name of a buff/debuff for a unit.
-- Usage: UnitBuff("unitID", [index])
-- Example: UnitBuff("player", 1)

-- UnitIsDeadOrGhost
-- Returns true if unit is dead or ghost.
-- Usage: UnitIsDeadOrGhost("unitID")

-- UnitAffectingCombat
-- Returns true if unit is in combat.
-- Usage: UnitAffectingCombat("unitID")

-- UnitPosition
-- Returns position for a unit (x, y, instanceID).
-- Usage: UnitPosition("unitID")

-- GetNumGroupMembers
-- Returns number of group/raid members.
-- Usage: GetNumGroupMembers()

----------------------------------------------------------------------
-- 3. Events & Monitoring
----------------------------------------------------------------------

-- CreateFrame("Frame")
-- Used to register event listeners.
-- Usage: local frame = CreateFrame("Frame")

-- frame:RegisterEvent("EVENT_NAME")
-- Usage: frame:RegisterEvent("PLAYER_DEAD")

-- frame:SetScript("OnEvent", function(self, event, ...)
--     -- handle event
-- end)

-- CombatLogGetCurrentEventInfo
-- Returns detailed info about current combat log event.
-- Usage: local timestamp, eventType, hideCaster, ... = CombatLogGetCurrentEventInfo()

----------------------------------------------------------------------
-- 4. UI & Alerts
----------------------------------------------------------------------

-- RaidNotice_AddMessage
-- Shows a raid warning message.
-- Usage: RaidNotice_AddMessage(RaidWarningFrame, "Message", ChatTypeInfo["RAID_WARNING"])

-- UIErrorsFrame:AddMessage
-- Shows an error/info message above UI.
-- Usage: UIErrorsFrame:AddMessage("Message", r, g, b, font, duration)

-- PlaySound
-- Plays a sound.
-- Usage: PlaySound(soundID)
-- Example: PlaySound(8959) -- "Raid Warning"

-- StaticPopupDialogs / StaticPopup_Show
-- Shows a dialog popup.
-- Usage:
-- StaticPopupDialogs["MY_POPUP"] = { text = "Message", button1 = "OK", ... }
-- StaticPopup_Show("MY_POPUP")

----------------------------------------------------------------------
-- 5. Inventory & Gear
----------------------------------------------------------------------

-- GetContainerItemLink
-- Returns item link from bag slot.
-- Usage: GetContainerItemLink(bag, slot)

-- GetInventoryItemLink
-- Returns item link from equipped slot.
-- Usage: GetInventoryItemLink("unitID", slot)

-- GetItemCount
-- Returns total count of an itemID.
-- Usage: GetItemCount(itemID)

-- GetContainerNumSlots
-- Returns number of slots in a bag.
-- Usage: GetContainerNumSlots(bag)

-- GetContainerNumFreeSlots
-- Returns number of free slots in a bag.
-- Usage: GetContainerNumFreeSlots(bag)

-- GetInventoryItemDurability
-- Returns current and max durability for an equipped slot.
-- Usage: GetInventoryItemDurability(slot)

----------------------------------------------------------------------
-- 6. Hardcore-Specific Tracking (via events/UI)
----------------------------------------------------------------------

-- GuildLeave
-- Leaves your current guild.
-- Usage: GuildLeave()

-- LeaveParty
-- Leaves your current party/raid.
-- Usage: LeaveParty()

----------------------------------------------------------------------
-- 7. Macros & Automation (Secure)
----------------------------------------------------------------------

-- RunMacroText
-- Runs a macro from Lua.
-- Usage: RunMacroText("/command")

-- CastSpellByName
-- Casts a spell by name.
-- Usage: CastSpellByName("Spell Name")

-- UseItemByName
-- Uses an item by name.
-- Usage: UseItemByName("Item Name")

-- TargetUnit
-- Targets a unit by name.
-- Usage: TargetUnit("unitName")

-- TargetLastTarget
-- Targets your last target.
-- Usage: TargetLastTarget()

-- ClearTarget
-- Clears your current target.
-- Usage: ClearTarget()

-- AttackTarget / StopAttack
-- Starts/stops auto-attack.
-- Usage: AttackTarget(), StopAttack()

----------------------------------------------------------------------
-- 8. Quest & Progress Tracking
----------------------------------------------------------------------

-- GetNumQuestLogEntries
-- Returns number of quests in quest log.
-- Usage: GetNumQuestLogEntries()

-- GetQuestLogTitle
-- Returns info for quest at index.
-- Usage: GetQuestLogTitle(index)

-- GetNumQuestLeaderBoards
-- Returns number of objectives for a quest.
-- Usage: GetNumQuestLeaderBoards(questLogIndex)

-- GetQuestLogLeaderBoard
-- Returns info for a quest objective.
-- Usage: GetQuestLogLeaderBoard(objectiveIndex, questLogIndex)

----------------------------------------------------------------------
-- 9. Map & Navigation
----------------------------------------------------------------------

-- GetZoneText / GetSubZoneText
-- Returns current zone/subzone name.
-- Usage: GetZoneText(), GetSubZoneText()

-- C_Map.GetPlayerMapPosition
-- Returns map position object.
-- Usage: local pos = C_Map.GetPlayerMapPosition(mapID, "player")
-- local x, y = pos:GetXY()

-- C_Map.GetBestMapForUnit
-- Gets best map ID for unit.
-- Usage: C_Map.GetBestMapForUnit("player")

----------------------------------------------------------------------
-- 10. Social & Guild Tools
----------------------------------------------------------------------

-- GetNumGuildMembers
-- Returns number of guild members.
-- Usage: GetNumGuildMembers()

-- GetGuildRosterInfo
-- Returns info about a guild member.
-- Usage: GetGuildRosterInfo(index)

-- GuildPromote / GuildDemote / GuildInvite
-- Manage guild members.
-- Usage: GuildPromote("name"), GuildDemote("name"), GuildInvite("name")

----------------------------------------------------------------------
-- 11. Miscellaneous
----------------------------------------------------------------------

-- ReloadUI
-- Reloads the user interface.
-- Usage: ReloadUI()

-- Logout
-- Logs out of the game.
-- Usage: Logout()

-- ForceQuit
-- Quits the game completely.
-- Usage: ForceQuit()

-- GetServerTime
-- Returns server time as Unix timestamp.
-- Usage: GetServerTime()

----------------------------------------------------------------------
-- SavedVariables (Custom, not API)
-- Used to persist data between sessions (set in TOC file).
-- Usage: MyAddonDB = MyAddonDB or {}
-- MyAddonDB["key"] = value

-- To access, use: MyAddonDB["key"]

----------------------------------------------------------------------

-- End of API Reference