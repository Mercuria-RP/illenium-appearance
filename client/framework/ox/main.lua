if not Framework.Ox() then return end

local Ox = require '@ox_core.lib.init'
local player = Ox.GetPlayer()

local function RefreshPlayerGroups()
    local groups = player.getGroups()
    local jobName, jobGrade = nil, 0
    local gangName, gangGrade = nil, 0

    if groups then
        for group, grade in pairs(groups) do
            if not jobName then
                jobName = group
                jobGrade = grade
            end
        end
    end

    client.job = {
        name = jobName or "unemployed",
        grade = jobGrade,
        onduty = true
    }

    client.gang = {
        name = gangName or "",
        grade = gangGrade
    }
end

RegisterNetEvent("ox:setActiveCharacter", function(character)
    if character.isNew then
        return InitializeCharacter(Framework.GetGender(true))
    end

    RefreshPlayerGroups()
    InitAppearance()
end)

RegisterNetEvent("ox:setGroup", function(group, grade)
    RefreshPlayerGroups()
end)

function Framework.GetPlayerGender()
    return player.get('gender') == 'female' and 'Female' or 'Male'
end

function Framework.UpdatePlayerData()
    RefreshPlayerGroups()
end

function Framework.HasTracker() return false end

function Framework.CheckPlayerMeta()
    return LocalPlayer.state.isDead or IsPedCuffed(cache.ped)
end

function Framework.IsPlayerAllowed(charId)
    return charId == player.charId
end

function Framework.GetRankInputValues() end

function Framework.GetJobGrade()
    return client.job and client.job.grade or 0
end

function Framework.GetGangGrade()
    return client.gang and client.gang.grade or 0
end

function Framework.CachePed() end

function Framework.RestorePlayerArmour() end
