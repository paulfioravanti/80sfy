module SecretConfig.Model exposing (SecretConfig, init)


type alias SecretConfig =
    { overrideInactivityPause : Bool
    , soundCloudPlaylistUrl : String
    , tags : String
    , visible : Bool
    }


init : String -> SecretConfig
init soundCloudPlaylistUrl =
    { overrideInactivityPause = False
    , soundCloudPlaylistUrl = soundCloudPlaylistUrl
    , tags = ""
    , visible = False
    }
