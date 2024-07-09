local txAdminPlayerKickedWH = 'https://discord.com/api/webhooks/xxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
local txAdminPlayerWarnedWH = 'https://discord.com/api/webhooks/xxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
local txAdminPlayerBannedWH = 'https://discord.com/api/webhooks/xxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
local txAdminHealedPlayerWH = 'https://discord.com/api/webhooks/xxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
local txAdminAdminAuthWH = 'https://discord.com/api/webhooks/xxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
local txAdminPlayerDirectMessageWH = 'https://discord.com/api/webhooks/xxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
local txAdminActionRevokedWH = 'https://discord.com/api/webhooks/xxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
local txAdminWhitelistPlayerWH = 'https://discord.com/api/webhooks/xxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
local txAdminWhitelistPreApprovalWH = 'https://discord.com/api/webhooks/xxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
local txAdminWhitelistRequestWH = 'https://discord.com/api/webhooks/xxxxxxxxxxxxxxxxxxx/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'

function txAdminLog(title, description, webhook)
    if webhook == '' then
        print('^1[ERROR]^7 Webhook URL not set for ' .. title)
        return
    end

    local headers = {
        ['Content-Type'] = 'application/json'
    }

    local data = {
        ["username"] = "txAdmin Logs",
        ["embeds"] = {{
            ["title"] = title,
            ["description"] = description,
            ["color"] = 16711680,
            ["footer"] = {
                ["text"] = os.date('%Y-%m-%d %H:%M:%S')
            }
        }}
    }

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end

AddEventHandler('txAdmin:events:playerKicked', function(eventData)
    txAdminLog("Player Kicked", '**Author:** '..eventData.author..'\n**Target:** '..eventData.target..'\n**Reason:** '..eventData.reason, txAdminPlayerKickedWH)
end)

AddEventHandler('txAdmin:events:playerWarned', function(eventData)
    txAdminLog("Player Warned", '**Author:** '..eventData.author..'\n**Target:** '..eventData.target..'\n**Reason:** '..eventData.reason..'\n**Action ID:** '..eventData.actionId, txAdminPlayerWarnedWH)
end)

AddEventHandler('txAdmin:events:playerBanned', function(eventData)
    txAdminLog("Player Banned", '**Author:** '..eventData.author..'\n**Target:** '..eventData.target..'\n**Action ID:** '..eventData.actionId..'\n**Expiration:** '..eventData.expiration..'\n**Duration Input:** '..eventData.durationInput..'\n**Duration Translated:** '..eventData.durationTranslated..'\n**Target Net ID:** '..eventData.targetNetId..'\n**Target IDs:** '..table.concat(eventData.targetIds, ', ')..'\n**Target HWIDs:** '..table.concat(eventData.targetHwids, ', ')..'\n**Target Name:** '..eventData.targetName..'\n**Kick Message:** '..eventData.kickMessage, txAdminPlayerBannedWH)
end)

AddEventHandler('txAdmin:events:healedPlayer', function(eventData)
    local description = eventData.id == -1 and "Whole server healed" or "Player ID: "..eventData.id.." healed"
    txAdminLog("Player Healed", description, txAdminHealedPlayerWH)
end)

AddEventHandler('txAdmin:events:adminAuth', function(eventData)
    local description = eventData.isAdmin and "Admin Authenticated" or "Admin Permissions Revoked"
    txAdminLog("Admin Authentication", '**Net ID:** '..eventData.netid..'\n**Is Admin:** '..tostring(eventData.isAdmin)..'\n**Username:** '..(eventData.username or ''), txAdminAdminAuthWH)
end)

AddEventHandler('txAdmin:events:playerDirectMessage', function(eventData)
    txAdminLog("Player Direct Message", '**Author:** '..eventData.author..'\n**Target:** '..eventData.target..'\n**Message:** '..eventData.message, txAdminPlayerDirectMessageWH)
end)

AddEventHandler('txAdmin:events:actionRevoked', function(eventData)
    txAdminLog("Action Revoked", '**Action ID:** '..eventData.actionId..'\n**Action Type:** '..eventData.actionType..'\n**Action Reason:** '..eventData.actionReason..'\n**Action Author:** '..eventData.actionAuthor..'\n**Player Name:** '..(eventData.playerName or 'N/A')..'\n**Player IDs:** '..table.concat(eventData.playerIds, ', ')..'\n**Player HWIDs:** '..table.concat(eventData.playerHwids or {}, ', ')..'\n**Revoked By:** '..eventData.revokedBy, txAdminActionRevokedWH)
end)

AddEventHandler('txAdmin:events:whitelistPlayer', function(eventData)
    txAdminLog("Whitelist Player", '**Action:** '..eventData.action..'\n**License:** '..eventData.license..'\n**Player Name:** '..eventData.playerName..'\n**Admin Name:** '..eventData.adminName, txAdminWhitelistPlayerWH)
end)

AddEventHandler('txAdmin:events:whitelistPreApproval', function(eventData)
    local description = '**Action:** '..eventData.action..'\n**Identifier:** '..eventData.identifier..'\n**Admin Name:** '..eventData.adminName
    if eventData.action == 'added' then
        description = description .. '\n**Player Name:** '..eventData.playerName
    end
    txAdminLog("Whitelist Pre-Approval", description, txAdminWhitelistPreApprovalWH)
end)

AddEventHandler('txAdmin:events:whitelistRequest', function(eventData)
    local description = '**Action:** '..eventData.action..'\n**Player Name:** '..(eventData.playerName or 'N/A')..'\n**Request ID:** '..(eventData.requestId or 'N/A')..'\n**License:** '..(eventData.license or 'N/A')..'\n**Admin Name:** '..(eventData.adminName or 'N/A')
    txAdminLog("Whitelist Request", description, txAdminWhitelistRequestWH)
end)

local orinchin = [[
^4
 ██████╗ ██████╗     ████████╗██╗  ██╗██╗      ██████╗  ██████╗ ███████╗
██╔═══██╗██╔══██╗    ╚══██╔══╝╚██╗██╔╝██║     ██╔═══██╗██╔════╝ ██╔════╝
██║   ██║██║  ██║       ██║    ╚███╔╝ ██║     ██║   ██║██║  ███╗███████╗
██║   ██║██║  ██║       ██║    ██╔██╗ ██║     ██║   ██║██║   ██║╚════██║
╚██████╔╝██████╔╝       ██║   ██╔╝ ██╗███████╗╚██████╔╝╚██████╔╝███████║
 ╚═════╝ ╚═════╝        ╚═╝   ╚═╝  ╚═╝╚══════╝ ╚═════╝  ╚═════╝ ╚══════╝
]]

AddEventHandler('onResourceStart', function(resourceName)
    Citizen.Wait(5000)
    if GetCurrentResourceName() == resourceName then
        print(orinchin)
    end
end)
