--[[
Author      :	BazemanKM
Adjusted    : Vandermark1977
Description : This script is a simple on/off thermostat based on the roomtemperature, a setpoint and a hysteresis. 
]]--

return {
   on = {
        timer = {
                   'every 1 minutes'
                }
         },

        logging = {
            level = domoticz.LOG_DEBUG, -- LOG_DEBUG or LOG_ERROR
            marker = "Thermostaat: "
        },

    execute = function(domoticz, item)

        -- set to true if you want to swtich on/off the heater
        local switchWp = true

        local setPointId = 146          -- Dummy thermostaat device
        local roomTemperatureId = 42
        local wpSwitchId = 60           -- Heatpump_State
        local shiftId = 82             -- Z1_Heat_Request_Temp

        local setPoint = domoticz.utils.round(domoticz.devices(setPointId).setPoint, 2)

        -- script default values settings
        local roomTemperature = tonumber(domoticz.devices(roomTemperatureId).rawData[1])
        local wpState = 1
        local shift = 0
        local wpSetpointDevice = domoticz.devices(shiftId)

        if (roomTemperature > (setPoint + 0.2)) then
            if (true == switchWp) then
                wpState = 1 -- only disable the state when the WP will be switched off
                domoticz.devices(wpSwitchId).switchOff()
            end
        elseif (roomTemperature < (setPoint - 0.2)) then
            if (true == switchWp) then
                domoticz.devices(wpSwitchId).switchOn()
            end
        end

        domoticz.devices(setPointId).updateSetPoint(setPoint) -- update dummy sensor in case of red indicator ;-)

        domoticz.log('WP status: ' .. wpState, domoticz.LOG_DEBUG)
        domoticz.log('Doel temperatuur: ' .. setPoint .. ' oC ', domoticz.LOG_DEBUG)
        domoticz.log('Woonkamer temperatuur: ' .. roomTemperature .. ' oC ', domoticz.LOG_DEBUG)
    end
}
