
--[[
  Cops and Robbers Client Dependencies
  Created by Michael Harris (mike@harrisonline.us)
  05/11/2019
  
  This file contains all information that will be stored, used, and
  manipulated by any CNR scripts in the gamemode. For example, a
  player's level will be stored in this file and then retrieved using
  an export; Rather than making individual SQL queries each time.
  
  Permission is granted only for executing this script for the purposes
  of playing the gamemode as intended by the developer.
--]]

local activeZone   = 1
local wantedPoints = 0
local restarted    = {} -- DEBUG -

local plyCount = 255


--- EXPORT GetPlayers()
-- Retrieves a table of all connected players
-- @return Table of connected players
function GetPlayers()
    local players = {}
    for i = 0, plyCount do
      if NetworkIsPlayerActive(i) then
			  table.insert(players, i)
		  end
    end
    return players
end


--- EXPORT GetClosestPlayer()
-- Finds the closest player
-- @return Player local ID. Must be turned into a ped object or server ID from there.
function GetClosestPlayer()
	local ped  = GetPlayerPed(-1)
	local plys = GetPlayers()
	local cPly = nil
	local cDst = -1
	for k,v in pairs (plys) do
		local tgt = GetPlayerPed(v)
		if tgt ~= ped then
			local dist = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(tgt))
			if cDst == -1 or cDst > dist then
				cPly = v
				cDst = dist
			end
		end
	end
	return cPly
end

function WantedPoints(val, doMsg)
  if val then 
    if doMsg then 
      TriggerEvent('chat:addMessage', {args = {
        "CRIME", doMsg
      }})
    end
    wantedPoints = wantedPoints + val
  end
  return wantedPoints
end

function GetActiveZone()
  return activeZone
end

-- DEBUG -
AddEventHandler('onResourceStop', function(rn)
  restarted[rn] = true
end)
-- DEBUG -
AddEventHandler('onResourceStart', function(rn)
  if restarted[rn] then
    TriggerEvent('chat:addMessage', {args={
      "An admin has restarted the "..rn.." resource!"
    }})
    if rn == "cnr_police" then 
      TriggerEvent('chat:addMessage', {args={
        "Any active cops must reduty to continue!"
      }})
    end
    restarted[rn] = nil
  end
end)

function ChatNotification(icon, title, subtitle, message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	SetNotificationMessage(icon, icon, false, 2, title, subtitle, "")
	DrawNotification(false, true)
	PlaySoundFrontend(-1, "GOON_PAID_SMALL", "GTAO_Boss_Goons_FM_SoundSet", 0)
  return true
end

RegisterNetEvent('cnr:chat_notify')
AddEventHandler('cnr:chat_notify', function(icon, title, subt, msg)
  ChatNotification(icon, title, subt, msg)
end)

RegisterNetEvent('cnr:active_zone')
AddEventHandler('cnr:active_zone', function(aZone)
  activeZone = aZone
end)

RegisterCommand('zones', function()
  TriggerEvent('chat:addMessage', {
    color = {0,200,0},
    multiline = false,
    args = {
      "Zone 1",
      "Los Santos (All), LS Airport, Port of L.S., Racetrack, Mirror Park"
    }
  })
  TriggerEvent('chat:addMessage', {
    color = {0,200,0},
    multiline = false,
    args = {
      "Zone 2",
      "Palomino, Tataviam, Senora Desert, Sandy Shores, Harmony, Prison."
    }
  })
  TriggerEvent('chat:addMessage', {
    color = {0,200,0},
    multiline = false,
    args = {
      "Zone 3",
      "Zancudo, Chumash, Great Chaparral, Mount Josiah, Vinewood Hills, Stab City."
    }
  })
  TriggerEvent('chat:addMessage', {
    color = {0,200,0},
    multiline = false,
    args = {
      "Zone 4",
      "Paleto Bay, Mount Chiliad, Chiliad Wilderness, Mount Gordo, Grapeseed."
    }
  })
  local myPos = GetEntityCoords(PlayerPedId())
  local zn    = GetNameOfZone(myPos.x, myPos.y, myPos.z)
  local zName = zoneByName[zn]
  if zName.z then 
    TriggerEvent('chat:addMessage', {
      color = {0,200,0},
      multiline = false,
      args = {
        "Your Position",
        (zName.name).." (Zone #"..(zName.z)..")"
      }
    })
  else
    TriggerEvent('chat:addMessage', {
      color = {0,200,0},
      multiline = false,
      args = {
        "Your Zone",
        "Not located; You might be in the sky, at sea, or in an area unscripted."
      }
    })
  end
end)
