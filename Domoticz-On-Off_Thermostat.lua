--[[
Based on original script with shift function: https://github.com/CrazyICT/panasonic-virtual-thermostat
Author      : CrazyICT
Adjusted    : Vandermark1977
Description : This script is a simple on/off thermostat based on the roomtemperature, a setpoint and a hysteresis. 
               A notification is sent when heater is turned on or off
]]--

return {
   on = {
        timer = {
                   'every 10 minutes'
                }
         },

        logging = {
            level = domoticz.LOG_DEBUG, -- LOG_DEBUG or LOG_ERROR
            marker = "Thermostaat: "
        },

    execute = function(domoticz, item)

        local switchWp = true           -- set to true if you want to swtich on/off the heater
        local setPointId = 146          -- Dummy thermostaat device
        local roomTemperatureId = 42    -- Temperature measurement
        local wpSwitchId = 60           -- Heatpump_State
        local setPoint = domoticz.utils.round(domoticz.devices(setPointId).setPoint, 2)

        -- script default values settings
        local roomTemperature = tonumber(domoticz.devices(roomTemperatureId).rawData[1])


        if ((roomTemperature > (setPoint + 0.2)) and (domoticz.devices(wpSwitchId).state == 'On')) then
            if (true == switchWp) then
                domoticz.devices(wpSwitchId).switchOff()
                domoticz.notify('De warmtepomp is uitgezet door de thermostaat')
                domoticz.log('WP UIT gezet: Temperatuur binnen is: '.. roomTemperature .. ' oC en doeltemperatuur is: '  .. setPoint .. ' oC ', domoticz.LOG_DEBUG)
            end
        elseif ((roomTemperature < (setPoint - 0.2)) and (domoticz.devices(wpSwitchId).state == 'Off')) then
            if (true == switchWp) then
                domoticz.devices(wpSwitchId).switchOn()
                domoticz.notify('De warmtepomp is aangezet door de thermostaat')
                domoticz.log('WP AAN gezet: Temperatuur binnen is: '.. roomTemperature .. ' oC en doeltemperatuur is: '  .. setPoint .. ' oC ', domoticz.LOG_DEBUG)
            end
        elseif (roomTemperature > (setPoint - 0.2)) and (roomTemperature < (setPoint + 0.2)) then
             if (true == switchWp) then
                domoticz.log('WP niet veranderd: Temperatuur binnen is: '.. roomTemperature .. ' oC en doeltemperatuur is: '  .. setPoint .. ' oC ', domoticz.LOG_DEBUG)
            end    
        end

        domoticz.devices(setPointId).updateSetPoint(setPoint) -- update dummy sensor in case of red indicator ;-)

    end
}
