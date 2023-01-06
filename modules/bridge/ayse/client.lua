local function reorderGroups(groups)
    groups = groups or {}
    for group, info in pairs(groups) do
        groups[group] = info.rank
    end
    return groups
end

SetTimeout(500, function()
	AyseCore = exports["Ayse_Core"]:GetCoreObject()
		
	local character = AyseCore.Functions.GetSelectedCharacter()
    if character then
    	local groups = reorderGroups(character.data.groups)
    	OnPlayerData("groups", groups)
	end
end)

RegisterNetEvent("Ayse:setCharacter", function(character)
    local groups = reorderGroups(character.data.groups)
    OnPlayerData("groups", groups)
end)

RegisterNetEvent("Ayse:jobChanged", function(job, lastJob)
    local character = AyseCore.Functions.GetSelectedCharacter()
    local groups = reorderGroups(character.data.groups)
    groups[lastJob.name] = nil
    groups[job.name] = job.rank
    
    OnPlayerData("groups", groups)
end)

function client.setPlayerStatus(values)
	for name, value in pairs(values) do
        if value == 0 then
            exports["Ayse_Status"]:setStatus(name, value)
        else
            exports["Ayse_Status"]:changeStatus(name, value)
        end
    end
end
