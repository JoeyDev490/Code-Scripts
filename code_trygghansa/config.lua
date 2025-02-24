Config = {}

-- Framework Base Name (Adjust based on your framework)
Config.BaseName = "core"

-- Job Name Required to Access the Panel
Config.JobName = "none" -- None to allow everyone to access


Config.Tablet = {
    Enabled = true, -- Set to false if you don't want the animation
    Dict = "amb@code_human_in_bus_passenger_idles@female@tablet@base",
    Anim = "base",
    Prop = `prop_cs_tablet`,
    Bone = 60309,
    Offset = vector3(0.03, 0.002, -0.0),
    Rotation = vector3(10.0, 160.0, 0.0)
}

-- Notification Messages
Config.Notifications = {
    OpenPanel = {
        title = "Insurance Panel",
        description = "Welcome to the Insurance Panel!",
        type = "success",
        position = "top"
    },

    ClosePanel = {
        title = "Insurance Panel",
        description = "Trygghansa Panel Has Been Closed!",
        type = "error",
        position = "top"
    },

    NoJobAccess = {
        title = "Access Denied",
        description = "You do not work here!",
        type = "error",
        position = "top"
    },

    VehicleNotFound = {
        title = "Vehicle Not Found",
        description = "The vehicle with plate {plate} was not found.",
        type = "error",
        position = "top-center"
    },

    InsuranceAdded = {
        title = "Insurance Added",
        description = "The vehicle with plate {plate} has been insured.",
        type = "success",
        position = "top-center"
    },

    AlreadyInsured = {
        title = "Already Insured",
        description = "The vehicle with plate {plate} is already insured.",
        type = "error",
        position = "top-center"
    },

    InsuranceRemoved = {
        title = "Insurance Removed",
        description = "The vehicle with plate {plate} is no longer insured.",
        type = "warning",
        position = "top-center"
    },

    NotInsured = {
        title = "Not Insured",
        description = "The vehicle with plate {plate} is already not insured.",
        type = "error",
        position = "top-center"
    }
}
