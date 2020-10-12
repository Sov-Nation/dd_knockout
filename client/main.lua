ESX              	= nil
local PlayerData 	= {}
local knockedOut 	= false
local wait 			= 30
local lowHealth 	= false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), Config.Unarmed)
		SetWeaponDamageModifier(GetHashKey("WEAPON_FLASHLIGHT"), Config.Flashlight)
		SetWeaponDamageModifier(GetHashKey("WEAPON_KNUCKLE"), Config.BrassKnuckles)
		SetWeaponDamageModifier(GetHashKey("WEAPON_HATCHET"), Config.Hatchet)
		SetWeaponDamageModifier(GetHashKey("WEAPON_MACHETE"), Config.Machete)
		SetWeaponDamageModifier(GetHashKey("WEAPON_SWITCHBLADE"), Config.Switchblade)
		SetWeaponDamageModifier(GetHashKey("WEAPON_BOTTLE"), Config.Bottle)
		SetWeaponDamageModifier(GetHashKey("WEAPON_DAGGER"), Config.Dagger)
		SetWeaponDamageModifier(GetHashKey("WEAPON_POOLCUE"), Config.Poolcue)
		SetWeaponDamageModifier(GetHashKey("WEAPON_WRENCH"), Config.Wrench)
		SetWeaponDamageModifier(GetHashKey("WEAPON_BATTLEAXE"), Config.Battleaxe)
		SetWeaponDamageModifier(GetHashKey("WEAPON_KNIFE"), Config.Knife)
		SetWeaponDamageModifier(GetHashKey("WEAPON_NIGHTSTICK"), Config.Nightstick)
		SetWeaponDamageModifier(GetHashKey("WEAPON_HAMMER"), Config.Hammer)
		SetWeaponDamageModifier(GetHashKey("WEAPON_BAT"), Config.Bat)
		SetWeaponDamageModifier(GetHashKey("WEAPON_GOLFCLUB"), Config.Golfclub)
		SetWeaponDamageModifier(GetHashKey("WEAPON_CROWBAR"), Config.Crowbar)
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1000)
		local myPed = PlayerPedId()

		if GetEntityHealth(myPed) < 125 then
			wait = 30
			knockedOut = true
			lowHealth = true
		elseif GetEntityHealth(myPed) > 125 then
			lowHealth = false
		end
		if knockedOut then
			DisableAllControlActions(0)
			EnableControlAction(0, 1, true) -- Pan
			EnableControlAction(0, 2, true) -- Tilt
			EnableControlAction(0, 0, true) -- V
			EnableControlAction(0, 26, true) -- C
			EnableControlAction(2, 199, true) -- Esc
			EnableControlAction(0, 245, true) -- T
			EnableControlAction(0, 246, true) -- Y
			SetPlayerHealthRechargeMultiplier((myPed), 1.0)
			SetPedToRagdoll(myPed, 2000, 2000, 0, 0, 0, 0)
			ResetPedRagdollTimer(myPed)
			ShowNotification("~r~You have passed out!")
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		while not lowHealth and wait > 0 do
			Wait(1000)
			wait = wait - 1
			if wait == 0 then
				TriggerEvent('knockout:unko', 0)
			end
		end
	end
end)

function unko(t)
	if knockedOut then
		Wait(t*1000)
		knockedOut = false
	end
end

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

RegisterNetEvent('knockout:unko')
AddEventHandler('knockout:unko', function(t)
	if t == nil then
		t = 0
	end
	unko(t)
end)

RegisterNetEvent('knockout:ko')
AddEventHandler('knockout:ko', function()
	wait = 30
	knockedOut = true
end)
