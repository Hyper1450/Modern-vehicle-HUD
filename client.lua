local function convertPosition(pos)
    local map = {
        left = 'flex-start',
        center = 'center',
        right = 'flex-end',
        top = 'flex-start',
        middle = 'center',
        bottom = 'flex-end'
    }
    return {
        horizontal = map[pos.horizontal] or 'flex-end',
        vertical = map[pos.vertical] or 'flex-end'
    }
end

local uiPos = convertPosition(Config.Position)

local function getSpeedValue(speed)
    if Config.SpeedUnit == 'mph' then
        return speed * 2.236936, 'MPH'
    else
        return speed * 3.6, 'KM/H'
    end
end

local function getFuelLevel(veh)
    local fuelSystem = Config.FuelSystem
    if fuelSystem == 'nd_fuel' and exports['nd_fuel'] then
        return exports['nd_fuel']:GetFuel(veh)
    elseif fuelSystem == 'legacy' and exports['LegacyFuel'] then
        return exports['LegacyFuel']:GetFuel(veh)
    elseif fuelSystem == 'esx' and GetResourceState('es_extended') == 'started' then
        return GetVehicleFuelLevel(veh)
    elseif fuelSystem == 'qb' and GetResourceState('qb-core') == 'started' then
        return GetVehicleFuelLevel(veh)
    else
        return GetVehicleFuelLevel(veh)
    end
end

local lastSpeed = 0
local isInVehicle = false

CreateThread(function()
    while true do
        Wait(50)
        local player = PlayerPedId()
        if IsPedInAnyVehicle(player, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(player, false), -1) == player then
            local veh = GetVehiclePedIsIn(player, false)
            local rawSpeed = GetEntitySpeed(veh)
            local fuel = math.floor(getFuelLevel(veh))
            local gear = GetVehicleCurrentGear(veh)
            local smoothSpeed = (rawSpeed + lastSpeed) / 2
            lastSpeed = rawSpeed

            local speed, unit = getSpeedValue(smoothSpeed)
            speed = math.floor(speed + 0.5)

            SendNUIMessage({
                type = "updateHud",
                speed = speed,
                gear = gear,
                fuel = fuel,
                unit = unit,
                show = true,
                pos = uiPos
            })
        else
            if isInVehicle then
                SendNUIMessage({ type = "updateHud", show = false })
            end
        end
        isInVehicle = IsPedInAnyVehicle(player, false)
    end
end)


-- Disable GTA default location and street names display
CreateThread(function()
    while true do
        Wait(50)
                    end
end)



CreateThread(function()
    while true do
        Wait(50)
        local player = PlayerPedId()
        if IsPedInAnyVehicle(player, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(player, false), -1) == player then
            local veh = GetVehiclePedIsIn(player, false)
            local rawSpeed = GetEntitySpeed(veh)
            local fuel = math.floor(getFuelLevel(veh))
            local gear = GetVehicleCurrentGear(veh)
            local smoothSpeed = (rawSpeed + lastSpeed) / 2
            lastSpeed = rawSpeed

            local speed, unit = getSpeedValue(smoothSpeed)
            speed = math.floor(speed + 0.5)

            SendNUIMessage({
                type = "updateHud",
                speed = speed,
                gear = gear,
                fuel = fuel,
                unit = unit,
                show = true,
            })
        else
            SendNUIMessage({ type = "updateHud", show = false })
        end
    end
end)

-- Fully disable GTA default location and street name HUD
CreateThread(function()
    while true do
        Wait(0)
        HideHudComponentThisFrame(6)  -- Vehicle name
        HideHudComponentThisFrame(7)  -- Area name
        HideHudComponentThisFrame(9)  -- Street name
    end
end)
