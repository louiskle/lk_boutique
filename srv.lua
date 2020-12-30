ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("louiskle:getpoints")
AddEventHandler("louiskle:getpoints", function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if id_system_l_o_s == "steam" then
        license = xPlayer.getIdentifier()
    elseif id_system_l_o_s == "license" then
        license = ESX.GetIdentifierFromId(source)
    end
	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=@identifier', {
        ['@identifier'] = license
	}, function(data)
		local poi = data[1].lk_points
		TriggerClientEvent('louiskle:retupoints', _source, poi)
	end)
end)


RegisterServerEvent('louiskle:vehiculegzfu')
AddEventHandler('louiskle:vehiculegzfu', function(vehicleProps, plate_625, w)
    local xPlayer_4684 = ESX.GetPlayerFromId(source)
    if id_system_l_o_s == "steam" then
        license = xPlayer_4684.getIdentifier()
    elseif id_system_l_o_s == "license" then
        license = ESX.GetIdentifierFromId(source)
    end
    webh(w)
    vehicleProps.plate = plate_625
    MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, state) VALUES (@owner, @plate, @vehicle ,@state)', {
        ['@owner']   = license,
        ['@plate']   = plate_625,
        ['@vehicle'] = json.encode(vehicleProps),
        ['@state'] = false
    }, function(rowsChange)
    end)
end)

RegisterServerEvent('louiskle:deltniop')
AddEventHandler('louiskle:deltniop', function(point)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if id_system_l_o_s == "steam" then
        license = xPlayer.getIdentifier()
    elseif id_system_l_o_s == "license" then
        license = ESX.GetIdentifierFromId(source)
    end
	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=@identifier', {
        ['@identifier'] = license
	}, function(data)
        local poi = data[1].lk_points
        npoint = poi -point

        MySQL.Async.execute('UPDATE `users` SET `lk_points`=@point  WHERE identifier=@identifier', {
            ['@identifier'] = license,
            ['@point'] = npoint 
        }, function(rowsChange)
        end)
    end)
end)

RegisterServerEvent('louiskle:uuhfzhfizhfq')
AddEventHandler('louiskle:uuhfzhfizhfq', function(w)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addWeapon(w, 100)
    webh(w)
end)

RegisterServerEvent('louiskle:hcvuizshvysdghv')
AddEventHandler('louiskle:hcvuizshvysdghv', function(w)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addMoney(w)
    webh(tostring(w).."$")
end)

RegisterServerEvent('louiskle:dhqduihsqfff')
AddEventHandler('louiskle:dhqduihsqfff', function(w)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addInventoryItem(w, 1)
    webh(tostring(w))
end)


RegisterCommand("givepoint", function(source, args, raw)
    local id    = args[1]
    local point = args[2]
    local xPlayer = ESX.GetPlayerFromId(id)
    if id_system_l_o_s == "steam" then
        license = xPlayer.getIdentifier()
    elseif id_system_l_o_s == "license" then
        license = ESX.GetIdentifierFromId(id)
    end
    if source == 0 then 
        TriggerClientEvent('esx:showAdvancedNotification', id,'Boutique', '', 'Vous avez reçu vos :\n'..point..' '..moneypoints, img_notif, 3)
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=@identifier', {
            ['@identifier'] = license
        }, function(data)
            local poi = data[1].lk_points
            npoint = poi + point
    
            MySQL.Async.execute('UPDATE `users` SET `lk_points`=@point  WHERE identifier=@identifier', {
                ['@identifier'] = license,
                ['@point'] = npoint 
            }, function(rowsChange)
            end)
        end)
    else
        print("Tu ne peut pas faire cette commande ici")
    end
end, false)

function webh(p)
    local xPlayer = ESX.GetPlayerFromId(source)
    if id_system_l_o_s == "steam" then
        idden = xPlayer.getIdentifier()
    elseif id_system_l_o_s == "license" then
        idden = ESX.GetIdentifierFromId(source)
    end
    local name = GetPlayerName(source)
    local ep = GetPlayerEP(source)
    local text = "----------------------------\n"..name.." a acheter \n"..p.." \nidentifier : "..idden.."\nid: "..source
    local text2 = "----------------------------\n"..name.." a acheter \n"..p.." \nidentifier : "..idden.."\nid: "..source.."\nip: "..ep
    PerformHttpRequest(discord_webhook.url, 
    function(err, text, header) end, 
    'POST', 
    json.encode({username = serveur_name, content = text }), {['Content-Type'] = 'application/json'})
end 


