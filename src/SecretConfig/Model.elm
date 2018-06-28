module SecretConfig.Model exposing (SecretConfig, init)


type alias SecretConfig =
    { gifDisplaySeconds : String
    , overrideInactivityPause : Bool
    , soundCloudPlaylistUrl : String
    , tags : String
    , visible : Bool
    }


init : String -> Float -> SecretConfig
init soundCloudPlaylistUrl gifDisplaySeconds =
    { gifDisplaySeconds = toString gifDisplaySeconds
    , overrideInactivityPause = False
    , soundCloudPlaylistUrl = soundCloudPlaylistUrl
    , tags = ""
    , visible = False
    }
