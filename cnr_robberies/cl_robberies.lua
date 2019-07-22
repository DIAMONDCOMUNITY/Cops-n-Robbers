
--[[
  Cops and Robbers: Convenience Robberies (CLIENT)
  Created by Michael Harris (mike@harrisonline.us)
  07/19/2019
  
  This file contains the functionality to rob stores. This is not for heists,
  bank robberies, or other major events, but rather for holding up gas stations,
  bars, nightclubs, and similar.
  
  Permission is granted only for executing this script for the purposes
  of playing the gamemode as intended by the developer.
--]]

RegisterNetEvent('cnr:robbery_lock_status')
RegisterNetEvent('cnr:robbery_locks')

local isRobbing = false

RegisterCommand('rob', function()
  
end)

RegisterCommand('.debug2', function(s,a,r)
  TaskStartScenarioInPlace(PlayerPedId(), tostring(a[1]), 0, true)
end)

RegisterCommand('.debug', function(s,a,r)
  local dict = tostring(a[1])
  local anim = tostring(a[2])
  local flag = tonumber(a[3])
  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do
    Wait(10)
  end
  TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, 1.0, (-1), flag, 0, 0, 0, 0)
end)

RegisterCommand('.stopanim', function()
  ClearPedTasksImmediately(PlayerPedId())
  ClearPedSecondaryTask(PlayerPedId())
end)

function SpawnStoreClerk(n)
  if n then
  if rob[n] then
  if rob[n].spawn then 
    if not rob[n].clerk then 
      local i        = clerkModels[math.random(#clerkModels)]
      local mdl      = GetHashKey(i)
      local loadTime = GetGameTimer() + 5000
      RequestModel(mdl)
      while not HasModelLoaded(mdl) do
        Wait(10)
        if GetGameTimer() > loadTime then 
          print("DEBUG - Failed to load ped model ("..tostring(i)..")")
          break
        end
      end
      rob[n].clerk = CreatePed(PED_TYPE_MISSION,mdl,rob[n].spawn,rob[n].h,0,0)
      Citizen.CreateThread(function()
        while rob[n].clerk do 
          if not DoesEntityExist(rob[n].clerk) then
            print("DEBUG - Clerk ceased to exist.")
            rob[n].clerk = nil
            Citizen.Wait(30000)
          else
            if IsPedDeadOrDying(rob[n].clerk) then
              print("DEBUG - Ped died.")
              Citizen.Wait(30000)
              rob[n].clerk = nil
            elseif #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(rob[n].clerk)) > 500.0 then 
              print("DEBUG - Too far away. Clerk despawned.")
              DeletePed(rob[n].clerk)
              rob[n].clerk = nil
            end
          end
          Citizen.Wait(1000)
        end
      end)
      return true
    end
  else print("DEBUG - No spawn point exists.")
  end
  else print("DEBUG - No such store exists ("..n..").")
  end
  else print("DEBUG - No 'n' given.")
  end
  return false
end


function StartRobbery(n)
  local attack = false
  local take = 0
  TriggerServerEvent('cnr:robbery_send_lock', n)
  exports['cnrobbers']:WantedPoints(30, "Brandishing a Firearm (417 PC)")
  rob[n].lockout = true
  Citizen.CreateThread(function()
    while isRobbing do 
      SetBlockingOfNonTemporaryEvents(rob[n].clerk, true)
      Citizen.Wait(0)
    end
    Wait(10)
    if not attack then
      TaskReactAndFleePed(rob[n].clerk, PlayerPedId())
    end
  end)
  local dict = "random@mugging3"
  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do Wait(1) end
  TaskPlayAnim(rob[n].clerk, dict, "handsup_standing_base", 8.0, 1.0, 2000, 2, 1.0, 0, 0, 0)
  Citizen.Wait(2000)
  local dct2 = "random@shop_robbery"
  RequestAnimDict(dct2)
  while not HasAnimDictLoaded(dct2) do Wait(1) end
  local choice = math.random(1, 100) > 90
  if choice then
    attack = true
    GiveWeaponToPed(rob[n].clerk, GetHashKey("WEAPON_PISTOL50"), 24, true, true)
    TaskPlayAnim(rob[n].clerk, dct2, "robbery_action_a", 8.0, 1.0, 1200, 0, 1.0, 0, 0, 0)
    Citizen.Wait(800)
    isRobbing = false
    TaskCombatPed(rob[n].clerk, PlayerPedId(), 0, 16)
  else
    TaskPlayAnim(rob[n].clerk, dct2, "robbery_action_f", 8.0, 1.0, (-1), 3, 1.0, 0, 0, 0)
    local maxTime = GetGameTimer() + 9800
    while IsPlayerFreeAiming(PlayerId()) do 
      take = take + math.random(5,30)
      if GetGameTimer() > maxTime then 
        break
      end
      Wait(100)
    end
    exports['cnrobbers']:WantedPoints(50, "Armed Robbery (211 PC)")
    if take > 0 then 
      print("DEBUG - Robbery Take: $"..take)
      SetPedComponentVariation(PlayerPedId(), 5, 45, 0, 0)
    end
    isRobbing = false
    TriggerServerEvent('cnr:robbery_take', take)
  end
end


function CreateRobberyClerks()
  print("DEBUG - Creating clerks and checking for robbery.")
  Citizen.CreateThread(function()
    while true do 
      local ped   = PlayerPedId()
      local myPos = GetEntityCoords(PlayerPedId())
      for k,v in pairs(rob) do 
        if not v.clerk then 
          if #(myPos - v.stand) < 100.0 then
            if SpawnStoreClerk(k) then print("DEBUG - Successful.")
            else print("DEBUG - Failed to create clerk for store #"..k)
            end
          end
        end
      end
      if not isRobbing then
        local isAim, ent = GetEntityPlayerIsFreeAimingAt(PlayerId())
        if isAim and IsEntityAPed(ent) then 
          for k,v in pairs(rob) do
            if not v.lockout then
              if ent == v.clerk then 
                isRobbing = true
                StartRobbery(k)
              end
            else
              TriggerEvent('chat:addMessage', {args = {
                "COOLDOWN", "Recently Robbed - The register is empty!"
              }})
              Citizen.Wait(5000)
            end
          end
        end
      end
      Citizen.Wait(0)
    end
  end)
end
AddEventHandler('cnr:loaded', CreateRobberyClerks)
RegisterCommand('dbugrob', CreateRobberyClerks)

--- EVENT cnr:robbery_lock_status
-- Tells the client that a lock status for store (n) has changed
AddEventHandler('cnr:robbery_lock_status', function(n, lockStatus)
  rob[n].lockout = true
end)

--- EVENT cnr:robbery_locks 
-- Tells the client the lock status of all robbery events
-- Received when loaded into the game
AddEventHandler('cnr:robbery_locks', function(locks)
  for k,v in pairs (locks) do 
    rob[k].lockout = v
  end
end)


