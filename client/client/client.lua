local IsNew = false

RegisterNetEvent('kd_interior:SetNewState')
AddEventHandler('kd_interior:SetNewState', function(bool)
	IsNew = bool
end)

function CreateApartmentFurnished(spawn)
	local objects = {}

    local POIOffsets = {}
	POIOffsets.exit = json.decode('{"z":1.7,"y":3.70144140625,"x":3.95089355468,"h":2.2633972168}')
	POIOffsets.clothes = json.decode('{"z":1.2,"y":-2.4444736328,"x":0.534350097,"h":2.2633972168}')
	POIOffsets.stash = json.decode('{"z":1.5,"y":1.95144140625,"x":-0.85089355468,"h":2.2633972168}')
	POIOffsets.kada = json.decode('{"z":1.2,"y":-2.5444736328,"x":-3.854350097,"h":2.2733972168}')
	POIOffsets.covek = json.decode('{"z":1.2,"y":-1.8544736328,"x":-4.354350097,"h":2.4733972168}')
	POIOffsets.wc = json.decode('{"z":1.2,"y":-1.8044736328,"x":-3.204350097,"h":2.4733972168}')
	POIOffsets.umivanje = json.decode('{"z":1.55,"y":-1.6544736328,"x":-2.145350097,"h":4.53972168}')
	POIOffsets.sleepleft = json.decode('{"z":1.25,"y":3.1544736328,"x":-3.945350097,"h":4.53972168}')
	POIOffsets.sleepright = json.decode('{"z":1.25,"y":3.1544736328,"x":-2.845350097,"h":4.53972168}')

	DoScreenFadeOut(500)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
	
	RequestModel(`gabz_pinkcage`)
	while not HasModelLoaded(`gabz_pinkcage`) do
	    Citizen.Wait(3)
	end

	local house = CreateObject(`gabz_pinkcage`, spawn.x, spawn.y, spawn.z, false, false, false)
    FreezeEntityPosition(house, true)
	table.insert(objects, house)

	TeleportToInterior(spawn.x - 3.95089355468, spawn.y - 3.60144140625, spawn.z + 1.1, POIOffsets.exit.h)

	if IsNew then
		SetTimeout(750, function()
			IsNew = false
		end)
	end
	
    return { objects, POIOffsets }
end

function DespawnInterior(objects, cb)
    Citizen.CreateThread(function()
        for k, v in pairs(objects) do
            if DoesEntityExist(v) then
                DeleteEntity(v)
            end
        end

        cb()
    end)
end

function TeleportToInterior(x, y, z, h)
    Citizen.CreateThread(function()
        SetEntityCoords(PlayerPedId(), x, y, z, 0, 0, 0, false)
        SetEntityHeading(PlayerPedId(), h)

        Citizen.Wait(100)

        DoScreenFadeIn(1000)
    end)
end

function getRotation(input)
    return 360 / (10 * input)
end
