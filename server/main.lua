ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addGroupCommand', 'ko', 'admin', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			print(('knockout: %s used admin ko'):format(GetPlayerIdentifiers(source)[1]))
			TriggerClientEvent('knockout:ko', tonumber(args[1]))
		end
	else
		TriggerClientEvent('knockout:ko', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, { help = 'KO', params = {{ name = 'id' }} })

TriggerEvent('es:addGroupCommand', 'unko', 'admin', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			print(('knockout: %s used admin unko'):format(GetPlayerIdentifiers(source)[1]))
			TriggerClientEvent('knockout:unko', tonumber(args[1]))
		end
	else
		TriggerClientEvent('knockout:unko', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, { help = 'Cancel KO', params = {{ name = 'id' }} })
