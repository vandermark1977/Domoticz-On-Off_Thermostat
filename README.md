# Domoticz Thermostat with OnOff function for Panasonic heatpump
Simple Domoticz DzVents thermostat for a Panasonic heatpump. 

## Prerequisits:
* You have setup the heatpump with a Heatcurve or direct temperature for the water outlet temperature. The built in thermostat of the Panasonic heatpump must be turned off.
* Script works in combination with the [Domoticz HeishamonMQTT plugin](https://github.com/MarFanNL/HeishamonMQTT/tree/main) and the [HeishaMon communication PCB](https://www.tindie.com/stores/thehognl/)
* In Domoticz you have an accurate room temperature measurement available.

## How does the script work?
When the room temperature gets below the setpoint, the heatpump is turned on. When the room temperature gets above the setpoint it is turned on again.

You can specify a hysteresis in various parts of the script. Adjust these to your own situation. I have a well-isolated house with only floorheating, therefor I have set very small hysteresis in the script.
