-- WoW Classic Era Hardcore Library (Expanded)
-- Author: MrJambix

local HC = {}

----------------------------------------------------------------------
-- 1. Chat & Communication
----------------------------------------------------------------------

function HC.SendChatMessage(msg, channel)
    SendChatMessage(msg, channel)
end

function HC.WhisperPlayer(playerName, msg)
    SendChatMessage(msg, "WHISPER", nil, playerName)
end

function HC.SendEmote(emote)
    DoEmote(emote)
end

function HC.BroadcastRaid(msg)
    SendChatMessage(msg, "RAID")
end

function HC.BroadcastParty(msg)
    SendChatMessage(msg, "PARTY")
end

function HC.SendAddonMessage(prefix, msg, channel, target)
    C_ChatInfo.SendAddonMessage(prefix, msg, channel, target)
end

function HC.RegisterAddonMessage(prefix, callback)
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("CHAT_MSG_ADDON")
    frame:SetScript("OnEvent", function(_, _, ...)
        local receivedPrefix, text, channel, sender = ...
        if receivedPrefix == prefix then
            callback(text, channel, sender)
        end
    end)
end

function HC.FilterChat(keywords, callback)
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("CHAT_MSG_CHANNEL")
    frame:SetScript("OnEvent", function(_, _, msg, sender)
        for _, keyword in ipairs(keywords) do
            if string.find(msg, keyword) then
                callback(msg, sender)
            end
        end
    end)
end

function HC.SendSystemMessage(msg)
    UIErrorsFrame:AddMessage(msg)
end

----------------------------------------------------------------------
-- 2. Unit & Group Status
----------------------------------------------------------------------

function HC.GetPlayerHealth()
    return UnitHealth("player"), UnitHealthMax("player")
end

function HC.GetPlayerMana()
    return UnitPower("player", 0), UnitPowerMax("player", 0)
end

function HC.GetPlayerClass()
    return UnitClass("player")
end

function HC.GetPlayerLevel()
    return UnitLevel("player")
end

function HC.GetPlayerBuffs()
    local buffs = {}
    for i = 1, 40 do
        local name = UnitBuff("player", i)
        if not name then break end
        table.insert(buffs, name)
    end
    return buffs
end

function HC.GetPlayerDebuffs()
    local debuffs = {}
    for i = 1, 40 do
        local name = UnitDebuff("player", i)
        if not name then break end
        table.insert(debuffs, name)
    end
    return debuffs
end

function HC.GetGroupHealth()
    local healths = {}
    local members = GetNumGroupMembers()
    for i = 1, members do
        local unit = IsInRaid() and "raid"..i or "party"..i
        healths[unit] = UnitHealth(unit)
    end
    return healths
end

function HC.IsUnitDead(unit)
    return UnitIsDeadOrGhost(unit)
end

function HC.IsPlayerInCombat()
    return UnitAffectingCombat("player")
end

function HC.GetUnitPosition(unit)
    local x, y, instance = UnitPosition(unit)
    return x, y, instance
end

function HC.GetUnitDistance(unit)
    local px, py = UnitPosition("player")
    local ux, uy = UnitPosition(unit)
    if px and py and ux and uy then
        local dx, dy = px - ux, py - uy
        return math.sqrt(dx * dx + dy * dy)
    end
    return nil
end

function HC.IsPartyLeader()
    return UnitIsGroupLeader("player")
end

function HC.IsRaidLeader()
    return UnitIsRaidLeader("player")
end

----------------------------------------------------------------------
-- 3. Events & Monitoring
----------------------------------------------------------------------

function HC.OnPlayerDeath(callback)
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("PLAYER_DEAD")
    frame:SetScript("OnEvent", function() callback() end)
end

function HC.OnLevelUp(callback)
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("PLAYER_LEVEL_UP")
    frame:SetScript("OnEvent", function(_, _, level) callback(level) end)
end

function HC.WatchCombatLog(eventType, callback)
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    frame:SetScript("OnEvent", function()
        local _, event, _, srcGUID, srcName, _, _, destGUID, destName, _, _, spellID, spellName = CombatLogGetCurrentEventInfo()
        if event == eventType then
            callback(srcName, destName, spellName)
        end
    end)
end

function HC.OnZoneChange(callback)
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    frame:SetScript("OnEvent", function() callback() end)
end

function HC.OnEnterCombat(callback)
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("PLAYER_REGEN_DISABLED")
    frame:SetScript("OnEvent", function() callback() end)
end

function HC.OnLeaveCombat(callback)
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("PLAYER_REGEN_ENABLED")
    frame:SetScript("OnEvent", function() callback() end)
end

function HC.OnBagUpdate(callback)
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("BAG_UPDATE")
    frame:SetScript("OnEvent", function() callback() end)
end

function HC.OnTalentChanged(callback)
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("CHARACTER_POINTS_CHANGED")
    frame:SetScript("OnEvent", function() callback() end)
end

----------------------------------------------------------------------
-- 4. UI & Alerts
----------------------------------------------------------------------

function HC.ShowWarning(msg)
    RaidNotice_AddMessage(RaidWarningFrame, msg, ChatTypeInfo["RAID_WARNING"])
end

function HC.ShowError(msg)
    UIErrorsFrame:AddMessage(msg, 1, 0, 0, 53, 5)
end

function HC.ShowInfo(msg)
    UIErrorsFrame:AddMessage(msg, 0, 1, 0, 53, 5)
end

function HC.PlayAlertSound(soundID)
    PlaySound(soundID)
end

function HC.ShowPopup(msg)
    StaticPopupDialogs["HC_POPUP"] = {
        text = msg,
        button1 = "OK",
        timeout = 0,
        whileDead = true,
        hideOnEscape = true
    }
    StaticPopup_Show("HC_POPUP")
end

function HC.CreateTimerBar(name, duration)
    -- Example using LibCandyBar or similar
    -- LibCandyBar:New(name, duration):Start()
end

function HC.FlashScreen()
    -- Example: Flash the screen red (requires frame setup)
    -- Could use UIParent:SetBackdropColor for a flash effect
end

----------------------------------------------------------------------
-- 5. Inventory & Gear
----------------------------------------------------------------------

function HC.ListBagItems()
    local items = {}
    for bag = 0, NUM_BAG_SLOTS do
        for slot = 1, GetContainerNumSlots(bag) do
            local itemLink = GetContainerItemLink(bag, slot)
            if itemLink then table.insert(items, itemLink) end
        end
    end
    return items
end

function HC.GetEquippedItems()
    local equipped = {}
    for slot = 1, 19 do
        local itemLink = GetInventoryItemLink("player", slot)
        if itemLink then equipped[slot] = itemLink end
    end
    return equipped
end

function HC.GetItemCount(itemID)
    return GetItemCount(itemID)
end

function HC.GetBagFreeSlots()
    local free = 0
    for bag = 0, NUM_BAG_SLOTS do
        free = free + GetContainerNumFreeSlots(bag)
    end
    return free
end

function HC.HasItemInBags(itemID)
    return GetItemCount(itemID) > 0
end

function HC.GetDurabilityPercent()
    local total, current = 0, 0
    for slot = 1, 19 do
        local cur, max = GetInventoryItemDurability(slot)
        if cur and max then
            current = current + cur
            total = total + max
        end
    end
    if total == 0 then return 100 end
    return math.floor(current / total * 100)
end

function HC.IsItemEquipped(itemID)
    for slot = 1, 19 do
        local itemLink = GetInventoryItemLink("player", slot)
        if itemLink and string.find(itemLink, "item:"..itemID) then
            return true
        end
    end
    return false
end

----------------------------------------------------------------------
-- 6. Hardcore-Specific Tracking
----------------------------------------------------------------------

function HC.TrackHardcoreDeath(callback)
    HC.OnPlayerDeath(function()
        callback()
        -- e.g., HC logic, auto-leave guild, announce death
    end)
end

function HC.AnnounceAchievement(msg)
    HC.SendChatMessage(msg, "GUILD")
end

function HC.LogDeathToFile()
    -- Placeholder: WoW Classic does not allow file writes, but you can build a string to copy/paste
    -- Use SavedVariables for persistence
end

function HC.AutoLeaveGuildOnDeath()
    HC.TrackHardcoreDeath(function()
        GuildLeave()
    end)
end

function HC.NotifyDiscordOnDeath(webhookURL, playerName, level)
    -- Placeholder: WoW Lua can't do web requests, but you can build a string for manual copy/paste
end

function HC.TrackBossKills(callback)
    HC.WatchCombatLog("UNIT_DIED", function(src, dest, spell)
        -- Logic for tracking boss deaths, call callback
        callback(src, dest, spell)
    end)
end

function HC.TrackMilestone(levels, callback)
    HC.OnLevelUp(function(level)
        for _, milestone in ipairs(levels) do
            if level == milestone then
                callback(level)
            end
        end
    end)
end

----------------------------------------------------------------------
-- 7. Macros & Automation (Secure)
----------------------------------------------------------------------

function HC.RunMacro(text)
    RunMacroText(text)
end

function HC.CastSpellByName(spellName)
    CastSpellByName(spellName)
end

function HC.UseItemByName(itemName)
    UseItemByName(itemName)
end

function HC.SetTarget(targetName)
    TargetUnit(targetName)
end

function HC.TargetLastTarget()
    TargetLastTarget()
end

function HC.ClearTarget()
    ClearTarget()
end

function HC.StartAttack()
    AttackTarget()
end

function HC.StopAttack()
    StopAttack()
end

----------------------------------------------------------------------
-- 8. Quest & Progress Tracking
----------------------------------------------------------------------

function HC.GetQuestProgress(questIndex)
    local title, level, suggestedGroup, isHeader, isCollapsed, isComplete = GetQuestLogTitle(questIndex)
    return {
        title = title,
        level = level,
        suggestedGroup = suggestedGroup,
        isHeader = isHeader,
        isCollapsed = isCollapsed,
        isComplete = isComplete
    }
end

function HC.GetActiveQuests()
    local quests = {}
    for i = 1, GetNumQuestLogEntries() do
        local info = HC.GetQuestProgress(i)
        if not info.isHeader then
            table.insert(quests, info)
        end
    end
    return quests
end

function HC.IsQuestComplete(questIndex)
    local info = HC.GetQuestProgress(questIndex)
    return info.isComplete == 1
end

function HC.TrackQuestCompletion(callback)
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("QUEST_LOG_UPDATE")
    frame:SetScript("OnEvent", function()
        for i = 1, GetNumQuestLogEntries() do
            if HC.IsQuestComplete(i) then
                callback(HC.GetQuestProgress(i))
            end
        end
    end)
end

function HC.GetQuestObjectives(questIndex)
    local objectives = {}
    for obj = 1, GetNumQuestLeaderBoards(questIndex) do
        local desc, type, done = GetQuestLogLeaderBoard(obj, questIndex)
        table.insert(objectives, {desc = desc, type = type, done = done})
    end
    return objectives
end

----------------------------------------------------------------------
-- 9. Map & Navigation
----------------------------------------------------------------------

function HC.SetWaypoint(x, y, zone)
    -- Example for TomTom or Cartographer
    -- TomTom:AddWaypoint(zone, x, y, {title = "HC Waypoint"})
end

function HC.GetPlayerZone()
    return GetZoneText()
end

function HC.GetPlayerSubZone()
    return GetSubZoneText()
end

function HC.IsInDangerousZone(zones)
    local zone = HC.GetPlayerZone()
    for _, z in ipairs(zones) do
        if zone == z then return true end
    end
    return false
end

function HC.AlertOnApproachingElite()
    HC.WatchCombatLog("UNIT_DIED", function(src, dest)
        -- Logic: Alert if an elite mob is nearby or died
    end)
end

function HC.GetMapCoords()
    local x, y = C_Map.GetPlayerMapPosition(C_Map.GetBestMapForUnit("player"), "player"):GetXY()
    return x, y
end

----------------------------------------------------------------------
-- 10. Social & Guild Tools
----------------------------------------------------------------------

function HC.GetGuildMembers()
    local members = {}
    for i = 1, GetNumGuildMembers() do
        local name, rank, rankIndex, level, class = GetGuildRosterInfo(i)
        table.insert(members, {name = name, rank = rank, level = level, class = class})
    end
    return members
end

function HC.AnnounceToGuild(msg)
    HC.SendChatMessage(msg, "GUILD")
end

function HC.GetGuildDeathLog()
    -- Build a death log from SavedVariables, manual copy/paste
end

function HC.GuildPromote(name)
    GuildPromote(name)
end

function HC.GuildDemote(name)
    GuildDemote(name)
end

function HC.GuildInvite(name)
    GuildInvite(name)
end

function HC.LeaveParty()
    LeaveParty()
end

function HC.LeaveRaid()
    LeaveParty() -- works for raid too
end

----------------------------------------------------------------------
-- 11. Miscellaneous
----------------------------------------------------------------------

function HC.ExportCharacterData()
    return {
        name = UnitName("player"),
        class = UnitClass("player"),
        level = UnitLevel("player"),
        items = HC.GetEquippedItems(),
        achievements = {} -- Add achievement tracking
    }
end

function HC.SaveToSavedVariables(key, value)
    HC_DB = HC_DB or {}
    HC_DB[key] = value
end

function HC.LoadFromSavedVariables(key)
    HC_DB = HC_DB or {}
    return HC_DB[key]
end

function HC.GetServerTime()
    return GetServerTime()
end

function HC.ReloadUI()
    ReloadUI()
end

function HC.Logout()
    Logout()
end

function HC.QuitGame()
    ForceQuit()
end

----------------------------------------------------------------------
-- Return library
----------------------------------------------------------------------

return HC