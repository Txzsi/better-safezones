config = {}

config.distance = 50.0
config.reduceVehicleSpeed = true -- reduce a players vehicles speed to the set value below if they're in a safe zone
config.vehicleSpeed = 30 -- the speed vehicles will go in a safezone 

config.locations = {
    vector3(2016.02, 3753.85, 32.34)

}

config.text = {
    enabled = true,
    screenCoords = { x = 0.890, y = 0.050 }, -- text coords
    textSize = 0.30,
    enteredZone = 'You have entered a safe zone!',
    displayText = 'You are in a safezone!'

}

config.framework = {
    enabled = false, -- enable NAT2K15 framework department bypass? 
    resourceName = 'framework',
    bypassLevels = {
        'bcso_level',
        'lspd_level'
    }
}

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end
