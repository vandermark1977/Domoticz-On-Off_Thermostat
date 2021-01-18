--[[
 Author 		: BazemanKM
 Adjusted       : Vandermark1977
 Description 	: This script is a simple on/off thermostat based on the roomtemperature, a setpoint and a hysteresis. 
]]--

return {
   on = {
        timer = {'every 10 minutes'
                }
         },

        logging = {
            level = domoticz.LOG_DEBUG, -- LOG_DEBUG or LOG_ERROR
            marker = "WP: Thermostaat [ Script ]"
        },

    execute = function(domoticz, item)

        local setPointId = 146          -- Dummy thermostaat device
        local roomTemperatureId = 42    -- Temperature measuring device
        local wpSwitchId = 60           -- Heatpump_State
        local setPoint = domoticz.utils.round(domoticz.devices(setPointId).setPoint, 2)

        -- script default values settings
        local roomTemperature = tonumber(domoticz.devices(roomTemperatureId).rawData[1])

        domoticz.log('setpoint temperatuur: ' .. setPoint .. ' oC ', domoticz.LOG_DEBUG)

        if (roomTemperature > (setPoint + 0.2)) then
                domoticz.devices(wpSwitchId).switchOff()
            end
        elseif (roomTemperature < (setPoint - 0.2)) then
                domoticz.devices(wpSwitchId).switchOn()
            end
        end

        domoticz.devices(setPointId).updateSetPoint(setPoint) -- update dummy sensor in case of red indicator ;-)

        domoticz.log('WP status: ' .. wpState, domoticz.LOG_DEBUG)

    end
}
