Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

function Craft()
    local mainMenu = RageUI.CreateMenu("", "Craft : "..label)
    local open,load,fermerlemenu,chargement = false,false,false,0
    mainMenu.Closed = function() open = false end
    if not open then open = true RageUI.Visible(mainMenu, true) 
        Citizen.CreateThread(function()
            while open do
                if fermerlemenu then mainMenu.Closable = false else mainMenu.Closable = true end
                RageUI.IsVisible(mainMenu, function()
                    if typedecraft == 'objets' then
                        if not load then
                            RageUI.Separator("↓ "..color.."Objets à Fabriquer ~s~↓")
                            for k,v in pairs(objets) do
                                RageUI.Button(v.label, color.."Ingrédients :\n~s~- "..v.ingredients1.label.."\n- "..v.ingredients2.label, {RightLabel = "→"}, true, {
                                    onSelected = function()
                                        item = v.label
                                        nameitem = v.name
                                        ing1 = v.ingredients1.name
                                        ing2 = v.ingredients2.name
                                        load = true
                                        FreezeEntityPosition(GetPlayerPed(-1), true)
                                        ESX.Streaming.RequestAnimDict(anim1, function()
                                            TaskPlayAnim(GetPlayerPed(-1), anim1, anim2, 8.0, -8.0, -1, 51, 0, false, false, false)
                                            RemoveAnimDict(anim1)
                                        end)
                                    end
                                })
                            end
                        else
                            RageUI.Button(item, nil, {}, false, {})
                            RageUI.PercentagePanel(chargement, "Fabrication: "..color..""..math.floor(chargement * 100).."%", "", "", {})
                            if chargement < 1.0 then
                                chargement = chargement + 0.002
                                fermerlemenu = true
                            else 
                                chargement = 0 
                            end
                            if chargement >= 1.0 then
                                ClearPedTasksImmediately(GetPlayerPed(-1))
                                ESX.Streaming.RequestAnimDict("move_m@_idles@shake_off", function()
                                    TaskPlayAnim(GetPlayerPed(-1), "move_m@_idles@shake_off", "shakeoff_1", 8.0, -8.0, -1, 51, 0, false, false, false)
                                    RemoveAnimDict("move_m@_idles@shake_off")
                                end)
                                TriggerServerEvent('craft:craftitem', item, nameitem, ing1, ing2, color)
                                Wait(2000)
                                ClearPedTasksImmediately(GetPlayerPed(-1))
                                FreezeEntityPosition(GetPlayerPed(-1), false)
                                chargement = 0
                                load = false
                                fermerlemenu = true
                                RageUI.CloseAll()
                                open = false
                            end
                        end
                    elseif typedecraft == 'armes' then
                        if not load then
                            RageUI.Separator("↓ "..color.."Armes à Fabriquer ~s~↓")
                            for k,v in pairs(armes) do
                                RageUI.Button(v.label, color.."Ingrédients :\n~s~- "..v.ingredients1.label.."\n- "..v.ingredients2.label, {RightLabel = "→"}, true, {
                                    onSelected = function()
                                        arme = v.label
                                        namearme = v.name
                                        ing1 = v.ingredients1.name
                                        ing2 = v.ingredients2.name
                                        load = true
                                        FreezeEntityPosition(GetPlayerPed(-1), true)
                                        ESX.Streaming.RequestAnimDict(anim1, function()
                                            TaskPlayAnim(GetPlayerPed(-1), anim1, anim2, 8.0, -8.0, -1, 51, 0, false, false, false)
                                            RemoveAnimDict(anim1)
                                        end)
                                    end
                                })
                            end
                        else
                            RageUI.Button(arme, nil, {}, false, {})
                            RageUI.PercentagePanel(chargement, "Fabrication: "..color..""..math.floor(chargement * 100).."%", "", "", {})
                            if chargement < 1.0 then
                                chargement = chargement + 0.002 
                                fermerlemenu = true
                            else 
                                chargement = 0 
                            end
                            if chargement >= 1.0 then
                                ClearPedTasksImmediately(GetPlayerPed(-1))
                                ESX.Streaming.RequestAnimDict("move_m@_idles@shake_off", function()
                                    TaskPlayAnim(GetPlayerPed(-1), "move_m@_idles@shake_off", "shakeoff_1", 8.0, -8.0, -1, 51, 0, false, false, false)
                                    RemoveAnimDict("move_m@_idles@shake_off")
                                end)
                                TriggerServerEvent('craft:craftarme', arme, namearme, ing1, ing2, color)
                                Wait(2000)
                                ClearPedTasksImmediately(GetPlayerPed(-1))
                                FreezeEntityPosition(GetPlayerPed(-1), false)
                                chargement = 0
                                load = false
                                fermerlemenu = true
                                RageUI.CloseAll()
                                open = false
                            end
                        end
                    end
                end)
            Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    for k,v in pairs(Config.Craft.Objets) do
        if v.blip.activer then
            local blip = AddBlipForCoord(v.pos)
            SetBlipSprite(blip, v.blip.sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, v.blip.scale)
            SetBlipColour(blip, v.blip.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(v.blip.name)
            EndTextCommandSetBlipName(blip)
        end
    end
    for k,v in pairs(Config.Craft.Armes) do
        if v.blip.activer then
            local blip = AddBlipForCoord(v.pos)
            SetBlipSprite(blip, v.blip.sprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, v.blip.scale)
            SetBlipColour(blip, v.blip.color)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(v.blip.name)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
    	local wait = 900
    	for k,v in pairs(Config.Craft.Objets) do
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(coords.x, coords.y, coords.z, v.pos)
            if dist <= 5.0 then 
                wait = 0
                DrawMarker(v.marker.type, v.pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, v.marker.r, v.marker.g, v.marker.b, v.marker.a, false, true, p19, false)
                if dist <= 0.8 then 
                    wait = 0
                    ESX.ShowHelpNotification("~INPUT_TALK~ pour "..v.color..""..v.indication)
                    if IsControlJustPressed(1, 51) then
                        label = v.label
                        color = v.color
                        objets = v.objets
                        anim1 = v.animation.anim1
                        anim2 = v.animation.anim2
                        typedecraft = 'objets'
                        Craft()
                    end
                end
            end
		end
    Citizen.Wait(wait)
	end
end)

Citizen.CreateThread(function()
    while true do
    	local wait = 900
        for k,v in pairs(Config.Craft.Armes) do
            local coords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(coords.x, coords.y, coords.z, v.pos)
            if dist <= 5.0 then 
                wait = 0
                DrawMarker(v.marker.type, v.pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, v.marker.r, v.marker.g, v.marker.b, v.marker.a, false, true, p19, false)
                if dist <= 0.8 then 
                    wait = 0
                    ESX.ShowHelpNotification("~INPUT_TALK~ pour "..v.color..""..v.indication)
                    if IsControlJustPressed(1, 51) then
                        label = v.label
                        color = v.color
                        armes = v.armes
                        anim1 = v.animation.anim1
                        anim2 = v.animation.anim2
                        typedecraft = 'armes'
                        Craft()
                    end
                end
            end
        end
    Citizen.Wait(wait)
    end
end)